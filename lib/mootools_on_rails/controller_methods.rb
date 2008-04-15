module MootoolsOnRails::ControllerMethods
  def self.included(base)
    base.class_eval do
      before_filter :initialise_js_behaviours
      after_filter  :store_js_behaviours
    end
  end
  
  def add_javascript(javascript)
    @js_behaviours << javascript
  end

  protected
  
    def initialise_js_behaviours
      @js_behaviours = ""
    end
  
    # Stores all registered javascript behaviours in the session as a hash
    def store_js_behaviours
      session[:js_behaviours] = @js_behaviours
    end
      
    # Returns a BehaviourScript from the behaviours serialized to the session
    def js_behaviours
      @js_behaviours || session[:js_behaviours]
    end
    
    # Clears the array of registered javascript behaviours
    def reset_js_behaviours
      session[:js_behaviours] = nil
    end
end