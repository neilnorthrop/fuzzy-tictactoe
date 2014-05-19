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
		@game.board.build_board
		full_game
	when 'no'
		puts "too bad\n\n"
		exit
	else
		puts "you need to pick 'yes' or 'no'\n\n"
		enter_game
	end
end

def display(board)
	print board[0]
	puts
	print board[1]
	puts
	print board[2]
	puts
end

def player_case(num)
	case num.to_i
	when 1
		return [0,0]
	when 2
		return [0,1]
	when 3
		return [0,2]
	when 4
		return [1,0]
	when 5
		return [1,1]
	when 6
		return [1,2]
	when 7
		return [2,0]
	when 8
		return [2,1]
	when 9
		return [2,2]
	else
		puts "* " * 15 + "Please pick a number 1-9" + " *" * 15
		full_game
	end
end

def winner_check
	if @game.check_game == "x is the winner!"
		puts "x wins"
		enter_game
	elsif @game.check_game == "o is the winner!"
		puts "o wins"
		enter_game
	else
		puts "nothing yet"
	end
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

def computer_turn
	if @game.check_position(1,1) != "x" && @game.check_position(1,1) != "o"
		@game.board.set_position(1,1,"o")
	end
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

def full_game

	puts "Please pick the number to where you want to play:\n"
	
	display(@game.board.board)
	
	player_number_picked = gets.chomp

	player_number_picked = if player_number_picked =~ /\d/
		player_case(player_number_picked)
	else
		puts "* " * 15 + "Please pick a number 1-9" + " *" * 15
		full_game
	end

	@game.board.set_position(player_number_picked[0], player_number_picked[1], "x")
	winner_check

	computer_turn
	winner_check

	full_game
end

enter_game










































































































