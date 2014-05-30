#! /usr/bin/env ruby

require './game.rb'

def enter_game
	puts "Do you want to play a game? Please type 'yes' or 'no'"
	answer = gets.chomp.downcase
	puts

	case answer
	when 'yes'
		puts "okay, lets play\n\n" + "*" * 30 + "\n\n"
		puts "You'll start first and be the letter 'x'\n\n"
		puts "\n\n" + "*" * 30 + "\n\n"
		@game = Tictactoe.new(Board.new)
		game_loop
	when 'no'
		print `clear`
		puts "too bad dude/dudette\n\n"
		exit
	else
		puts "you need to pick 'yes' or 'no'\n\n"
		enter_game
	end
end

def display
	@game.board.display
end

def check_for_winner
	@game.check_game
end

##################################################
# Computer turn to-dos:
# 
# 
# 
# 
# 
# 
##################################################

def computer_turn(board)
end

##################################################
# Game loop to-dos:
# work on the computer's turn logic
# 
#
#
#
#
##################################################

def game_loop
	# print `clear`
	puts "Please pick the number to where you want to play:\n"
	
	display
	
	player_choice = gets.chomp

	player_position = if player_choice =~ /\d/
											player_choice.to_i
										else
											puts "* " * 15 + "Please pick a number 1-9" + " *" * 15
											game_loop
										end

	@game.set_position(player_position, "X")
	check_for_winner

	computer_turn(@game.board.board)
	check_for_winner

	game_loop
end

enter_game










































































































