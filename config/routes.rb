Rails.application.routes.draw do

  root "portfolios#index"
  
  # Routes for the Portfolio resource:
  # CREATE
  get "/portfolios/new", :controller => "portfolios", :action => "new"
  post "/create_portfolio", :controller => "portfolios", :action => "create"

  # READ
  get "/portfolios", :controller => "portfolios", :action => "index"
  get "/portfolios/:id", :controller => "portfolios", :action => "show"

  # UPDATE
  get "/portfolios/:id/edit", :controller => "portfolios", :action => "edit"
  post "/update_portfolio/:id", :controller => "portfolios", :action => "update"

  # DELETE
  get "/delete_portfolio/:id", :controller => "portfolios", :action => "destroy"
  #------------------------------

  
  # Routes for the Stock resource:
  # CREATE
  get "/stocks/new", :controller => "stocks", :action => "new"
  post "/create_stock", :controller => "stocks", :action => "create"

  # READ
  get "/stocks", :controller => "stocks", :action => "index"
  get "/stocks/:id", :controller => "stocks", :action => "show"

  # UPDATE
  get "/stocks/:id/edit", :controller => "stocks", :action => "edit"
  post "/update_stock/:id", :controller => "stocks", :action => "update"

  # DELETE
  get "/delete_stock/:id", :controller => "stocks", :action => "destroy"
  #------------------------------

  #------------------------------
  devise_for :users
  
  #------------------------------
  # Notification route for users
  get "/users/notify", :controller => "users", :action => "notify"



  # # Routes for the Tracking resource:
  # # CREATE
  # get "/trackings/new", :controller => "trackings", :action => "new"
  # post "/create_tracking", :controller => "trackings", :action => "create"

  # # READ
  # get "/trackings", :controller => "trackings", :action => "index"
  # get "/trackings/:id", :controller => "trackings", :action => "show"

  # # UPDATE
  # get "/trackings/:id/edit", :controller => "trackings", :action => "edit"
  # post "/update_tracking/:id", :controller => "trackings", :action => "update"

  # # DELETE
  # get "/delete_tracking/:id", :controller => "trackings", :action => "destroy"

  #### Add an About page
  #--------------------------------------
  get "/about", :controller => "pages", :action => "about"
end
