require_relative 'board'

class Square
  NEIGHBORS = [[0,1], [1,1], [1,0], [-1, 0], [-1, -1], [0, -1], [1, -1], [-1, 1]]
  attr_accessor :is_bomb, :clicked, :flagged, :board
  attr_reader :position

  def initialize(position)
    @is_bomb = false
    @revealed = false
    @flagged = false
    @position = position
  end

  def reveal
    self.revealed = true
  end

  def flag
    self.flagged = true
  end

  def make_bomb
    @is_bomb = true
  end

  def show_board(board)
    @board = board
  end

  def neighbors
    neighs = NEIGHBORS.map do |diff|
      test_neighbor = []
      test_neighbor << position[0] + diff[0]
      test_neighbor << position[1] + diff[1]
      if test_neighbor[0].between?(0,8) && test_neighbor[1].between?(0,8)
        @board[test_neighbor]
      else
        next
      end
    end
    neighs.select { |neigh| !neigh.nil? }
  end

  def neighbor_bomb_count
    
  end

  def inspect
    {:position => position, :is_bomb => is_bomb}.to_s
  end



end
