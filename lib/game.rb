require_relative 'humanplayer'
require_relative 'computerplayer'

class Game
  # Create symbols for the colors and feedback pegs
  # Can reference directly by symbol name rather than index which is more readable
  COLORS = %i[R G B Y P O]      # Main colors (Red Green Blue Yellow Purple Orange)
  FEEDBACK = %i[K W]            # K for black, W for white feedback pegs

  def initialize
    @board = Array.new(12) { Array.new(4) }
    @code_maker = ComputerPlayer.new
    @code_breaker = HumanPlayer.new
  end

  def play
    puts 'Welcome to Mastermind!'
    puts 'The code maker is #{@code_maker.name} and the code breaker is #{@code_breaker.name}'
  end
end
