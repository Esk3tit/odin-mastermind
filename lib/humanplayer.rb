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
  def get_secret_code(colors)
    puts 'Enter your secret code (4 colors, no spaces): '
    code = gets.chomp.upcase.chars
    until is_valid_code(code, colors)
      puts 'Invalid code, try again: '
      code = gets.chomp.upcase.chars
    end
    code
  end

  private

  def is_valid_code(code, colors)
    code.length == 4 && code.all? { |color| colors.key?(color.to_sym) }
  end
end
