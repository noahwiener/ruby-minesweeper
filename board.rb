require_relative 'square'

class Board
  attr_accessor :grid

  def initialize(size = 9)
    build_board(size)
  end

  def build_board(size)
    @grid = []
    size.times do
      row = []
      size.times { row << Square.new([grid.length, row.length]) }
      grid << row
    end
    add_bombs
    show_tiles_the_board
  end

  def show_tiles_the_board
    grid.each do |row|
      row.each do |tile|
        tile.show_board(self)
      end
    end
  end

  def add_bombs
    10.times do
      @grid[rand(grid.length - 1)][rand(grid.length - 1)].make_bomb
    end
  end

  # def display
  #   grid.each do |row|
  #   end
  # end

  def [](pos)
    grid[pos[0]][pos[1]]
  end

  def []=(pos, mark)
    grid[pos[0]][pos[1]] = mark
  end

end
