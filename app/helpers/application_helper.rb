module ApplicationHelper
  def badge_class_for(category)
    case category
    when "trend" then "badge-trend"
    when "trade opportunity" then "badge-opportunity"
    when "risk alert" then "badge-risk"
    when "correlation" then "badge-correlation"
    when "anomaly" then "badge-anomaly"
    else "badge-trend"
    end
  end
end
