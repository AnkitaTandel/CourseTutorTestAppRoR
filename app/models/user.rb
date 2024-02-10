# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true

  def generate_jwt
    payload = { user_id: id, exp: 24.hours.from_now.to_i }
    AuthenticationService.encode(payload)
  end
end
