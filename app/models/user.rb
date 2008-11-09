require 'htauth/passwd'

class User
  @@file_location = File.join( RAILS_ROOT, '.htpasswd' )
  @@group_location = File.join( RAILS_ROOT, '.htgroup' )
  @@realm = 'LWDG File Manager'
  
  def self.find( arg )
    case arg
    when :all
      HTAuth::PasswdFile.open( @@file_location ).load_entries().collect{ |u| { :name => u.split( ":" )[0], :realm => u.split( ":" )[1] } }
    when match( /\w+/ )
    end
  end
  
  def self.find_restricted
    @restricted_users = []
    Dir.foreach( Directory.restricted ) do |entry|
      location = File.expand_path( File.join( Directory.restricted, entry ) )
      if File.directory?( location ) && !entry.match( /^\./ )
        @restricted_users << entry
      end
    end
    @restricted_users
  end
  
  def self.update_group
    @all_users = User.find( :all ).collect{ |u| u[:name] }
    File.open( @@group_location, 'w' ){ |f| f.write( "LoneWolf: #{ @all_users * ' ' }" ) }
    File.chmod 0664, @@group_location
  end
  
  def self.update_restricted
    @restricted_users = User.find_restricted
    @all_users = User.find( :all ).collect{ |u| u[:name] }
    Dir.foreach( Directory.restricted ) do |entry|
      htgroup_path = File.expand_path File.join( Directory.restricted, entry, '.htgroup' )
      File.open( htgroup_path, 'w' ) { |f| f.write "#{ entry }: #{ entry } #{ ( @all_users - @restricted_users ).uniq * ' ' }\n" }
      File.chmod 0664, htgroup_path
    end
  end
  
  def self.create( params )
    username = User.sanitize_username( params[:name] )
    return false if username == "admin"
    file = HTAuth::PasswdFile.open( @@file_location, HTAuth::File::ALTER )  
    file.add username, params[:password]
    file.save!

    # Create a restricted user directory and .htaccess and .htgroup file.
    if params[:restricted] && params[:restricted].to_i == 1
      restricted_directory = Directory.new( '/restricted' )
      restricted_directory.create_subdirectory( username )
      htaccess_path = File.expand_path File.join( Directory.restricted, username, '.htaccess' )
      htgroup_path = File.expand_path File.join( Directory.restricted, username, '.htgroup' )
      @restricted_users = User.find_restricted
      @all_users = User.find( :all ).collect{ |u| u[:name] }
      
      # Write .htaccess file.
      File.open( htaccess_path, 'w' ) do |f|
        f.write "AuthType Basic\n"
        f.write "AuthName \"LWDG File Manager\"\n"
        f.write "AuthUserFile /home/lwdg/public_html/.htpasswd\n"
        f.write "AuthGroupFile #{ htgroup_path }\n"
        f.write "Require group #{ username }\n"
      end
      File.chmod 0664, htaccess_path
      File.open( htgroup_path, 'w' ) { |f| f.write "#{ username }: #{ username } #{ ( @all_users - @restricted_users ).uniq  * ' ' }\n" }
      File.chmod 0664, htgroup_path

    # Update LoneWolf group file and move along.
    else
      User.update_group
      User.update_restricted
    end
    true
  end
  
  def self.update( params )
    file = HTAuth::PasswdFile.open( @@file_location, HTAuth::File::ALTER )  
    file.update params[:name], params[:password]
    file.save!
    true
  end
  
  def self.delete( params )
    return false if params[:name] == "admin"
    file = HTAuth::PasswdFile.open( @@file_location, HTAuth::File::ALTER )  
    file.delete params[:name]
    file.save!
    User.update_group
    true
  end

  def self.sanitize_username( username )
    username.gsub( /\W+/, '' ).downcase
  end

end
