require 'colorize'


# human vs computer

# computer generates secret code
def generate_secret_code(duplicates_allowed, blanks_allowed, colors)
  secret_code = []
  4.times do |new_color|
    new_color = colors.sample
    # if duplicates are not allowed, check if the new color is already in the secret code
    if !duplicates_allowed
        while secret_code.include?(new_color)
            new_color = colors.sample
        end
    # if blanks are allowed, add 'blank' to the colors array
    elsif blanks_allowed
        colors << 'BLANK'
        new_color = colors.sample
    end
    secret_code << new_color
  end

  puts secret_code
  puts '------------------'
end

generate_secret_code(true, true, %w[red blue green purple pink yellow])
generate_secret_code(true, false, %w[red blue green purple pink yellow])
generate_secret_code(false, true, %w[red blue green purple pink yellow])
generate_secret_code(false, false, %w[red blue green purple pink yellow])

# human guesses
def human_guess
  puts 'What is your guess?'
  guess = gets.chomp.downcase
  guess.split(' ')
end

# computer gives feedback until human guesses correctly or 12 turns are up
def computer_feedback(human_guess)
    guess = human_guess
    secret_code = generate_secret_code(false, false, %w[red blue green purple pink yellow])
    feedback = []

    guess.each_with_index do |color, index|
        # if the color is in the secret code, check if it is in the correct position
        if secret_code.include?(color)
            if secret_code[index] == color
                feedback << 'black'
            else
                feedback << 'white'
            end
        end
    end
    
    feedback
end

# puts computer_feedback(human_guess)



# computer gets point if human doesn't guess correctly
# human gets point if human guesses correctly
# repeat until 12 rounds are up
# player with most points wins
# if tie, play another round
