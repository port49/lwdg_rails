class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   "login"
      t.string   "crypted_password"
      t.string   "realm"
      t.string   "name"
      t.string   "email"
      t.datetime "created_at"
      t.datetime "updated_at"

      t.timestamps
    end
    User.create( :login => 'admin', :realm => "LWDG File Manager", :name => 'admin', :password => 'test', :password_confirmation => 'test' )
  end

  def self.down
    drop_table :users
  end
end
