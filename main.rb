require 'colorize'
# code pegs: used by both players for making and guessing secret code
# key pegs: used by codemaker for feedback after codebreaker guesses
key_pegs = %w[black white]
# gameplay -> codemaker chooses code based on agreed upon rules -> 12 turns with 2 parts to each turn: guessing and feedback
# codebreaker's part -> make a guess with 4 'pegs'
# codemaker's part -> feedback. 1 black peg for each 'peg' in correct color AND position | 1 white peg for each peg correct in color only
# scoring -> only codemaker gets points in round | player with highest total points after all rounds finished

# human vs computer
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

# ask player whether duplicates and/or blanks are allowed also how many games
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
    puts ' - The computer will generate a secret code consisting of 4 color pegs that will look something like this:'
    puts @@pegs.example_code
    puts " - The code will consist of 4 colors but there are SIX POSSIBLE COLORS to choose from:\n\n"
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
    puts " - Each round, you will guess the secret code and the computer will give feedback based on your guess.\n\n"
  end

  def code_generating
    puts "\n\nThe computer has generated a 4-peg secret code based off the six color pegs shown above.\n\n"
  end

  def explain_guessing
    puts @@pegs.game_pegs
  end

  def explain_feedback; end
end

# guesses, feedback, keeping score
class Game
  include Questions
  include Instructions

  def initialize
    general_explanation
    @rounds_left = 12
    allow_duplicates?
    allow_blanks?
    @games_left = number_of_games
    @pegs = PegSet.new
    code_generating
    code_breaker_guess
  end

  def generate_secret_code; end

  def code_breaker_guess
    puts "\n\nIn order to make a guess, type the first letter of the color you would like to guess. Also, dont forget your answers to the previous questions about duplicates and blanks.".yellow
    puts "\n\nFor example, if this is the pattern you're guessing, it looks like this:\n\n".yellow
    explain_guessing
    puts

  end

  def codemaker_feedback; end

  def keep_score; end
end

Game.new
