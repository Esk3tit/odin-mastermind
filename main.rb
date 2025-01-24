require_relative 'lib/game'
require_relative 'lib/computerplayer'
require_relative 'lib/humanplayer'

Game.new(ComputerPlayer, HumanPlayer).play
