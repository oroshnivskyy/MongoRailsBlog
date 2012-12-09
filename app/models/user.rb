class User
  include MongoMapper::Document

  key :username, String
  key :email, String
  key :password_hash, String
  key :password_salt, String
  timestamps!
  many :posts

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :username, :on => :create
  validates_uniqueness_of :username
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i


  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret password, password_salt
    end
  end

  def self.authenticate( email, password )
    user = find_by_username( email ) || find_by_email( email )
    if user && user.password_hash == BCrypt::Engine.hash_secret( password, user.password_salt )
      user
    else
      nil
    end
  end
end
