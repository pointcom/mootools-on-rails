require 'test_helper'

class MootoolsHelperTest < Test::Unit::TestCase
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
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
    end.new
    
    @generator = create_generator
  end


  def test_link_to_remote
    assert_equal '<a href="#" onclick="new Ajax(\'http://www.example.com/posts/list\', {evalScripts:true}).request(); return false;">Link</a>', 
      link_to_remote("Link", :url => {:controller => "posts", :action => "list"})
  end

  def test_form_remote_tag
    assert_equal "<form action=\"http://www.example.com/posts/new\" method=\"post\" onsubmit=\"this.send({evalScripts:true}); return false;\">", 
      form_remote_tag(:url => {:controller => 'posts', :action => 'new'})
    assert_equal "<form action=\"http://www.example.com/posts/new\" method=\"post\" onsubmit=\"this.send({evalScripts:true, update:$('mydiv')}); return false;\">", 
      form_remote_tag(:url => {:controller => 'posts', :action => 'new'}, :update => 'mydiv')
    assert_equal "<form action=\"http://www.example.com/posts/new\" method=\"get\" onsubmit=\"this.send({evalScripts:true}); return false;\">", 
      form_remote_tag(:url => {:controller => 'posts', :action => 'new'}, :html => { :method => :get })
  end

  def test_form_remote_tag_with_method
    assert_equal "<form action=\"http://www.example.com/posts/new\" method=\"post\" onsubmit=\"this.send({evalScripts:true}); return false;\"><div style=\"margin:0;padding:0\"><input name=\"_method\" type=\"hidden\" value=\"put\" /></div>", 
      form_remote_tag(:url => {:controller => 'posts', :action => 'new'}, :html => { :method => :put })
  end
  
  def test_alert
    assert_equal "alert(\"my alert !\");",
      @generator.alert('my alert !')
  end
  
  def test_call
    assert_equal "myFunction();",
      @generator.call('myFunction')
  end
  
  def test_assign
    assert_equal "name = \"value\";", 
      @generator.assign('name', 'value')
  end
    
  def test_show
    assert_equal "$(\"my-id\").setStyles({display:''});",
      @generator.show('my-id')
      
    assert_equal "[\"my-id1\", \"my-id2\"].each(function(element){$(element).setStyles({display:'none'});});",
      @generator.hide('my-id1', 'my-id2')
  end
  
  def test_hide
    assert_equal "$(\"my-id\").setStyles({display:'none'});",
      @generator.hide('my-id')
      
    assert_equal "[\"my-id1\", \"my-id2\"].each(function(element){$(element).setStyles({display:'none'});});",
      @generator.hide('my-id1', 'my-id2')
  end
  
  def test_delay
    @generator.delay(20) do
      @generator.hide('foo')
    end
    
    assert_equal "setTimeout(function() {\n;\n$(\"foo\").setStyles({display:'none'});\n}, 20000);", 
      @generator.to_s
  end
    
  
  protected
    def protect_against_forgery?
      false
    end
    
    
    def create_generator
      block = Proc.new { |*args| yield *args if block_given? } 
      JavaScriptGenerator.new self, &block
    end
end


