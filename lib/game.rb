require_relative 'humanplayer'
require_relative 'computerplayer'

class Game
  # Create symbols for the colors and feedback pegs
  # Can reference directly by symbol name rather than index which is more readable
  COLORS = {
    R: 'Red',
    G: 'Green',
    B: 'Blue',
    Y: 'Yellow',
    P: 'Purple',
    O: 'Orange'
  }
  FEEDBACK = {
    K: 'Black',
    W: 'White'
  }

  def initialize
    @board = Array.new(12) { Array.new(4) }
    @feedback = Array.new(12) { Array.new(4) }
    @code_maker = ComputerPlayer.new
    # @code_maker = HumanPlayer.new
    @code_breaker = HumanPlayer.new
    @secret_code = nil
  end

  def play
    puts 'Welcome to Mastermind!'
    puts "The code maker is #{@code_maker.name} and the code breaker is #{@code_breaker.name}"

    set_secret_code
    debug_print_secret_code
    print_legend
    print_board
    print_feedback
  end

  def set_secret_code
    @secret_code = @code_maker.get_secret_code(COLORS)
  end

  def print_board
    puts 'Board:'
    @board.each do |row|
      puts '|| ' + row.join(' | ') + ' ||'
    end
  end

  def print_feedback
    puts 'Feedback:'
    @feedback.each do |row|
      puts '|| ' + row.join(' | ') + ' ||'
    end
  end

  def print_legend
    puts "Color Legend:"
    COLORS.each { |symbol, name| puts "#{symbol}: #{name}" }
    puts "Feedback Legend:"
    FEEDBACK.each { |symbol, name| puts "#{symbol}: #{name}" }
  end

  def debug_print_secret_code
    puts "Secret Code: #{@secret_code.join(' ')}"
  end
end
