class User < ActiveRecord::Base
  attr_reader :password
  
  validates :user_name, :password, presence: true, on: :create
  validates :password, length: { minimum: 6 }, on: :create
  validates :password_digest, presence: { message: "Password Can't Be Blank" }
  before_validation :ensure_session_token
  
  has_many(:cats)
  has_many(:cat_rental_requests)
  
  def self.find_by_credentials(user_name, password)
    u = User.find_by_user_name(user_name)
    
    if u.nil?
      nil
    else
      if u.is_password?(password)
        return u
      else
        nil
      end
    end
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(@password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
  
  def ensure_session_token
    self.session_token = SecureRandom.urlsafe_base64 unless self.session_token
  end
end
