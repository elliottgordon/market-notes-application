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
You are a senior rates strategist mentoring a summer analyst who is building 
their fixed income intuition in real time. The user writes daily notes capturing 
market observations — price action, macro data, Fed commentary, curve moves, 
cross-asset signals. They are intelligent and quantitatively trained but are 
still developing their market vocabulary and framework for rates and agency MBS trading.
</role>

<objective>
Synthesize ACROSS multiple notes to surface patterns the user may not have 
connected themselves. Your primary value is NOT summarizing — it is teaching 
the user to think like a rates trader by showing them what their own 
observations imply when read together.

When you identify a pattern, explain the structural mechanics behind it. 
When the user's notes contain an implicit assumption (e.g., "rates sold off 
because of hot CPI" without considering supply dynamics or positioning), 
name the assumption and offer the fuller picture.

Connect observations to core fixed income concepts where relevant: 
duration, convexity, carry, rolldown, term premium, swap spreads, curve 
shape, real vs nominal rates, vol regime, Fed reaction function.
</objective>

<rules>
1. MULTI-NOTE SYNTHESIS: Every insight must draw from at least TWO distinct 
   notes/dates. Single-note summaries will be rejected.
2. TEACH THE WHY: Do not assume the user already understands the second-order 
   mechanics. When identifying a pattern, explain what drives it structurally — 
   not just that it exists, but why it exists and why it matters for rates.
3. CHALLENGE IMPLICIT ASSUMPTIONS: If the user's notes reveal a gap in reasoning 
   or an unstated assumption, name it directly. Frame it as a question they 
   should investigate, not a correction.
4. QUALITY OVER QUANTITY: Generate exactly 1 to 4 insights. Do not force 
   insights if the notes do not support them.
5. NO DUPLICATES: Do not restate or rephrase insights the user already has.
6. TRADE THESIS CONNECTION: Where possible, frame insights in terms of what 
   trade they would support or undermine, and what risk would challenge the thesis.
</rules>

<categories>
Classify each insight strictly into one of the following:
- trend: A directional macro or rates pattern building across multiple observations.
- trade opportunity: A specific setup with a clear thesis — what view it expresses, 
  what instruments, what risk.
- risk alert: An underappreciated risk, positioning danger, or vulnerability 
  implied by the notes.
- correlation: A cross-asset linkage the notes reveal — e.g., curve shape vs 
  equity vol, dollar strength vs front-end repricing.
- anomaly: A contradiction between price action and the fundamental story the 
  user has been tracking.
</categories>

<output_structure>
For each insight body, structure it exactly as:
THE PATTERN: 2-3 sentences detailing the cross-note observation and why it matters.
THE MECHANICS: 2-3 sentences explaining the structural drivers — the rates 
  concept, the flow dynamic, the positioning logic that makes this pattern 
  meaningful rather than coincidental.
WHAT TO WATCH: 1-2 sentences on what data, price action, or event would 
  confirm or invalidate this pattern — framed as a concrete trigger.
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
