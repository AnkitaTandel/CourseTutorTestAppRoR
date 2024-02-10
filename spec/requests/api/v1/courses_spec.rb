# frozen_string_literal: true

# spec/requests/api/v1/courses_spec.rb
require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'POST /create' do
    let(:course_params) do
      {
        course: {
          name: 'Ruby on Rails',
          tutors_attributes: [
            { name: 'Tutor 1' },
            { name: 'Tutor 2' }
          ]
        }
      }
    end
    let(:user) { FactoryBot.create(:user) }

    context 'with token' do
      let(:course) { Course.last }

      before do
        post '/api/v1/courses', params: course_params, headers: { 'Authorization' => "Bearer #{token}" }
      end

      context 'with a valid token' do
        let(:token) { encode_jwt_token(user) }

        it 'responds with http status `created`' do
          expect(response).to have_http_status(:created)
        end

        it 'creates 1 course with 2 tutors' do
          expect(course).to be_present
          expect(course.name).to eq('Ruby on Rails')
          expect(course.tutors.count).to eq(2)
          expect(course.tutors.pluck(:name)).to match_array(['Tutor 1', 'Tutor 2'])
        end
      end

      context 'with an invalid token' do
        let(:token) { 'invalid token' }

        it 'returns unauthorized with error `Invalid Token`' do
          expect(response).to have_http_status(:unauthorized)
          expect(response_body['error']).to eq('Invalid token')
        end
      end
    end

    context 'without a token' do
      it 'returns unauthorized with error `Invalid Token`' do
        post '/api/v1/courses', params: course_params
        expect(response).to have_http_status(:unauthorized)
        expect(response_body['error']).to eq('Invalid token')
      end
    end
  end

  describe 'GET /index' do
    before do
      # Create three courses with tutors
      FactoryBot.create(:course, tutors_attributes: [{ name: 'Tutor 1' }])
      FactoryBot.create(:course, tutors_attributes: [{ name: 'Tutor 2' }])
      FactoryBot.create(:course, tutors_attributes: [{ name: 'Tutor 3' }])
      get api_v1_courses_path
    end

    it 'returns a list of courses with tutors' do
      expect(response).to have_http_status(:ok)
      expect(response_body.length).to eq(3)
      expect(response_body.first['tutors'].first['name']).to eq('Tutor 1')
    end
  end

  def encode_jwt_token(user)
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
    AuthenticationService.encode(payload)
  end

  def response_body
    JSON.parse(response.body)
  end
end
