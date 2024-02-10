# frozen_string_literal: true

# Course Model

class Course < ApplicationRecord
  has_many :tutors, inverse_of: :course, dependent: :destroy
  accepts_nested_attributes_for :tutors, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
