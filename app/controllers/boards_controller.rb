class BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    user = User.find_or_create_by(email: board_params.dig("user_attributes").dig("email"))
    @board.user = user
    if @board.save
      generate_minesweeper_board(@board)
      redirect_to @board
    else
      redirect_to new_board_path,  notice: @board.errors.full_messages
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def index
    @boards = Board.includes(:user).limit(10).order(created_at: :desc)
  end

  def all_boards
    @boards = Board.includes(:user).order(created_at: "DESC").paginate(page: params[:page], per_page: 2)
  end

  private

  def board_params
    params.require(:board).permit(:name, :width, :height, :mines, user_attributes: [:email])
  end

  def generate_minesweeper_board(board)
    width = board.width
    height = board.height
    num_mines = board.mines

    # Create an empty board
    board_data = Array.new(height) { Array.new(width, 'N') }

    # Place mines randomly
    mines_placed = 0
    while mines_placed < num_mines
      x = rand(width)
      y = rand(height)

      # Check if a mine is already placed at (x, y)
      if board_data[y][x] != 'B'
        board_data[y][x] = 'B'
        mines_placed += 1
      end
    end

    # Calculate numbers in cells surrounding mines
    (0...height).each do |y|
      (0...width).each do |x|
        next if board_data[y][x] == 'B'

        count = 0
        # Check neighboring cells
        [-1, 0, 1].each do |dy|
          [-1, 0, 1].each do |dx|
            next if dx.zero? && dy.zero?
            ny = y + dy
            nx = x + dx
            next if ny < 0 || ny >= height || nx < 0 || nx >= width
            count += 1 if board_data[ny][nx] == 'B'
          end
        end

        board_data[y][x] = count.to_s if count > 0
      end
    end

    # Save the generated board data to the board model
    board.board_data = board_data
    board.save

    # return a two-dimensional array of objects
    board_data
  end

end