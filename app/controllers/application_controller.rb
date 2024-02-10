# frozen_string_literal: true

class ApplicationController < ActionController::API
  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = AuthenticationService.decode(token)
    unless decoded_token && Time.zone.at(decoded_token['exp']) > Time.zone.now
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end
end
