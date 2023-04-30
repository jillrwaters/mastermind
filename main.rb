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
    puts 'Player 2, what is your name?'
    @player2_name = gets.chomp
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
class DecodingBoard

  def initialize
    @red = '    red    '.on_red
    @blue = '   blue    '.on_blue
    @green = '   green   '.on_green
    @yellow = '  yellow   '.on_yellow
    @magenta = '  magenta  '.on_magenta
    @cyan = '   cyan    '.on_cyan
    @black = ' black '.on_black
    @white = ' white '.on_white
  end

  def code_pegs
    puts @red + @blue + @green + @yellow + @magenta + @cyan
  end

  def feedback_pegs
    puts @black + @white
  end
end

DecodingBoard.new.code_pegs
DecodingBoard.new.feedback_pegs

# players must agree on whether duplicates and/or blanks are allowed also how many games
module Agreements
  def allow_duplicates?
    puts 'Do you want to allow duplicates in the secret code? Press Y for yes or N for no.'
    raise 'Enter Y or N only' unless %w[y n yes no].include?(gets.chomp.downcase)
  rescue=>e
    puts e.message
    retry
  end

  def allow_blanks?
    # if true, codemaker can use up to 4 blank or same color | if false: codebreaker can't use blanks for guesses
    puts 'Do you want to allow blanks in the secret code? Press Y for yes or N for no.'
    raise 'Enter Y or N only' unless %w[y n yes no].include?(gets.chomp.downcase)
  rescue=>e
    puts e.message
    retry
  end

  def number_of_games
    puts 'How many games would you like to play? Enter a number less than 20.'
    raise "\n\nERROR\n\n You must enter a number less than 20" unless gets.chomp.to_i < 20
  rescue=>e
    puts e.message
    retry
  end
end

module Instructions

def intro
 
end

def rules
  puts 
end

end

# guesses, feedback, keeping score
class Game
  include Agreements

  def initialize
    @players = PlayerSet.new
    @rounds_left = 12
    @code_pegs = %w(blue green yellow red purple pink)
    @games_left = number_of_games
    allow_duplicates?
    allow_blanks?
  end

  def explain_game
    puts 'Welcome to Mastermind!'.red
    puts 'This is a code-breaking game for two players.'
    puts
    puts 'One player will be the codemaker and one will be the codebreaker. The codemaker will choose from six colors to make a 4-color code.'
    puts
    puts 'First, decide how many games you would like to play. It must be an even number.'
    puts
    puts 'Next, decide w'
  end

  def codebreaker_guess; end

  def codemaker_feedback; end
end

Game.new.explain_game
