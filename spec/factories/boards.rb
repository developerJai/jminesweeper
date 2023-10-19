# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    name { "New board" }
    width { 5 }
    height { 5 }
    mines { 10 }
    user { create(:user, email: "test@example.com") }
    board_data { {} }
  end
end