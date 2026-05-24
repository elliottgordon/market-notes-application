class PagesController < ApplicationController
  # Allow non-signed-in visitors to see the landing page
  skip_before_action :authenticate_user!, only: [:landing]

  def landing
    render({ :template => "page_templates/landing" })
  end

  def dashboard
    last_insight = current_user.insights.order(created_at: :desc).first
    if last_insight.present?
      @notes_since_synthesis = current_user.notes.where("created_at > ?", last_insight.created_at).count
      @last_synthesis_time = time_ago_in_words(last_insight.created_at) + " ago"
    else
      @notes_since_synthesis = current_user.notes.count
      @last_synthesis_time = "Never"
    end
    @total_notes = current_user.notes.count
    @total_insights = current_user.insights.count
    render({ :template => "page_templates/dashboard" })
  end
end