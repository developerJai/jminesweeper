require 'rails_helper'

RSpec.describe "Boards", type: :request do
  describe "GET /boards/new" do
    it "Should load new page" do
      visit new_board_path
      expect(page).to have_text("Generate new board")
    end
  end
end
