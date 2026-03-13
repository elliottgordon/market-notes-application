class InsightGenerator
  def self.generate_for_user(user)
    notes = user.notes.order(market_date: :desc).limit(20)

    return if notes.empty?

    # Build the notes text to send to OpenAI
    notes_text = notes.map do |note|
      "Title: #{note.title}\nDate: #{note.market_date}\nBody: #{note.body}\n"
    end.join("\n---\n")

    # Set up the AI chat with Prepend.me proxy
    chat = AI::Chat.new
    chat.proxy = true
    chat.model = "gpt-5-nano"

    # Include existing insights so the AI avoids duplicates
    existing_insights = user.insights.order(created_at: :desc).limit(10)
    existing_text = ""
    if existing_insights.any?
      existing_text = "\nThe user already has these insights — DO NOT duplicate or restate these:\n"
      existing_insights.each do |ei|
        existing_text += "- [#{ei.category}] #{ei.title}\n"
      end
    end

    system_prompt = <<~PROMPT
      <role>
      You are an institutional Macro Strategist and Quantitative Pattern Synthesizer. The user is an advanced market participant who writes daily notes capturing market observations, macro data points, volatility dynamics, and trade ideas.
      </role>

      <objective>
      Your objective is NOT to summarize individual notes. You must synthesize ACROSS multiple notes to identify hidden alpha, structural market shifts, cross-asset correlations, and emergent risks that span multiple days of observations.
      </objective>

      <rules>
      1. MULTI-NOTE SYNTHESIS: Every insight must draw from at least TWO distinct notes/dates. Single-note summaries will be rejected.
      2. ADVANCED AUDIENCE: Do NOT explain basic financial terminology. Assume deep knowledge of macroeconomics, quantitative finance, and trading mechanics. Focus on second-order effects and structural changes.
      3. QUALITY OVER QUANTITY: Generate exactly 1 to 4 high-conviction insights. Do not force insights if the notes do not support them.
      4. NO DUPLICATES: Do not restate or rephrase insights the user already has.
      </rules>

      <categories>
      Classify each insight strictly into one of the following:
      - trend: A directional macro or micro pattern building momentum over multiple observations.
      - trade opportunity: A specific, actionable asymmetric setup or relative value trade with a clear thesis.
      - risk alert: An underpriced tail risk, crowding danger, or vulnerability implied by the notes.
      - correlation: A newly formed or breaking linkage between cross-asset classes (e.g., rates vs. tech valuations, FX vs. commodities).
      - anomaly: A structural break from historical market behavior or a glaring contradiction between price action and fundamentals.
      </categories>

      <output_structure>
      For each insight body, structure it exactly as:
      THE PATTERN: 1-2 precise sentences detailing the cross-note observation.
      THE CATALYST: 1-2 sentences explaining the why — the underlying drivers or structural mechanics at play.
      FORWARD OUTLOOK: 1 sentence detailing what to watch next or how this resolves.
      </output_structure>
      #{existing_text}
    PROMPT

    chat.system(system_prompt)

    chat.user("Here are my recent market notes:\n\n#{notes_text}\n\nSynthesize these into high-conviction insights. Identify hidden patterns, cross-asset linkages, and risks I might be missing.")

    # Use structured output to get predictable JSON back
    chat.schema = <<~SCHEMA
      {
        "name": "market_insights",
        "strict": true,
        "schema": {
          "type": "object",
          "properties": {
            "insights": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "title": {
                    "type": "string",
                    "description": "A high-signal, specific title. Be precise and descriptive."
                  },
                  "body": {
                    "type": "string",
                    "description": "Structured as: THE PATTERN: [cross-note observation]. THE CATALYST: [underlying drivers]. FORWARD OUTLOOK: [what to watch next]. Do not summarize a single note."
                  },
                  "category": {
                    "type": "string",
                    "enum": ["trend", "trade opportunity", "risk alert", "correlation", "anomaly"],
                    "description": "trend, trade opportunity, risk alert, correlation, or anomaly."
                  },
                  "source_note_titles": {
                    "type": "array",
                    "items": { "type": "string" },
                    "description": "Titles of 2+ notes that support this insight."
                  }
                },
                "required": ["title", "body", "category", "source_note_titles"],
                "additionalProperties": false
              }
            }
          },
          "required": ["insights"],
          "additionalProperties": false
        }
      }
    SCHEMA

    response = chat.generate!
    content = response.fetch(:content)
    parsed = content.is_a?(String) ? JSON.parse(content) : content

    # Save each insight to the database — try both string and symbol keys
    insights_data = parsed["insights"] || parsed[:insights] || parsed.fetch("market_insights", nil) || []
    insights_data.each do |insight_data|
      # Handle both string and symbol keys
      data = insight_data.is_a?(Hash) ? insight_data.transform_keys(&:to_s) : next

      insight = Insight.new
      insight.user_id = user.id
      insight.title = data["title"]
      insight.body = data["body"]
      insight.category = data["category"]
      insight.save

      # Link the insight to its source notes
      source_titles = data["source_note_titles"] || []
      source_titles.each do |note_title|
        matching_note = notes.find { |n| n.title == note_title }

        if matching_note.present?
          NoteInsight.create(note_id: matching_note.id, insight_id: insight.id)
        end
      end
    end
  end
end