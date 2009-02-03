ActionController::Routing::Routes.draw do |map|

  map.with_options(:controller => 'theme', :filename => /.*/, :conditions => {:method => :get}) do |theme|
    theme.connect 'stylesheets/:theme/:filename', :action => 'stylesheets'
    theme.connect 'javascripts/:theme/:filename', :action => 'javascripts'
    theme.connect 'images/:theme/:filename',      :action => 'images'
  end

end