require 'colorize'
# code pegs: used by both players for making and guessing secret code
# key pegs: used by codemaker for feedback after codebreaker guesses
key_pegs = %w[black white]
# gameplay -> codemaker chooses code based on agreed upon rules -> 12 turns with 2 parts to each turn: guessing and feedback
# codebreaker's part -> make a guess with 4 'pegs'
# codemaker's part -> feedback. 1 black peg for each 'peg' in correct color AND position | 1 white peg for each peg correct in color only
# scoring -> only codemaker gets points in round | player with highest total points after all rounds finished

# 2 players: codemaker and codebreaker
class PlayerSet
  attr_accessor :player1_name, :player2_name, :codemaker, :codebreaker

  def initialize
    puts 'Player 1, what is your name?'
    @player1_name = gets.chomp
    puts "Thanks, #{@player1_name}! Your role will be randomly assigned momentarily.".light_black
    puts
    puts 'Player 2, what is your name?'
    @player2_name = gets.chomp
    puts "Thanks, #{@player2_name}! Your role will also be assigned momentarily.".light_black
    puts
    @player1_score = 0
    @player2_score = 0
    assign_roles
  end

  def assign_roles
    players = [@player1_name, @player2_name]
    @codemaker = players.sample
    @codebreaker = @player1_name if @codemaker == @player2_name
    @codebreaker = @player2_name if @codemaker == @player1_name
  end

  def switch_roles
    # alternate players for codemaker and codebreaker
    @codemaker = @codemaker == @player1_name ? @player2_name : @player1_name
    @codebreaker = @codebreaker == @player1_name ? @player2_name : @player1_name
  end

  def keep_score; end
end

# decoding board: 12 rows for guessing, 4 large holes and 8 small holes per row (4 on either side), 1 hidden row
class PegSet
  attr_reader :blank, :game_pegs
  def initialize
    @red = '    red    '.on_red
    @blue = '   blue    '.on_blue
    @green = '   green   '.on_green
    @yellow = '  yellow   '.on_yellow
    @magenta = '  magenta  '.on_magenta
    @cyan = '   cyan    '.on_cyan
    @blank = ' | blank | '
    @black = ' black '.on_black
    @white = ' white '.on_white
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

# players must agree on whether duplicates and/or blanks are allowed also how many games
module Agreements
  def allow_duplicates?
    puts 'Do you want to allow duplicates in the secret code? Press Y for yes or N for no.'.green
    raise 'Enter Y or N only' unless %w[y n yes no].include?(gets.chomp.downcase)
  rescue=>e
    puts e.message
    retry
  end

  def allow_blanks?
    # if true, codemaker can use up to 4 blank or same color | if false: codebreaker can't use blanks for guesses
    puts 'Do you want to allow blanks in the secret code? Press Y for yes or N for no.'.green
    raise 'Enter Y or N only' unless %w[y n yes no].include?(gets.chomp.downcase)
  rescue=>e
    puts e.message
    retry
  end

  def number_of_games
    puts 'How many games would you like to play? Enter an EVEN number less than 20.'.light_green
    amount = gets.chomp.to_i
    raise "\n\nERROR\n\n You must enter a number less than 20" unless amount < 20 
    raise "\n\nERROR\n\n You must enter an even number" unless amount.even?
  rescue=>e
    puts e.message
    retry
  end
end

module Instructions

  def general_explanation
    puts
    puts 'W E L C O M E   T O   M A S T E R M I N D'.light_magenta
    puts 'This is a game for two players where one person makes a secret code that the other attempts to guess.'
    puts
  end

  def overview_player_roles
    puts 'PLAYER ROLES - OVERVIEW'.yellow
    puts '-One player will be the codemaker and one will be the codebreaker.'
    puts '-In the first round of each game, the roles will be picked randomly by the computer.'
    puts '-After that, the roles will alternate until the end of all games.'
    puts
    puts 'Both players will now be asked to input your names.'.light_green
    puts
  end

  def explain_agreements
    puts 'PLAYER AGREEMENTS'.yellow
    puts '-Both parties must agree on a few things before starting the game.'
    puts
    puts 'Number of games to play:'.blue
    puts '-Each game consists of 12 rounds/turns.'
    puts '-In each round/turn, the codebreaker will make a guess and then the codemaker will give feedback.'
    puts '-Points are only awarded to the codemaker at the end of each game if the code was not guessed correctly.'
    puts '-Since the roles alternate each game, the number of games you choose must be an even number for fair scoring.'
    puts
    puts 'The other two agreements, whether to allow duplicates or blanks in the code will be explained below.'.light_black
    puts
  end

  def explain_codemaker_role

  end

  def explain_codebreaker_role

  end

  def explain_guessing

  end

  def explain_feedback

  end

  def explain_pegs
    pegs = PegSet.new
    puts
    puts 'PEGS'.yellow
    puts '-There are two types of colored pegs that will be used.'
    puts '-The first group of pegs are called' + ' code pegs'.red + '.'
    puts '-There are six possible colors to choose from:'
    puts
    puts pegs.game_pegs
    puts
    puts 'An example secret code might look like this:'
    puts
    puts pegs.example_code
    puts
    puts 'There are no duplicate or blank pegs in the above code. However, a code with duplicates could look like this:'
    puts
    puts pegs.example_code_with_duplicates
    puts
    puts 'And a code with a blank:'
    puts
    puts pegs.example_code_with_blanks
    puts
    puts 'You can even choose codes with all duplicates:'
    puts
    puts pegs.example_code_with_all_duplicates
    puts 
    puts 'Or with all blanks:'
    puts
    puts pegs.example_code_with_all_blanks
    puts
    puts 'To reiterate, you do not have to allow duplicates and blanks in your games.'
    puts


  end


  def explain_game
    puts 'The codemaker will choose from six colors to make a 4-color code. For example, here are the colors you can choose from.'
    puts code_pegs
    puts
    puts 'First, decide how many games you would like to play. It must be an even number.'
    puts
    puts 'Next, decide w'
  end

end

# guesses, feedback, keeping score
class Game
  include Agreements
  include Instructions

  def initialize
    general_explanation
    overview_player_roles
    @players = PlayerSet.new
    explain_agreements
    @rounds_left = 12
    @games_left = number_of_games
    explain_pegs
    allow_duplicates?
    allow_blanks?
  end

  def codebreaker_guess; end

  def codemaker_feedback; end
end

Game.new
