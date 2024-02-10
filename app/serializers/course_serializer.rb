# frozen_string_literal: true

# app/serializers/course_serializer.rb
class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :tutors
end
