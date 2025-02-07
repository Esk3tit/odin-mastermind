require_relative 'player'

class ComputerPlayer < Player
  def initialize
    super('Computer')
    @candidate_codes = []
  end

  # Generate a random secret code with repetition allowed
  # Sample method itself doesn't allow for repetition,
  # so we need to do 4 calls to sample for repetition
  def get_secret_code(colors)
    4.times.map { colors.keys.sample }
  end

  def generate_candidate_codes(colors)
    @candidate_codes = colors.keys.repeated_permutation(4).to_a
  end

  # Keep all codes that match the feedback for the guess if it were to be the secret code
  def filter_candidate_codes(guess, feedback)
    @candidate_codes.select do |code|
      FeedbackGenerator.generate_feedback(guess, code) == feedback
    end
  end

  # Guess 1122 for the first guess (where 1 is the first color, 2 is the second, etc.)
  # Then guess a random code from the remaining candidate codes in set after filtering if not the first guess
  def get_code_guess(colors, first_guess)
    if first_guess
      first_color = colors.keys[0]
      second_color = colors.keys[1]
      return [first_color, first_color, second_color, second_color]
    else
      @candidate_codes.sample
    end
  end
end
