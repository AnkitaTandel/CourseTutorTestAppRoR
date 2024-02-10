# frozen_string_literal: true

# Totor Model

class Tutor < ApplicationRecord
  belongs_to :course
  validates :name, presence: true
end
