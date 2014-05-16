#! /usr/bin/env ruby

require './game.rb'

def enter_game
	puts "Do you want to play a game? yes or no"
	answer = gets.chomp.downcase

	case answer
	when 'yes'
		puts "okay, lets play\n\n" + "*" * 30 + "\n\n"
		puts "You'll start first and be the letter 'x'\n\n"
		@game = Tictactoe.new(Board.new)
		@game.board.build_board
		full_game
	when 'no'
		puts "too bad\n\n"
		exit
	else
		puts "you need to pick yes or no\n\n"
		enter_game
	end
end

def display
	puts "[1, 2, 3]"
	puts "[4, 5, 6]"
	puts "[7, 8, 9]\n"
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
		puts "please pick a number 1-9"
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

def computer_turn
	if @game.check_position(1,1) == 2
		@game.board.set_position(1,1,"o")
	end
end

def full_game

	puts "Please pick the number to where you want to play:\n"
	
	display
	
	player_pick = gets.chomp

	player_pick = if player_pick =~ /\d/
		player_case(player_pick)
	else
		puts "please pick a number 1-9"
		full_game
	end

	@game.board.set_position(player_pick[0], player_pick[1], "x")
	pp @game.board.display
	winner_check

	computer_turn
	pp @game.board.display
	winner_check

	full_game
end

enter_game










































































































