module MootoolsOnRails
  class << self
    # Add MootoolsOnRails.routes in RAILS_ROOT/config/routes.rb
    def routes
      ActionController::Routing::Routes.add_route "/behaviours/*page_path", :controller => "unobtrusive_javascript", :action => "generate"
    end
  end
end