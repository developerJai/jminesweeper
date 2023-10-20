require 'rails_helper'

RSpec.describe "Boards", type: :request do

  before do
    @num_boards = 10
    @boards = []

    @num_boards.times do
      @boards << create(:board)
    end
  end
  
  describe "GET /boards/new" do
    it "Should load new page" do
      visit new_board_path
      expect(page).to have_text("Minesweeper boards")
      expect(page).to have_text("Generate new board")
      expect(page).to have_text("Newly New board")
      expect(page).to have_link('View all generated boards', href: boards_path)
      expect(page).to have_css("table.table-striped tbody tr", count: @num_boards)
    end

    it 'User generates new board' do
      visit new_board_path

      fill_in 'board[user_attributes][email]', with: 'test@yopmail.com'
      fill_in 'board[name]', with: 'My New Board'
      fill_in 'board[width]', with: 10
      fill_in 'board[height]', with: 10
      fill_in 'board[mines]', with: 20

      click_button 'Generate Board'

      expect(page).to have_content('Generated minesweeper board')
    end

    it "Displays a table of boards" do

      visit new_board_path

      expect(page).to have_css("table.table-striped")

      expect(page).to have_content("Board Name")
      expect(page).to have_content("Email")
      expect(page).to have_content("Width")
      expect(page).to have_content("Height")
      expect(page).to have_content("Mines")

      @boards.each do |board|
        expect(page).to have_link(board.name, href: board_path(board.id))
        expect(page).to have_content(board.user.email)
        expect(page).to have_content(board.width)
        expect(page).to have_content(board.height)
        expect(page).to have_content(board.mines)
      end
    end
  end

  describe "GET /boards" do
    it "clicks on View all generated boards" do
      visit new_board_path

      expect(page).to have_link('View all generated boards', href: boards_path)
      click_link "View all generated boards"
      expect(page).to have_current_path(boards_path)
    end

    it "displays all generated boards and allows filtering" do
      visit boards_path

      expect(page).to have_content("All Generated Boards")
      expect(page).to have_content("Filter boards :")

      fill_in "keyword", with: @boards.first.name
      find("button[type='submit']").click

      expect(page).to have_link(@boards.first.name, href: board_path(@boards.first.id))

      click_link "Reset"

      @boards.each do |board|
        expect(page).to have_link(board.name, href: board_path(board.id))
        expect(page).to have_content(board.user.email)
        expect(page).to have_content(board.width)
        expect(page).to have_content(board.height)
        expect(page).to have_content(board.mines)
        expect(page).to have_content(board.created_at.strftime('%B %d, %Y %I:%M %p'))
      end

      expect(page).to have_link("Generate New board", href: new_board_path)
    end
  end

  describe "Show Board" do
    it "loads the board page" do
      board = create(:board)
      visit board_path(board)
      
      expect(page).to have_content("Generated minesweeper board")
      expect(page).to have_content(board.name)
      expect(page).to have_content(board.user.email)
      expect(page).to have_content(board.width)
      expect(page).to have_content(board.height)
      expect(page).to have_content(board.mines)
    end

    it "redirects to index page" do
      board = create(:board)
      visit board_path(board)
      
      click_link "Back to Index"
      expect(current_path).to eq(boards_path)
    end

    it "redirects to new board page" do
      board = create(:board)
      visit board_path(board)
      
      click_link "Generate new board"
      expect(current_path).to eq(new_board_path)
    end

    it "displays board data correctly" do
      board = create(:board, name: "Sample Board", width: 10, height: 10)
      visit board_path(board)
      
      board.board_data.each_with_index do |row, rind|
        row.each_with_index do |cell, cind|
          button = find("button[row='#{rind}'][col='#{cind}']")
          
          if cell == 'B'
            expect(button).to have_css("img[src*='mine.png']")
          end
        end
      end
    end
  end
end
