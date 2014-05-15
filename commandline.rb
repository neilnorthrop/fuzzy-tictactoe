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
		start_game
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
	puts "[7, 8, 9]"
end

def player_case(num)
	case num.to_i
	when 1
		puts "picked one"
	when 2
		puts "picked two"
	when 3
		puts "picked three"
	when 4
		puts "picked four"
	when 5
		puts "picked five"
	when 6
		puts "picked six"
	when 7
		puts "picked seven"
	when 8
		puts "picked eight"
	when 9
		puts "picked nine"
	else
		puts "please pick a number 1-9"
		start_game
	end
end

def start_game
	puts "Please pick the number to where you want to play:\n"
	
	display
	
	player_pick = gets.chomp

	if player_pick =~ /\d/
		player_pick
		player_case(player_pick)
	else
		puts "please pick a number 1-9"
		start_game
	end
end

enter_game