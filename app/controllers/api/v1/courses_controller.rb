# frozen_string_literal: true

# app/controllers/api/v1/courses_controller.rb
module Api
  module V1
    class CoursesController < ApplicationController
      before_action :authenticate_user, only: [:create]

      def create
        course = Course.create(course_params)
        render json: { course: course }, status: :created
      end

      def index
        courses = Course.includes(:tutors)
        render json: courses.as_json(include: :tutors), status: :ok
      end

      private

      def course_params
        params.require(:course).permit(:name, tutors_attributes: %i[id name _destroy])
      end
    end
  end
end
