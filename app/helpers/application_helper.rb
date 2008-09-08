# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def path_to_id( path )
    Directory.path_to_id path 
  end

  def download_path( file )
    Directory.download_path file
  end
  
  def selected_if( conditions )
    conditions ? "selected" : ""
	end

end
