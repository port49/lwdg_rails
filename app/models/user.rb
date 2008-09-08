class User
=begin
  attr_accessor :password

  validates_presence_of     :login
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login, :case_sensitive => false
  before_save :encrypt_password
  
  # Prevents a user from submitting a crafted form that bypasses activation -- 
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation

  # Encrypts some data.
  def self.encrypt( password )
    Digest::MD5.hexdigest( password )
  end

  # Encrypts the password.
  def encrypt( password )
    self.class.encrypt( password )
  end

  protected
    # Before filter.
    def encrypt_password
      return if password.blank?
      self.crypted_password = encrypt( password )
    end
      
    def password_required?
      crypted_password.blank? || !password.blank?
    end
=end    
end
