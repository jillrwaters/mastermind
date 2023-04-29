# code pegs: used by both players for making and guessing secret code
# key pegs: used by codemaker for feedback after codebreaker guesses
key_pegs = %w(black white)

number_of_games = 0
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

players = PlayerSet.new




# decoding board: 12 rows for guessing, 4 large holes and 8 small holes per row (4 on either side), 1 hidden row
module DecodingBoard; end 

# players must agree on whether duplicates and/or blanks are allowed also how many games
module Agreements
  def allow_duplicates?
    puts 'Do you want to allow duplicates in the secret code? Press Y for yes or N for no.'
    raise 'Enter Y or N only' unless gets.chomp.downcase == 'y'
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

# guesses, feedback, keeping score
class Game
  include Agreements

  def initialize
    @rounds_left = 12
    @code_pegs = %w(blue green yellow red purple pink)
    number_of_games
    allow_duplicates?
    allow_blanks?
  end

  def codebreaker_guess

  end

  def codemaker_feedback

  end
end

mastermind = Game.new