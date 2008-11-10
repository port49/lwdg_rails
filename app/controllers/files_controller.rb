class FilesController < RestfulController

  def put
    if params[:file][:public] && params[:file][:public] == 'true' && @file.make_public
      redirect_to directory_path( :id => Directory.path_to_id( @file.parent_path ) )
    elsif !params[:file][:public] && @file.rename( params[:file][:name] )
      redirect_to directory_path( :id => Directory.path_to_id( @file.parent_path ) )
    else
      raise "Error renaming file."
    end
  end

  def delete
    if @file.remove
      redirect_to directory_path( :id => Directory.path_to_id( @file.parent_path ) )
    else
      raise "Error deleting file."
    end
  end

  def prepare_restful_instance_variables
    @file = Fyle.new( params[:id] )
  end

end
