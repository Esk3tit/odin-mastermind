require_relative 'humanplayer'
require_relative 'computerplayer'
require_relative 'feedback'
require 'pry-byebug'

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

  def initialize(code_maker_class, code_breaker_class)
    @num_guesses = 12
    @current_guess = 0
    @is_win = false
    @board = Array.new(@num_guesses) { Array.new(4) }
    @feedback = Array.new(@num_guesses) { Array.new(4) }
    @code_maker = code_maker_class.new
    @code_breaker = code_breaker_class.new
    @secret_code = nil
  end

  def play
    puts 'Welcome to Mastermind!'
    puts "The code maker is #{@code_maker.name} and the code breaker is #{@code_breaker.name}"

    print_legend
    set_secret_code
    
    until @current_guess == @num_guesses || @is_win
      debug_print_secret_code
      print_board
      print_feedback

      break if @is_win

      get_code_guess
      process_feedback
      @is_win = is_code_correct_by_feedback?
      @current_guess += 1
    end

    print_result
  end

  def set_secret_code
    if @code_maker.is_a?(HumanPlayer)
      puts 'Enter your secret code (4 colors, no spaces): '
      @secret_code = @code_maker.get_code_input(COLORS)
    else
      puts 'Computer is setting secret code...'
      @secret_code = @code_maker.get_secret_code(COLORS)
    end
  end

  def get_code_guess
    if @code_breaker.is_a?(HumanPlayer)
      puts 'Enter your guess (4 colors, no spaces): '
      @board[@current_guess] = @code_breaker.get_code_input(COLORS)
    else
      first_guess = @current_guess == 0
      if first_guess
        @code_breaker.generate_candidate_codes(COLORS)
      end
      @board[@current_guess] = @code_breaker.get_code_guess(COLORS, first_guess)
    end
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

  def print_result
    if @is_win
      puts "You win! You guessed the secret code in #{@current_guess} guesses!"
    else
      puts "You lose! The secret code was #{@secret_code.join(' ')}"
    end
  end

  def is_code_correct_by_feedback?
    @feedback[@current_guess].length == 4 && @feedback[@current_guess].all? { |peg| peg == :K }
  end

  # Set feedback pegs based on guess and secret code
  def process_feedback
    @feedback[@current_guess] = FeedbackGenerator.generate_feedback(@board[@current_guess], @secret_code)
    if @code_breaker.is_a?(ComputerPlayer)
      @code_breaker.filter_candidate_codes(@board[@current_guess], @feedback[@current_guess])
    end
  end
end
