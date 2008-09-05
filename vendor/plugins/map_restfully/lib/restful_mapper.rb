module ActionController
  module Routing
    class RouteSet 
      class Mapper
        def restfully( resource_name ) #:nodoc:
          singular_resource_name = resource_name.to_s.singularize
          plural_resource_name = resource_name.to_s.pluralize
          named_route( singular_resource_name, singular_resource_name, { :controller => plural_resource_name, :grammatical_number => 'singular' } )
          connect( singular_resource_name + ".:format", { :controller => plural_resource_name, :grammatical_number => 'singular' } )
          connect( singular_resource_name + "/:id", { :controller => plural_resource_name, :grammatical_number => 'singular' } )
          connect( singular_resource_name + "/:id.:format", { :controller => plural_resource_name, :grammatical_number => 'singular' } )
          named_route( plural_resource_name, plural_resource_name, { :controller => plural_resource_name, :grammatical_number => 'plural' } )
          connect( plural_resource_name + ".:format", { :controller => plural_resource_name, :grammatical_number => 'plural' } )
          connect( plural_resource_name + "/:ids", { :controller => plural_resource_name, :grammatical_number => 'plural' } )
          connect( plural_resource_name + "/:ids.:format", { :controller => plural_resource_name, :grammatical_number => 'plural' } )
        end
      end
    end
  end
end

