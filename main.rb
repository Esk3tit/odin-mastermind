require_relative 'lib/game'
require_relative 'lib/computerplayer'
require_relative 'lib/humanplayer'

# Loop the input until the user enters a valid choice
loop do
  puts 'Welcome to Mastermind!'
  puts 'Would you like to be the code maker or code breaker?'
  puts '1. Code Maker'
  puts '2. Code Breaker'

  choice = gets.chomp.to_i

  if choice == 1
    Game.new(HumanPlayer, ComputerPlayer).play
    break
  elsif choice == 2
    Game.new(ComputerPlayer, HumanPlayer).play
    break
  else
    puts 'Invalid choice. Please enter 1 or 2.'
  end
end
