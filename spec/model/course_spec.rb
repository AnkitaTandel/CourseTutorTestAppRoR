# frozen_string_literal: true

# spec/models/course_spec.rb
require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:tutors).inverse_of(:course).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for(:tutors).allow_destroy(true) }
  end

  describe 'creating a course with tutors' do
    let(:course_params) do
      {
        name: 'Ruby on Rails',
        tutors_attributes: [
          { name: 'Foo Bar' },
          { name: 'Fiz Bar' }
        ]
      }
    end

    it 'creates a course with tutors' do
      course = described_class.create(course_params)
      expect(course).to be_persisted
      expect(course.name).to eq('Ruby on Rails')
      expect(course.tutors.count).to eq(2)
      expect(course.tutors.pluck(:name)).to match_array(['Foo Bar', 'Fiz Bar'])
    end
  end

  describe 'destroying a course with tutors' do
    it 'destroys a course and its tutors' do
      course = FactoryBot.create(:course, tutors_attributes: [{ name: 'Tutor 1' }])

      expect { course.destroy }.to change(Tutor, :count).by(-1)
    end
  end
end
