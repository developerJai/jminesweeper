# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = ["jai@tecorb.com", "jai@tecorb.co", "rama@tecorb.co", "rishabh@tecorb.co", "josh@example.com", "test@sample.com"]
1.upto(3).each do
  mat = [[10,10, 10], [5,5, 10], [5,3,8]]
  users.each_with_index do |email, ind|
    user = User.where(email: email).first_or_create
    data = mat.sample
    board = user.boards.where(name: Faker::Artist.name, width: data[0], height: data[1], mines: data[2]).first_or_create
    board.generate_minesweeper_board
  end
end