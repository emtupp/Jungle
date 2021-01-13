class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: { minimum: 5 }
  validates :password_confirmation, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email, { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip)
    if user && user.authenticate(password)
      user
    else 
      nil
    end
  end

end
