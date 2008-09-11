require 'htauth/passwd'

class User
  @@file_location = File.join( RAILS_ROOT, '.htpasswd' )
  @@realm = 'LWDG File Manager'
  
  def self.find( arg )
    case arg
    when :all
      HTAuth::PasswdFile.open( @@file_location ).load_entries().collect{ |u| { :name => u.split( ":" )[0], :realm => u.split( ":" )[1] } }
    when match( /\w+/ )
    end
  end
  
  def self.create( params )
    return false if User.sanitize_username( params[:name] ) == "admin"
    file = HTAuth::PasswdFile.open( @@file_location, HTAuth::File::ALTER )  
    file.add User.sanitize_username( params[:name] ), params[:password]
    file.save!
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
    true
  end

  def self.sanitize_username( username )
    username.gsub( /\W+/, '' ).downcase
  end

end
