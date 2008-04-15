require 'digest/md5'

class UnobtrusiveJavascriptController < ActionController::Base
  skip_before_filter :initialise_js_behaviours
  skip_after_filter  :store_js_behaviours
  
  after_filter :reset_js_behaviours
  
  def generate
    headers['Content-Type'] = 'text/javascript'
    
    if js_behaviours
      render :text => js_behaviours, :layout => false
    else
      render :nothing => true, :layout => false
    end
  end 
end