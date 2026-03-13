Rails.application.routes.draw do
  devise_for :users

  # Landing page (public)
  get("/", { :controller => "pages", :action => "landing" })

  # Dashboard (authenticated)
  get("/dashboard", { :controller => "pages", :action => "dashboard" })

  # Notes
  get("/notes", { :controller => "notes", :action => "index" })
  get("/notes/new", { :controller => "notes", :action => "new_note" })
  get("/notes/:id", { :controller => "notes", :action => "show" })
  get("/notes/:id/edit", { :controller => "notes", :action => "edit" })
  post("/notes", { :controller => "notes", :action => "create" })
  post("/notes/:id/update", { :controller => "notes", :action => "update" })
  get("/notes/:id/delete", { :controller => "notes", :action => "destroy" })

  # Insights
  get("/generate_insights", { :controller => "insights", :action => "generate" })
  get("/insights", { :controller => "insights", :action => "index" })
  get("/insights/:id", { :controller => "insights", :action => "show" })
  get("/insights/:id/delete", { :controller => "insights", :action => "destroy" })
end