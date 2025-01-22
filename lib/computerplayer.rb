require_relative 'player'

class ComputerPlayer < Player
  def initialize
    super('Computer')
  end

  # Generate a random secret code with repetition allowed
  # Sample method itself doesn't allow for repetition,
  # so we need to do 4 calls to sample for repetition
  def get_secret_code(colors)
    4.times.map { colors.keys.sample }
  end
end
