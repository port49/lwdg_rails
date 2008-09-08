require 'htauth/digest'

class User
  @@file_location = File.join( RAILS_ROOT, '.htdigest' )
  @@realm = 'LWDG File Manager'
  
  def self.find( arg )
    case arg
    when :all
      HTAuth::DigestFile.open( @@file_location ).load_entries().collect{ |u| { :name => u.split( ":" )[0], :realm => u.split( ":" )[1] } }
    when match( /\w+/ )
    end
  end
  
  def self.create( params )
    file = HTAuth::DigestFile.open( @@file_location, HTAuth::File::ALTER )  
    file.add User.sanitize_username( params[:name] ), @@realm, params[:password]
    file.save!
    true
  end
  
  def self.update( params )
    file = HTAuth::DigestFile.open( @@file_location, HTAuth::File::ALTER )  
    file.update params[:name], @@realm, params[:password]
    file.save!
    true
  end
  
  def self.delete( params )
    file = HTAuth::DigestFile.open( @@file_location, HTAuth::File::ALTER )  
    file.delete params[:name], @@realm
    file.save!
    true
  end

  def self.sanitize_username( username )
    username.gsub( /\W+/, '' ).downcase
  end

end
