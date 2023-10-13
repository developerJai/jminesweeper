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
    @boards = Board.limit(10).order(created_at: :desc)
  end

  def all_boards
    @boards = Board.all
  end

  private

  def board_params
    params.require(:board).permit(:name, :width, :height, :mines, user_attributes: [:email])
  end

  def generate_minesweeper_board(board)
    
  end
end