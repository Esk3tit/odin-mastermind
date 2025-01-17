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
end
