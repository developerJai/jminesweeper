require 'rails_helper'

RSpec.describe Board, type: :model do
  let(:user) { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:width) }
    it { should validate_presence_of(:height) }
    it { should validate_presence_of(:mines) }

    it 'is valid with valid attributes' do
      board = build(:board, user: user)
      expect(board).to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'generate_minesweeper_board' do
    it 'generates a minesweeper board with mines and numbers' do
      board = create(:board, user: user, width: 10, height: 10, mines: 20)
      board_data = board.generate_minesweeper_board

      expect(board_data).to be_an(Array)
      expect(board_data.length).to eq(10)
      expect(board_data[0].length).to eq(10)
      expect(board_data[0][0]).to be_a(String).or(eq('N').or(eq('B')))

      mine_count = board_data.flatten.count('B')
      expect(mine_count).to eq(20)
    end
  end
end
