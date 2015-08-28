require_relative 'square'
require_relative 'board'

class MineSweeper
  attr_accessor :board

  def initialize(size = 9)
    @board = Board.new(size)
  end

  def reveal(pos)
    board.reveal(pos)
    board.display
  end

  def flag(pos)
    board.flag(pos)
    board.display
  end

end
