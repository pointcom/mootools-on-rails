module ActionView::Helpers::AssetTagHelper
  alias_method :rails_javascript_include_tag, :javascript_include_tag
  
  JAVASCRIPT_DEFAULT_SOURCES = ['mootools-1.2-core', 'mootools-1.2-more', 'application', 'mootools_patch']
  @@javascript_default_sources = JAVASCRIPT_DEFAULT_SOURCES.dup
    
  def javascript_include_tag(*sources)
   if sources.delete :mootools
     sources = sources.concat(
       ['mootools-1.2-core', 'mootools-1.2-more', 'application', behaviours_url]
     ).uniq
   elsif sources.delete :defaults
     sources = ['mootools-1.2-core', 'mootools-1.2-more', 'mootools_patch', 'application', behaviours_url].concat(sources)
   end

   
   rails_javascript_include_tag(*sources)
  end
  
  protected  
    def behaviours_url
      action_path = case @controller.request.path
        when '', '/'
          '/index'
        else
          @controller.request.path
      end
      "/behaviours#{action_path}.js"
    end
end