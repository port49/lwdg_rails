class DirectoriesController < RestfulController

  def gets
    render :text => ActiveSupport::Base64.decode64(authorization(request).split.last || '') and return true
    redirect_to directory_path(  )
  end

  def get
    @breadcrumbs = []
    if @directory.path && Directory.path_to_id( @directory.path )
      path_names = Directory.path_to_id( @directory.path ).split( "/" )
      while path_name = path_names.pop do
        @breadcrumbs << { :name => path_name, :location => File.expand_path( File.join( Directory.root, ( path_names || "" ), ( path_name || "" ) ) ) } 
      end
    end
    @breadcrumbs.pop
    @breadcrumbs.push( { :name => "top level", :location => Directory.root } ).reverse!
  end

  def post
    if @directory.create_subdirectory( params[:directory][:name] )
      redirect_to directory_path( :id => Directory.path_to_id( @directory.path ) )
    else
      raise "Error creating directory"
    end
  end

  def put
    if @directory.rename( params[:directory][:name] )
      redirect_to directory_path( :id => Directory.path_to_id( @directory.parent_path ) )
    else
      raise "Error renaming directory"
    end
  end

  def delete
    if @directory.remove
      redirect_to directory_path( :id => Directory.path_to_id( @directory.parent_path ) )
    else
      raise "Error removing directory"
    end
  end

  def prepare_restful_instance_variables
    @directory = Directory.new( params[:id] )
  end

end
