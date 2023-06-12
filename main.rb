require 'colorize'


# human vs computer

# computer generates secret code
# human guesses
# computer gives feedback until human guesses correctly or 12 turns are up
# computer gets point if human doesn't guess correctly
# human gets point if human guesses correctly
# repeat until 12 rounds are up
# player with most points wins
# if tie, play another round




class Player
  attr_accessor :human, :player2_name, :codemaker, :codebreaker

  def initialize
    @computer = computer
    puts 'What is your name?'
    @human = gets.chomp
    puts "Thanks, #{@human}! You will be the codebreaker.".light_black
  end
end

# decoding board: 12 rows for guessing, 4 large holes and 8 small holes per row (4 on either side), 1 hidden row
class PegSet
  attr_reader :blank

  def initialize
    @red = ' rd '.on_red
    @blue = ' bl '.on_blue
    @green = ' gr '.on_green
    @yellow = ' yl '.on_yellow
    @magenta = ' mg '.on_magenta
    @cyan = ' cy '.on_cyan
    @blank = '| -- |'
    @black = 'black'.on_black
    @white = 'white'.on_white
  end

  def game_pegs
    puts @red + @blue + @green + @yellow + @magenta + @cyan
  end

  def feedback_pegs
    puts @black + @white
  end

  def example_code
    puts @green + @magenta + @red + @cyan
  end

  def example_code_with_duplicates
    puts @cyan + @magenta + @cyan + @magenta
  end

  def example_code_with_blanks
    puts @blue + @blank + @cyan + @red
  end

  def example_code_with_duplicates_and_blanks
    puts @blank + @blank + @cyan + @green
  end

  def example_code_with_all_blanks
    puts @blank + @blank + @blank + @blank
  end

  def example_code_with_all_duplicates
    puts @yellow + @yellow + @yellow + @yellow
  end

  
end

# ask player whether duplicates and/or blanks are allowed 
# ask player how many games they want to play


module Questions
  def allow_duplicates?
    puts 'Do you want to allow duplicates in the secret code? Press Y for yes or N for no.'.light_green
    raise 'Enter Y or N only' unless %w[y n yes no].include?(gets.chomp.downcase)
  rescue=>e
    puts e.message
    retry
  end

  def allow_blanks?
    # if true, codemaker can use up to 4 blank or same color | if false: codebreaker can't use blanks for guesses
    puts 'Do you want to allow blanks in the secret code? Press Y for yes or N for no.'.light_green
    raise 'Enter Y or N only' unless %w[y n yes no].include?(gets.chomp.downcase)
  rescue=>e
    puts e.message
    retry
  end

  def number_of_games
    puts 'How many games would you like to play? Enter a number less than 20.'.light_green
    amount = gets.chomp.to_i
    raise "\n\nERROR You must enter a number less than 20\n\n" unless amount < 20 
  rescue=>e
    puts e.message
    retry
  end
end

# explain how to play the game
module Instructions
  @@pegs = PegSet.new

  def general_explanation
    puts
    puts 'M A S T E R M I N D '.light_magenta
    puts "\nHOW TO PLAY:".yellow
    puts " - The computer will generate a secret code consisting of 4 color pegs that look something like this:\n\n"
    puts @@pegs.example_code
    puts " - The secret code has 4 colors but there are SIX POSSIBLE COLORS to choose from:\n\n"
    puts @@pegs.game_pegs
    puts ' - There are no duplicate or blank pegs in the above secret code. One with duplicates could look like this:'
    puts
    puts @@pegs.example_code_with_duplicates
    puts ' - And a code with a blank:'
    puts
    puts @@pegs.example_code_with_blanks
    puts ' - There could even be a code with all duplicates:'
    puts
    puts @@pegs.example_code_with_all_duplicates
    puts ' - Or with all blanks:'
    puts
    puts @@pegs.example_code_with_all_blanks
    puts '*** You do not have to allow duplicates and/or blanks in your games. ***'.red
    puts
    puts " - Each game consists of 12 rounds.\n\n"
    puts " - Each round, you will attempt to guess the secret code and the computer will give feedback based on your guess.\n\n"
  end

  def code_generating
    puts '----------'
    puts "\n\nThe computer has randomly generated a 4-peg secret code based off the six color pegs shown above. You must guess it correctly to get a point.\n\nIf you don't guess the secret code within 12 rounds of a game, the computer gets the point. The player with the highest score wins." 
    puts '----------'
  end

  def explain_guessing
    puts "\n\nH O W  T O  G U E S S".yellow
    puts "To make a guess, type the letters for the color you would like to guess. Also, dont forget your answers to the previous questions about duplicates and blanks.\n\n"
    puts "To guess a blank, enter '--' when prompted."
    puts "\n\nFor example, when prompted to make your guess for the first slot in the code, it looks like this:\n\n"
    puts @@pegs.example_code_with_blanks
    puts "and you would type this: 'bl' and press enter to make your guess.\n\n"
    puts "You can only input two letters at a time, and they must be included in the list of colors. "
    puts "Here's what you have to choose from: \n\n"
    puts @pegs.game_pegs
    puts "A secret code has been generated.\n".blue + "You may begin guessing by typing the first color in your guess and pressing enter:"
    puts
    puts "For example, enter 'rd' for red."
  end

  def explain_feedback; end
end

module Feedback

end

module Guess
  @@guess = []
  def show_current_guess; end

  def request_guess
    explain_guessing
    guess = gets.chomp.downcase
    [guess]
  end


end

# guesses, feedback, keeping score
class Game
  include Questions
  include Instructions
  include Guess
  include Feedback

  def initialize
    general_explanation
    @rounds_left = 12
    allow_duplicates?
    allow_blanks?
    @games_left = number_of_games
    @pegs = PegSet.new
    @secret_code = []
    request_guess
  end

  def generate_secret_code
    colors = @pegs.game_pegs

    4.times do |color|
      color = colors.random
      @secret_code << color
    end
  end



  def codemaker_feedback; end

  def keep_score; end
end

Game.new
