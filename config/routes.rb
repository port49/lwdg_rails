ActionController::Routing::Routes.draw do |map|

  map.restfully :directory

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "directories", :grammatical_number => "plural"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
