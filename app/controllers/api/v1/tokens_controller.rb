# frozen_string_literal: true

module Api
  module V1
    class TokensController < ApplicationController
      def create
        user = User.find_by(email: params[:user][:email])

        if user&.authenticate(params[:user][:password])
          token = AuthenticationService.encode(user_id: user.id)
          render json: { token: token }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    end
  end
end
