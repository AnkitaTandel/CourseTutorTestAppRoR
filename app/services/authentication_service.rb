# frozen_string_literal: true

# app/services/authentication_service.rb
class AuthenticationService
  def self.encode(payload, expiration = 1.hour.from_now)
    payload[:exp] = expiration.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256').first
  end
end
