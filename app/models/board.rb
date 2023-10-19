class Board < ApplicationRecord
  belongs_to :user
  validates_presence_of :name, :width, :height, :mines
  accepts_nested_attributes_for :user
  serialize :board_data, Array

  # Method to generate the minesweeper board
  def generate_minesweeper_board

    # Create an empty board
    board_data = Array.new(height) { Array.new(width, 'N') }

    # Place mines randomly
    mines_placed = 0
    while mines_placed < mines
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
    self.board_data = board_data
    self.save

    # return a two-dimensional array of objects
    board_data
  end
end
