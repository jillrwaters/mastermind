require 'colorize'

def allow_duplicates?
    puts 'Do you want to allow duplicates in the secret code? Press Y for yes or N for no.'.light_yellow
    answer = gets.chomp.downcase
    raise 'Enter Y or N only'.red unless %w[y n yes no].include?(answer)
  rescue=>e
    puts e.message
    retry
  end


# pick a secret code ::
    # 6 colors to choose from 
        # 4 times pick a color randomly and push to empty array
    # 4 char code / empty array ^

def test_generate_secret_code(colors)
    secret_code = []
    4.times do |i = 0|
        new_color = colors.sample
        secret_code << new_color
        i += 1
    end

    secret_code
end

if !allow_duplicates?
    # generate a secret code. if the code has duplicates, remove them, and replace with another color that is not a duplicate
end

colors = %w[red blue green purple pink yellow]
# generate_secret_code_no_duplicates_no_blanks(colors)
puts test_generate_secret_code(colors)



# tell the user u picked a secret code and they have to guess it

# give examples of how they can guess

# tell user about feedback

# give examples of feedback

# ask how many games they want to play

# explain duplicates

# ask if they want to allow duplicates in the secret code





# explain blanks

# ask if they want to allow blanks

# start games :: x amount of games 
# start guessing - 12 rounds ::
    # ask for guess
    # process guess
        # if the color and index match
        # if only the color matches
        # if neither matches
    # give feedback 