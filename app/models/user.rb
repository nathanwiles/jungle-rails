class User < ApplicationRecord
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    User.find_by_email(email.downcase.strip)
        .try(:authenticate, password) || nil
  end

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8 }
  validates :password_confirmation, presence: true
end
