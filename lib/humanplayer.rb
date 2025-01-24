require_relative 'player'

class HumanPlayer < Player
  def initialize
    # Calls the superclass's initialize method with the name returned by get_name
    super(get_name)
  end

  def get_name
    puts 'Enter your name: '
    gets.chomp
  end

  # Get secret code, do validation and set it in Game class
  # This method is used for both code maker and code breaker
  def get_code_input(colors)
    code = gets.chomp.upcase.chars
    until is_valid_code?(code, colors)
      puts 'Invalid code, try again: '
      code = gets.chomp.upcase.chars
    end
    code
  end

  private

  def is_valid_code?(code, colors)
    code.length == 4 && code.all? { |color| colors.key?(color.to_sym) }
  end
end
