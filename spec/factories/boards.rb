# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    name { Faker::Lorem.words(number: 2).join(" ") }
    width { Faker::Number.between(from: 5, to: 10) }
    height { Faker::Number.between(from: 5, to: 10) }
    mines { Faker::Number.between(from: 5, to: 15) } 
    user { create(:user, email: Faker::Internet.email) }
    board_data { [] }
  end
end
