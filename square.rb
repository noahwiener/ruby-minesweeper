require_relative 'board'

class Square
  NEIGHBORS = [[0,1], [1,1], [1,0], [-1, 0], [-1, -1], [0, -1], [1, -1], [-1, 1]]
  attr_accessor :is_bomb, :revealed, :flagged, :board
  attr_reader :position

  def initialize(position)
    @is_bomb = false
    @revealed = false
    @flagged = false
    @position = position
  end

  def reveal
    self.revealed = true
    if is_bomb
      board.bomb_revealed = true
    elsif neighbor_bomb_count == 0
      neighbors.each { |neighbor| neighbor.reveal unless neighbor.revealed }
    end
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
    count = 0
    neighbors.each do |neighbor|
      count += 1 if neighbor.is_bomb
    end
    count
  end

  def inspect
    {:position => position, :is_bomb => is_bomb}.to_s
  end

  def to_s
    if board.bomb_revealed
      "!"
    elsif revealed && neighbor_bomb_count == 0
      "_"
    elsif revealed
      neighbor_bomb_count.to_s
    elsif flagged
      "F"
    else
      "*"
    end
  end

end
