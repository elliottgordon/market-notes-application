class InsightsController < ApplicationController
  def index
    matching_insights = Insight.all

    if params["category"].present?
      matching_insights = matching_insights.where({ :category => params.fetch("category") })
    end

    @list_of_insights = matching_insights.order({ :created_at => :desc })

    render({ :template => "insight_templates/index" })
  end

  def show
    the_id = params.fetch("id")

    matching_insights = Insight.where({ :id => the_id })

    @the_insight = matching_insights.at(0)

    render({ :template => "insight_templates/show" })
  end

  def create
    the_insight = Insight.new
    the_insight.user_id = params.fetch("query_user_id")
    the_insight.title = params.fetch("query_title")
    the_insight.body = params.fetch("query_body")
    the_insight.category = params.fetch("query_category")

    if the_insight.valid?
      the_insight.save
      redirect_to("/insights", { :notice => "Insight created successfully." })
    else
      redirect_to("/insights", { :alert => the_insight.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("id")
    the_insight = Insight.where({ :id => the_id }).at(0)

    the_insight.user_id = params.fetch("query_user_id")
    the_insight.title = params.fetch("query_title")
    the_insight.body = params.fetch("query_body")
    the_insight.category = params.fetch("query_category")

    if the_insight.valid?
      the_insight.save
      redirect_to("/insights/#{the_insight.id}", { :notice => "Insight updated successfully." } )
    else
      redirect_to("/insights/#{the_insight.id}", { :alert => the_insight.errors.full_messages.to_sentence })
    end
  end

  def generate
    InsightGenerator.generate_for_user(current_user)
    redirect_to("/insights", { :notice => "New insights generated from your notes!" })
  end

  def destroy
    the_id = params.fetch("id")
    the_insight = Insight.where({ :id => the_id }).at(0)

    the_insight.destroy

    redirect_to("/insights", { :notice => "Insight deleted successfully." } )
  end
end
