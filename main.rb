

# code pegs: used by both players for making and guessing secret code


# key pegs: used by codemaker for feedback after codebreaker guesses
key_pegs = %w(black white)

number_of_games = 0



# gameplay -> codemaker chooses code based on agreed upon rules -> 12 turns with 2 parts to each turn: guessing and feedback
# codebreaker's part -> make a guess with 4 'pegs'
# codemaker's part -> feedback. 1 black peg for each 'peg' in correct color AND position | 1 white peg for each peg correct in color only
# scoring -> only codemaker gets points in round | player with highest total points after all rounds finished

class PlayerSet
  attr_reader :assign_roles
  attr_accessor :player1_name, :player2_name, :codemaker, :codebreaker

# 2 players: codemaker and codebreaker
  def initialize
    puts "Player 1, what is your name?"
    @player1_name = gets.chomp
    puts "Player 2, what is your name?"
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
    @codemaker == @player1_name ? @codemaker = @player2_name : @codemaker = @player1_name
    @codebreaker == @player1_name ? @codebreaker = @player2_name : @codebreaker = @player1_name
  end

  

  def keep_score ; end
end

players = PlayerSet.new
puts players.player1_name
puts
puts players.player2_name
puts "***"
# players.assign_roles
puts "codemaker is #{players.codemaker}"
puts
puts "codebreaker is #{players.codebreaker}"
puts "SWITCH"
players.switch_roles
puts "codemaker is #{players.codemaker}"
puts
puts "codebreaker is #{players.codebreaker}"

module DecodingBoard ; end # decoding board: 12 rows for guessing, 4 large holes and 8 small holes per row (4 on either side), 1 hidden row

module Agreements
# players must agree on whether duplicates and/or blanks are allowed - if true, codemaker can use up to 4 blank or same color | if false: codebreaker can't use blanks for guesses
# alternate players for codemaker and codebreaker
  def allow_duplicates? ; end
  def allow_blanks? ; end
  def number_of_rounds ; end # players must agree on a number of games which has to be an even number

end

class Game
  def initialize(number_of_games)
    @number_of_games = number_of_games
    @rounds_left = 12
    @code_pegs = %w(blue green yellow red purple pink)
  end

  def codebreaker_guess

  end

  def codemaker_feedback

  end
end

