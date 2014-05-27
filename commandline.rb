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
		game_loop
	end
end

def check_for_winner
	if @game.board.board == [["x", "o", "x"], ["x", "o", "x"], ["o", "x", "o"]] ||
		 @game.board.board == [["x", "o", "x"], ["o", "o", "x"], ["x", "x", "o"]] ||
		 @game.board.board == [["x", "o", "x"], ["x", "o", "o"], ["o", "x", "x"]] ||
		 @game.board.board == [["o", "o", "x"], ["x", "x", "o"], ["o", "x", "x"]]
		puts "TIE"
		enter_game
	end
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

def computer_turn(board)
	if board == [["x", 2, 3], [4, 5, 6], [7, 8, 9]] ||
		 board == [[1, 2, "x"], [4, 5, 6], [7, 8, 9]] ||
		 board == [[1, 2, 3], [4, 5, 6], ["x", 8, 9]] ||
		 board == [[1, 2, 3], [4, 5, 6], [7, 8, "x"]]
		@game.board.set_position(1,1,"o")
	end
	if board == [[1, "x", 3], [4, 5, 6], [7, 8, 9]] ||
		 board == [[1, 2, 3], ["x", 5, 6], [7, 8, 9]] ||
		 board == [[1, 2, 3], [4, "x", 6], [7, 8, 9]]
		@game.board.set_position(0,0,"o")		
	end
	if board == [[1, 2, 3], [4, 5, "x"], [7, 8, 9]]
		@game.board.set_position(0,2,"o")
	end
	if board == [["x", 2, "o"], [4, 5, "x"], [7, 8, 9]] ||
		 board == [[1, "x", "o"], [4, 5, "x"], [7, 8, 9]] ||
		 board == [[1, 2, "o"], [4, "x", "x"], [7, 8, 9]]
		@game.board.set_position(1,0,"o")
	end
	if board == [[1, 2, "o"], ["x", 5, "x"], [7, 8, 9]]
		@game.board.set_position(1,1,"o")
	end
	if board == [[1, 2, "o"], ["o", "x", "x"], ["x", 8, 9]] ||
		 board == [[1, 2, "o"], ["o", "x", "x"], [7, 8, "x"]] 
		@game.board.set_position(0,0,"o")
	end














	if board == [[1, 2, 3], [4, 5, 6], [7, "x", 9]]
		@game.board.set_position(0,1,"o")
	end
	if board == [[1, "o", "x"], [4, 5, 6], [7, "x", 9]] ||
		 board == [["x", "o", 3], [4, 5, 6], [7, "x", 9]]
		@game.board.set_position(2,0,"o")
	end
	if board == [[1, "o", "x"], [4, "x", 6], ["o", "x", 9]]
		@game.board.set_position(0,0,"o")
	end
	if board == [["o", "o", "x"], ["x", "x", 6], ["o", "x", 9]]
		@game.board.set_position(1,2,"o")
	end
	if board == [["o", "o", "x"], [4, "x", "x"], ["o", "x", 9]]
		@game.board.set_position(1,0,"o")
	end
	if board == [["o", "o", "x"], [4, "x", 6], ["o", "x", "x"]]
		@game.board.set_position(1,0,"o")
	end
	if board == [["x", "o", "x"], [4, 5, 6], ["o", "x", 9]] ||
		 board == [[1, "o", "x"], ["x", 5, 6], ["o", "x", 9]]
		@game.board.set_position(1,1,"o")
	end
	if board == [["x", "o", "x"], ["x", "o", 6], ["o", "x", 9]] ||
		 board == [["x", "o", "x"], ["x", "o", 6], ["o", "x", 9]] ||
		 board == [[1, "o", "x"], ["x", "o", 6], ["o", "x", "x"]]
		@game.board.set_position(1,2,"o")
	end
	if board == [["x", "o", "x"], [4, "o", "x"], ["o", "x", 9]]
		@game.board.set_position(2,2,"o")
	end
	if board == [[1, "o", "x"], [4, 5, 6], ["o", "x", "x"]]
		@game.board.set_position(1,2,"o")
	end
	if board == [[1, "o", "x"], [4, "x", "o"], ["o", "x", "x"]]
		@game.board.set_position(0,0,"o")
	end
	if board == [["x", "o", "x"], [4, 5, "o"], ["o", "x", "x"]] ||
		 board == [[1, "o", "x"], ["x", 5, "o"], ["o", "x", "x"]]
		@game.board.set_position(1,1,"o")
	end
	if board == [["x", 2, "x"], [4, "o", 6], [7, 8, 9]] ||
		 board == [["x", 2, 3], [4, "o", "x"], [7, 8, 9]]
		@game.board.set_position(0,1,"o")
	end
	if board == [["x", "o", "x"], [4, "o", "x"], [7, 8, 9]] ||
		 board == [["x", "o", 3], ["x", "o", "x"], [7, 8, 9]] ||
		 board == [["x", "o", 3], [4, "o", "x"], ["x", 8, 9]] ||
		 board == [["x", "o", 3], [4, "o", "x"], [7, 8, "x"]]
		@game.board.set_position(2,1,"o")
	end
	if board == [["x", "o", 3], [4, "o", "x"], [7, "x", 9]]
		@game.board.set_position(2,0,"o")
	end
	if board == [["x", "o", "x"], [4, "o", "x"], ["o", "x", 9]]
		@game.board.set_position(2,2,"o")
	end
	if board == [["x", "o", "x"], ["x", "o", 6], [7, 8, 9]] ||
		 board == [["x", "o", "x"], [4, "o", 6], ["x", 8, 9]] ||
		 board == [["x", "o", "x"], [4, "o", 6], [7, 8, "x"]]
		@game.board.set_position(2,1,"o")
	end
	if board == [["x", "o", "x"], [4, "o", 6], [7, "x", 9]]
		@game.board.set_position(1,0,"o")
	end
	if board == [["x", "o", "x"], ["o", "o", "x"], [7, "x", 9]]
		@game.board.set_position(2,2,"o")
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

def game_loop
	# print `clear`
	puts "Please pick the number to where you want to play:\n"
	
	display(@game.board.board)
	
	player_choice = gets.chomp

	player_position = if player_choice =~ /\d/
		player_case(player_choice)
	else
		puts "* " * 15 + "Please pick a number 1-9" + " *" * 15
		game_loop
	end

	@game.board.set_position(player_position[0], player_position[1], "x")
	check_for_winner

	computer_turn(@game.board.board)
	check_for_winner

	game_loop
end

enter_game










































































































