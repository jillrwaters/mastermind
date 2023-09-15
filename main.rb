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
  @@sample_pegset = PegSet.new

  def general_explanation
    puts
    puts 'M A S T E R M I N D '.light_magenta
    puts "\nHOW TO PLAY:".yellow
    puts " - The computer will generate a secret code consisting of 4 color pegs that look something like this:\n\n"
    puts @@sample_pegset.example_code
    puts " - The secret code has 4 colors but there are SIX POSSIBLE COLORS to choose from:\n\n"
    puts @@sample_pegset.game_pegs
    puts ' - There are no duplicate or blank pegs in the above secret code. One with duplicates could look like this:'
    puts
    puts @@sample_pegset.example_code_with_duplicates
    puts ' - And a code with a blank:'
    puts
    puts @@sample_pegset.example_code_with_blanks
    puts ' - There could even be a code with all duplicates:'
    puts
    puts @@sample_pegset.example_code_with_all_duplicates
    puts ' - Or with all blanks:'
    puts
    puts @@sample_pegset.example_code_with_all_blanks
    puts '*** You do not have to allow duplicates and/or blanks in your games. ***'.red
    puts
    puts " - Each game has 12 rounds.\n\n"
    puts " - Each round, you attempt to guess the secret code and the computer gives feedback based on your guess.\n\n"
  end

  def explain_code_generation
    puts '----------'
    puts "\n\nThe computer has randomly generated a 4-peg secret code based off the six color pegs shown above. You must guess correctly to get a point.\n\nIf you don't guess the secret code within 12 rounds of a game, the computer gets the point." 
    puts "\n\nThe player with the highest score at the end of all the games wins."
    puts '----------'
  end

  def explain_guessing
    puts "\n\nH O W  T O  M A K E  A  G U E S S\n\n".yellow
    puts @@sample_pegset.game_pegs # <- show blank too depending if they allow blanks
    puts "Use the abbreviation correspending to the color you would like to guess.\n\nrd bl cy --\n"
    puts "To guess a blank, enter '--' in place of the letter abbreviation."
    puts @@sample_pegset.example_code_with_blanks
    puts "and you would type this: 'bl rd cy yl' (blue, red, cyan, yellow) and press enter to make your guess.\n\n"
    puts
    puts "Here's what you have to choose from: \n\n"
    puts @pegs.game_pegs
    puts "A secret code has been generated.\n".blue
    puts "Enter your guess below:\n\n"
    puts "F O R  E X A M P L E:\n>> enter 'rd bl yl mg' to guess 'red blue yellow magenta'.\n>> use '--' for blanks: 'rd -- mg yl'".light_black
  end

  def explain_feedback
  puts "Feedback looks like this:\n\n"
  puts @@sample_pegset.black + @@sample_pegset.white
  end
end

module Feedback
  def correct_color?; end 
  # if individual peg color is correct - does color exist in the secret array

  def correct_position?; end 
  # is the color in the correct position in the secret code
end

module Guess
  @@guess = []
  def show_current_guess; end

  def request_guess
    explain_guessing
    guess = gets.chomp.downcase
    [guess]
  end

  def blanks?; end

  def duplicates?; end

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
    @secret_code = generate_secret_code
    request_guess
  end

  def generate_secret_code
    secret_code = []
    @pegs.game_pegs

    # # if player allowed duplicates
    # if @allow_duplicates?
    # end

    # # if player allowed blanks
    # if allow_blanks?
    # end
  
    # require "pry-byebug" ; binding.pry
  end

  def check_for_duplicates; end

  def codemaker_feedback; end

  def keep_score; end
end

Game.new.secret_code

