# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    first_name { 'Foo' }
    last_name { 'Bar' }
    email { Faker::Internet.email }
    password { 'password123' }
  end
end
