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

def check_for_winner
end

def display(board)
	@game.board.log.debug "[#{board.board[0]}, #{board.board[1]}, #{board.board[2]}], [#{board.board[3]}, #{board.board[4]}, #{board.board[5]}], [#{board.board[6]}, #{board.board[7]}, #{board.board[8]}]\n"
	print "[#{board.board[0]}, #{board.board[1]}, #{board.board[2]}]\n[#{board.board[3]}, #{board.board[4]}, #{board.board[5]}]\n[#{board.board[6]}, #{board.board[7]}, #{board.board[8]}]\n"
end

def player_turn
	print `clear`
	@play_this_turn = 0
	puts "Please pick the number to where you want to play:\n"

	display(@game.board)

	gets.chomp

	player_position = if $_ =~ /\d{1}/
											$_.to_i
										else
											@game.board.log.debug "Player chose: #{$_}"
											puts "* " * 15 + "Please pick a number 1-9" + " *" * 15
											player_turn
										end

	if @game.board.board[@game.board.board.find_index(player_position)] == nil
		player_turn
	else
		@game.board.set_position(player_position, "X")
	end
end

def game_win
	if @game.check_game == "PLAYER WINS!"
		puts "PLAYER WINS!"
		enter_game
	elsif @game.check_game == "COMPUTER WINS!"
		puts "COMPUTER WINS!"
		enter_game
	elsif @game.check_game == "IT IS A DRAW!"
		puts "IT IS A DRAW!"
		enter_game
	end
end

def game_loop
	print `clear`
	player_turn
	game_win

	@game.computer_turn
	game_win

	game_loop
end

enter_game

__END__





































































































