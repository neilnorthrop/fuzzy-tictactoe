#! /usr/bin/env ruby

require './board.rb'
require 'pp'

class Tictactoe < Board
	attr_accessor :WINNING_POSITIONS

	WINNING_POSITIONS = [
		[0, 1, 2],
		[3, 4, 5],
		[6, 7, 8],
		[0, 3, 6],
		[1, 4, 7],
		[2, 5, 8],
		[0, 4, 8],
		[2, 4, 6]
	]

	def initialize(board)
		@board = board
		@WINNING_POSITIONS = WINNING_POSITIONS
	end

	def computer_turn
		players_moves, computer_moves, computer_move_this_turn = [], [], nil

		@board.board.each.with_index do |v,k|
			if v == "O"
				computer_moves << k
			elsif v == "X"
				players_moves << k
			end
		end

		if players_moves.count == 1
			if !players_moves.include?(4)
				computer_move_this_turn = 5
			elsif players_moves.include?(4)
				computer_move_this_turn = 1
			end
		else
			WINNING_POSITIONS.each do |row|
				if (row - computer_moves).count == 1
					if @board.board[(row - computer_moves).pop] != "O" && @board.board[(row - computer_moves).pop] != "X"
						computer_move_this_turn = @board.board[(row - computer_moves).pop]
						break
					end
				elsif (row - players_moves).count == 1
					if @board.board[(row - players_moves).pop] != "O" && @board.board[(row - computer_moves).pop] != "X"
						computer_move_this_turn = @board.board[(row - players_moves).pop]
					end
				end
			end
		end

		@board.set_position(computer_move_this_turn, "O")
	end

	def check_game
		players_moves, computer_move = [], []
		@board.board.each.with_index do |v,k|
			if v == "O"
				computer_move << k
			elsif v == "X"
				players_moves << k
			end
		end
		# WINNING_POSITIONS.each do |row|
		# 	if row == @board.computer_collection
		# 		puts "COMPUTER IS THE WINNER!"
		# 	end
		# end
		WINNING_POSITIONS.each do |row|
			if row == players_moves.sort
				puts "PLAYER IS THE WINNER!"
				enter_game
			end
		end
	end
end

if __FILE__==$0
	require 'minitest/autorun'
	require 'minitest/unit'
	puts `clear`

	class TestTictactoe < Minitest::Unit::TestCase

		def setup
			@test_game = Tictactoe.new(Board.new)
		end

		def test_building_game_class
			assert @test_game
		end

		def test_game_class_responds_to_board
			assert @test_game.board
		end

		def test_game_includes_default_size_board
			assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9], @test_game.board.board
		end

		def test_computer_turn_blocks_players_two_in_a_row_across
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(2, "X")
			@test_game.computer_turn
			assert_equal ["X", "X", "O", 4, 5, 6, 7, 8, 9], @test_game.board.board
		end

		def test_computer_turn_blocks_players_two_in_a_row_down
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(4, "X")
			@test_game.computer_turn
			assert_equal ["X", 2, 3, "X", 5, 6, "O", 8, 9], @test_game.board.board
		end

		def test_computer_turn_blocks_players_two_in_a_row_down_the_middle
			@test_game.board.set_position(1, "O")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(3, "O")
			@test_game.board.set_position(5, "X")
			@test_game.board.set_position(7, "X")
			@test_game.computer_turn
			assert_equal ["O", "X", "O", 4, "X", 6, "X", "O", 9], @test_game.board.board
		end

		def test_computer_turn_blocks_players_two_in_a_row_diagonal
			@test_game.board.set_position(5, "X")
			@test_game.board.set_position(1, "X")
			@test_game.computer_turn
			assert_equal ["X", 2, 3, 4, "X", 6, 7, 8, "O"], @test_game.board.board
		end

		def test_computer_turn_blocks_one_choice_out_of_two_choices
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(3, "O")
			@test_game.board.set_position(4, "O")
			@test_game.board.set_position(5, "X")
			@test_game.computer_turn
			assert_equal ["X", "X", "O", "O", "X", 6, 7, 8, "O"], @test_game.board.board
		end

		def test_computer_turn_takes_middle_if_player_doesnt_take
			@test_game.board.set_position(1, "X")
			@test_game.computer_turn
			assert_equal ["X", 2, 3, 4, "O", 6, 7, 8, 9], @test_game.board.board
		end

		def test_computer_turn_takes_middle_outter_if_player_takes_middle
			@test_game.board.set_position(5, "X")
			@test_game.computer_turn
			assert_equal ["O", 2, 3, 4, "X", 6, 7, 8, 9], @test_game.board.board
		end

		def test_computer_turn_takes_the_win_with_two_in_a_row_down
			@test_game.board.set_position(1, "O")
			@test_game.board.set_position(4, "O")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(3, "X")
			@test_game.board.set_position(6, "X")
			@test_game.computer_turn
			assert_equal ["O", "X", "X", "O", 5, "X", "O", 8, 9], @test_game.board.board
		end

		def test_computer_turn_takes_the_win_with_two_in_a_row_across
			@test_game.board.set_position(1, "O")
			@test_game.board.set_position(2, "O")
			@test_game.board.set_position(4, "X")
			@test_game.board.set_position(7, "X")
			@test_game.board.set_position(6, "X")
			@test_game.computer_turn
			assert_equal ["O", "O", "O", "X", 5, "X", "X", 8, 9], @test_game.board.board
		end

		def test_computer_turn_takes_the_win_with_two_in_a_row_diagonal
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(3, "O")
			@test_game.board.set_position(5, "O")
			@test_game.board.set_position(6, "X")
			@test_game.computer_turn
			assert_equal ["X", "X", "O", 4, "O", "X", "O", 8, 9], @test_game.board.board
		end
	end
end

__END__

[O, X, X]
[O, 5, X]
[O, 8, 9]

[1, 2, 3]
[4, 5, 6]
[7, 8, 9]

























































































































































































