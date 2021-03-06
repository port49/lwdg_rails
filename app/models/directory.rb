class Directory
  attr_accessor :name, :path, :directories, :files
  
  def initialize( path )
    if path.nil?
      @path = Directory.root
      @name = ""
    else
      @path = File.expand_path( File.join( Directory.root, path ) )
      @name = File.basename( path )
    end
    @directories = []
    @files = []
    Dir.foreach( @path ) do |entry|
      location = File.expand_path( File.join( @path, entry ) )
      if File.directory? location 
        @directories << { :name => entry, :location => location }
      elsif File.file? location
        @files << { :name => entry, :location => location, :size => File.size( location ), :ctime => File.ctime( location ), :public => Fyle.new( "#{ path }/#{ entry }" ).is_public? }
      end
    end
    @directories.sort!{ |a, b| a[:name] <=> b[:name] }
    @files.sort!{ |a, b| a[:name] <=> b[:name] }
  end
  
  def create_subdirectory( name )
    directory_path = File.expand_path File.join( @path, Directory.sanitize_directory_path( name ) ) 
    Dir.mkdir directory_path
    File.chmod 0775, directory_path
  end
  
  def rename( name )
    new_path = File.expand_path( File.join( self.parent_path, Directory.sanitize_directory_path( name ) ) )
    File.rename(
      File.expand_path( @path ), # old directory
      new_path  # new directory
    )
    @path = new_path
  end
  
  def remove
    expanded_path = File.expand_path( @path )
    FileUtils.rm_rf( expanded_path ) unless ( expanded_path == Directory.root || expanded_path == Directory.restricted )
  end
  
  def parent_path
    File.dirname( @path )
  end
  
  def self.root
    File.expand_path( File.join( RAILS_ROOT, 'public', STORAGE_PATH ) )
  end
  
  def self.restricted
    File.expand_path( File.join( RAILS_ROOT, 'public', STORAGE_PATH, 'restricted' ) )
  end
  
  def self.is_root?( path )
    File.expand_path( path ) == Directory.root
  end
  
  def self.path_to_id( path )
    return nil if Directory.is_root?( path )
    File.expand_path( path ).sub( File.expand_path( Directory.root ), '' )
  end
  
  def self.download_path( path )
    File.join( STORAGE_PATH, File.expand_path( path ).sub( File.expand_path( Directory.root ), '' ) )
  end
  
  def self.sanitize_directory_path( path )
    path.gsub( /\s+/, '_' ).downcase
  end

end
