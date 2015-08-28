require_relative 'square'

class Board
  attr_accessor :grid, :bomb_revealed

  def initialize(size = 9)
    build_board(size)
    @bomb_revealed = false
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

  def display
    grid.each do |row|
      row.each do |el|
        print el.to_s
      end
      print "\n"
    end
    true
  end

  def bomb_revealed?
    @bomb_revealed
  end


  def reveal(pos)
    self[pos].reveal
  end

  def flag(pos)
    self[pos].flag
  end

  def [](pos)
    grid[pos[0]][pos[1]]
  end

  def []=(pos, mark)
    grid[pos[0]][pos[1]] = mark
  end

end
