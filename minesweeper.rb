require_relative 'square'
require_relative 'board'
require 'yaml'

class MineSweeper
  attr_accessor :board

  def initialize(size = 9)
    @board = Board.new(size)
  end

  def over?
    lost? || won?
  end

  def lost?
    board.bomb_revealed
  end

  def won?
    board.grid.flatten.each do |tile|
      return false unless (tile.revealed || tile.is_bomb)
    end
    true
  end

  def play
    until over?
      play_turn
    end
    puts "You win!" if won?
    puts "You lose" if lost?
  end

  def play_turn
    puts "what would you like to do? Enter 'save' or an answer in the form of 'r/f, num, num' "
    move = gets.chomp.split(", ")
    save if move[0] == "save"

    pos = [move[1].to_i, move[2].to_i]
    if move[0] == "f"
      flag(pos)
    elsif move[0] == "r"
      reveal(pos)
    else
      puts "invalid input"
    end
  end

  def reveal(pos)
    board.reveal(pos)
    board.display
  end

  def flag(pos)
    board.flag(pos)
    board.display
  end

  def save
    saved_game = gets.chomp
    File.write(saved_game, self.to_yaml)
    Kernel.abort("Game saved!")
  end

end

if __FILE__ == $PROGRAM_NAME
  if ARGV[0]
    YAML.load_file(ARGV.shift).play
  else
    game = MineSweeper.new
    game.play
  end
end
