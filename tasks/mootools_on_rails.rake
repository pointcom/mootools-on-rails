namespace :mootools_on_rails do
  PLUGIN_ROOT = File.dirname(__FILE__) + '/../'
  
  desc 'Installs required javascript files to the public/javascripts directory.'
  task :install do
    FileUtils.cp Dir[PLUGIN_ROOT + '/assets/javascripts/*.js'], RAILS_ROOT + '/public/javascripts'
  end

  desc 'Removes the javascripts for the plugin.'
  task :remove do
    FileUtils.rm %{mootoools.js}.collect { |f| RAILS_ROOT + "/public/javascripts/" + f  }
  end
end