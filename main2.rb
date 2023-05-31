require 'colorize'

# pick a secret code ::
    # 6 colors to choose from 
        # 4 times pick a color randomly and push to empty array
    # 4 char code / empty array ^

def generate_secret_code(colors)
    secret_code = []
    4.times do 
        # if duplicates are not allowed - use uniq
        begin
            new_color = colors.sample
            if secret_code.include?(new_color)
                raise "error!"
            else
                secret_code << new_color
            end
        rescue 
            retry
        end

        # -- uniq: Returns an array containing non-duplicate elements.
        # if blanks are allowed -- add 'blank' to the color array

    end
    p secret_code
end

colors = %w[red blue green purple pink yellow]
generate_secret_code(colors)



# tell the user u picked a secret code and they have to guess it

# give examples of how they can guess

# tell user about feedback

# give examples of feedback

# ask how many games they want to play

# explain duplicates

# ask if they want to allow duplicates in the secret code


def allow_duplicates?
    puts 'Do you want to allow duplicates in the secret code? Press Y for yes or N for no.'.light_yellow
    raise 'Enter Y or N only'.red unless %w[y n yes no].include?(gets.chomp.downcase)
  rescue=>e
    puts e.message
    retry
  end

#   puts allow_duplicates?

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