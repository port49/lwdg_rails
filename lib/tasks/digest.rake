require 'htauth/digest'

namespace :digest do

  desc "Create digest file and add an admin user."
  task :bootstrap => :environment do
    file = HTAuth::DigestFile.new( File.join( RAILS_ROOT, 'public', '.htdigest' ), HTAuth::File::CREATE )
    file.add( 'admin', 'LWDG File Manager', 'test' )
    file.save!
  end
  
end

