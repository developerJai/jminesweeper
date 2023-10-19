class BoardsController < ApplicationController
  # Action to initialize a new board and fetch the latest 10 boards
  def new
    @board = Board.new
    @boards = Board.includes(:user).limit(10).order(created_at: :desc)
  end

  # Action to create a new board with the provided parameters
  def create
    @board = Board.new(board_params)
    # Find or create a user with the provided email
    user = User.find_or_create_by(email: board_params.dig("user_attributes").dig("email"))
    @board.user = user
    if @board.save
      # Generate the minesweeper board after saving the board
      @board.generate_minesweeper_board
      redirect_to @board
    else
      # Redirect to the new board path if there are any errors
      redirect_to new_board_path,  notice: @board.errors.full_messages
    end
  end

  # Action to show a specific board by its id
  def show
    @board = Board.find(params[:id])
  end

  # Action to fetch boards based on the provided keyword or fetch all boards if no keyword is provided
  def index
    if params[:keyword].present?
      keyword = params[:keyword].downcase
      @boards = Board.includes(:user).where("LOWER(id::text) LIKE ? OR LOWER(name) LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%").order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    else
      @boards = Board.includes(:user).order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    end
  end

  private

  # Method to permit only the necessary parameters
  def board_params
    params.require(:board).permit(:name, :width, :height, :mines, user_attributes: [:email])
  end
end