class PagesController < ApplicationController
  # Allow non-signed-in visitors to see the landing page
  skip_before_action :authenticate_user!, only: [:landing]

  def landing
    render({ :template => "page_templates/landing" })
  end

  def dashboard
    render({ :template => "page_templates/dashboard" })
  end
end