#! /usr/bin/env ruby

require './board.rb'
require 'pp'

class Tictactoe < Board

	WINNING_POSITIONS = [
		[1, 2, 3],
		[4, 5, 6],
		[7, 8, 9],
		[1, 4 ,7],
		[2, 5, 8],
		[3, 6, 9],
		[1, 5, 9],
		[3, 5, 7]
	]

	def initialize(board)
		@board = board
	end

	def check_position(position)
		@board.board[position]
	end

	def set_position(position, letter)
		@board.set_position(position, letter)
	end

	def clear_board
		@board.board.clear_board
	end

	def check_game
		if @board.board == ["X", "X", "X", 4, 5, 6, 7, 8, 9]
			puts "WINNER"
			exit
		end
		# WINNING_POSITIONS.each do |row|
		# 	if row == @COMPUTER.sort
		# 		puts "COMPUTER IS THE WINNER!"
		# 	end
		# end
		# WINNING_POSITIONS.each do |row|
		# 	if row == 
		# 		puts "PLAYER IS THE WINNER!"
		# 	end
		# end
	end
end

if __FILE__==$0
	require 'minitest/autorun'
	require 'minitest/unit'

	class TestTictactoe < Minitest::Unit::TestCase

		def setup
			@test_game = Tictactoe.new(Board.new)
			@clear_game_board = Tictactoe.new(Board.new)
			@clear_game_board.board.build_board
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

		def test_for_checking_an_x_position_on_the_board
			@test_game.set_position(player,0,"x")
			assert_equal "x", @test_game.check_position(0)
		end

		def test_for_checking_an_o_position_on_the_board
			skip
			@test_game.board.set_position(0,"o")
			assert_equal "o", @test_game.check_position(0)
		end

		def test_checking_for_an_x_win_on_row_one
			skip
			@test_game.set_position(PLAYER,0,"x")
			@test_game.set_position(PLAYER,1,"x")
			@test_game.set_position(PLAYER,2,"x")
			assert_equal "x is the winner!", @test_game.check_game
		end

		def test_checking_for_an_o_win_on_row_one
			skip
			@test_game.board.set_position(0,0,"o")
			@test_game.board.set_position(0,1,"o")
			@test_game.board.set_position(0,2,"o")
			assert_equal "o is the winner!", @test_game.check_game
		end

		def test_checking_for_an_x_win_on_row_two
			skip
			@test_game.board.set_position(1,0,"x")
			@test_game.board.set_position(1,1,"x")
			@test_game.board.set_position(1,2,"x")
			assert_equal "x is the winner!", @test_game.check_game
		end

		def test_checking_for_an_o_win_on_row_two
			skip
			@test_game.board.set_position(1,0,"o")
			@test_game.board.set_position(1,1,"o")
			@test_game.board.set_position(1,2,"o")
			assert_equal "o is the winner!", @test_game.check_game
		end

		def test_checking_for_an_x_win_on_row_two
			skip
			@test_game.board.set_position(2,0,"x")
			@test_game.board.set_position(2,1,"x")
			@test_game.board.set_position(2,2,"x")
			assert_equal "x is the winner!", @test_game.check_game
		end

		def test_checking_for_an_o_win_on_row_two
			skip
			@test_game.board.set_position(2,0,"o")
			@test_game.board.set_position(2,1,"o")
			@test_game.board.set_position(2,2,"o")
			assert_equal "o is the winner!", @test_game.check_game
		end

		def test_clearing_the_board
			skip
			@test_game.board.set_position(1,0,"x")
			@test_game.board.set_position(1,1,"o")
			@test_game.board.set_position(1,2,"x")
			assert_kind_of Array, @test_game.board.board

			@test_game.board.clear_board
			
			assert_equal @clear_game_board.board.board, @test_game.board.board
		end

	end
end



























































































































































































