class Fyle
  attr_accessor :name, :path
  
  def initialize( path )
    if path.nil?
      raise "File path cannot be empty."
    else
      @path = File.expand_path( File.join( Directory.root, path ) )
      @name = File.basename( path )
    end
  end
  
  def rename( name )
    new_path = File.expand_path( File.join( self.parent_path, Fyle.sanitize_filename( name ) ) )
    File.rename File.expand_path( @path ), new_path
    @path = new_path
  end
  
  def remove
    File.delete File.expand_path( @path )
  end
  
  def parent_path
    File.dirname( @path )
  end
  
  def self.path_to_id( path )
    File.expand_path( path ).sub( File.expand_path( Directory.root ), '' )
  end
  
  def self.download_path( path )
    File.join( STORAGE_PATH, File.expand_path( path ).sub( File.expand_path( Directory.root ), '' ) )
  end
  
  def self.sanitize_filename( filename )
    filename.gsub( /\s+/, '_' ).downcase
  end

end
