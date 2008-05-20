require File.dirname(__FILE__) + '/test_helper'

class AssetTagHelperTest < Test::Unit::TestCase
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::JavaScriptHelper
  include ActionView::Helpers::MootoolsHelper
  
  def setup
    @controller = Class.new do
      def url_for(options, *parameters_for_method_reference)
        if options.is_a?(String)
          options
        else
          url =  "http://www.example.com/"
          url << options[:controller].to_s + "/" if options and options[:controller]
          url << options[:action].to_s if options and options[:action]
          url
        end
      end  
      
      def request
        ActionController::TestRequest.new
      end    
    end.new

    ENV["RAILS_ASSET_ID"] = "1"
  end
  
  def teardown
    ENV["RAILS_ASSET_ID"] = nil
  end

  
  def test_javascript_include_tag_mootools
    assert_equal %(<script src="/javascripts/mootools.js?1" type="text/javascript"></script>\n<script src="/behaviours/index.js?1" type="text/javascript"></script>),
      javascript_include_tag(:mootools)
  end
  
  def test_javascript_include_tag_default
    assert_equal %(<script src="/javascripts/mootools.js?1" type="text/javascript"></script>\n<script src="/javascripts/mootools_patch.js?1" type="text/javascript"></script>\n<script src="/behaviours/index.js?1" type="text/javascript"></script>),
      javascript_include_tag(:defaults)
  end
  
end