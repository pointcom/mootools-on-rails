require 'mootools_on_rails/mootools_on_rails'
require 'mootools_on_rails/mootools_helper'

# require the controller
require 'controllers/unobtrusive_javascript_controller'



# add methods to action controller base
require 'mootools_on_rails/controller_methods'
ActionController::Base.send(:include, MootoolsOnRails::ControllerMethods)

ActionView::Helpers::PrototypeHelper.instance_methods.each do |method|
  ActionView::Helpers::PrototypeHelper.send :remove_method, method
end

ActionView::Base.class_eval do
  include ActionView::Helpers::MootoolsHelper
end


