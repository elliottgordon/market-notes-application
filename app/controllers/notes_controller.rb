class NotesController < ApplicationController
  def index
    matching_notes = Note.all

    @list_of_notes = matching_notes.order({ :created_at => :desc })

    render({ :template => "note_templates/index" })
  end

  def new_note
    render({ :template => "note_templates/new" })
  end

  def show
    the_id = params.fetch("id")

    matching_notes = Note.where({ :id => the_id })

    @the_note = matching_notes.at(0)

    render({ :template => "note_templates/show" })
  end

  def create
    the_note = Note.new
    the_note.user_id = current_user.id
    the_note.title = params.fetch("query_title")
    the_note.market_date = params.fetch("query_market_date")
    the_note.body = build_note_body(params[:note])

    if the_note.valid?
      the_note.save
      redirect_to("/notes", { :notice => "Note created successfully." })
    else
      redirect_to("/notes", { :alert => the_note.errors.full_messages.to_sentence })
    end
  end

  def edit
    the_id = params.fetch("id")
    @the_note = Note.where({ :id => the_id }).at(0)
    @sections = parse_note_body(@the_note.body.to_s)

    render({ :template => "note_templates/edit" })
  end

  def update
    the_id = params.fetch("id")
    the_note = Note.where({ :id => the_id }).at(0)

    the_note.user_id = current_user.id
    the_note.title = params.fetch("query_title")
    the_note.market_date = params.fetch("query_market_date")
    the_note.body = build_note_body(params[:note])

    if the_note.valid?
      the_note.save
      redirect_to("/notes/#{the_note.id}", { :notice => "Note updated successfully." } )
    else
      redirect_to("/notes/#{the_note.id}", { :alert => the_note.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("id")
    the_note = Note.where({ :id => the_id }).at(0)

    the_note.destroy

    redirect_to("/notes", { :notice => "Note deleted successfully." } )
  end

  private

  SECTION_HEADERS = [
    ["WHAT MOVED",             :what_moved],
    ["WHY IT MOVED",           :why_moved],
    ["WHAT SURPRISED ME",      :surprised],
    ["CONNECTION TO MY THESIS", :thesis],
    ["OPEN QUESTION",          :open_question]
  ].freeze

  def build_note_body(note_params)
    return "" unless note_params
    SECTION_HEADERS.map do |header, key|
      "#{header}:\n#{note_params[key].to_s.strip}"
    end.join("\n\n")
  end

  def parse_note_body(body)
    result = SECTION_HEADERS.each_with_object({}) { |(_, key), h| h[key] = "" }
    return result.merge(what_moved: body) unless body.start_with?("WHAT MOVED:")

    SECTION_HEADERS.each_with_index do |(header, key), i|
      next_headers = SECTION_HEADERS[(i + 1)..].map { |h, _| Regexp.escape(h) }.join("|")
      pattern = if next_headers.present?
        /#{Regexp.escape(header)}:\n(.*?)(?=\n\n(?:#{next_headers}):|\z)/m
      else
        /#{Regexp.escape(header)}:\n(.*)\z/m
      end
      match = body.match(pattern)
      result[key] = match ? match[1].strip : ""
    end

    result
  end
end
