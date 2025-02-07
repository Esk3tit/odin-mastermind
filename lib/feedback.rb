module FeedbackGenerator
  def self.generate_feedback(guess, secret_code)
    feedback = []
    unprocessed_secret_colors = Hash.new(0)
    unprocessed_guess_colors = Hash.new(0)

    guess.each_with_index do |peg, index|
      # If the peg is in the correct position, add a black peg to the feedback
      if peg == secret_code[index]
        feedback << :K
      else
        # If the peg is in the wrong position, track the color in both the secret and guess
        # Since we could encounter these colors later in both the secret and guess
        # and it could end up being a white peg
        unprocessed_secret_colors[peg] += 1
        unprocessed_guess_colors[secret_code[index]] += 1
      end
    end

    # Process the white pegs
    unprocessed_guess_colors.each do |color, count|
      white_pegs = [count, unprocessed_secret_colors[color]].min
      white_pegs.times { feedback << :W }
    end

    # Fill in the feedback array with nil values for any remaining positions
    (4 - feedback.length).times { feedback << nil }

    return feedback
  end
end
