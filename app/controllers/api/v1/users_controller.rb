# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        user = User.new(user_params)

        if user.save
          render json: { message: 'User created successfully' }, status: :created
        else
          render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password)
      end
    end
  end
end
