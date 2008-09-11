require 'htauth/passwd'

namespace :passwd do

  desc "Create password file and add an admin user."
  task :bootstrap do
    file = HTAuth::PasswdFile.new( File.join( RAILS_ROOT, '.htpasswd' ), HTAuth::File::CREATE )
    file.add( 'admin', 'test' )
    file.save!
  end
  
end

