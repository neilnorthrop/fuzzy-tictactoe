#! /usr/bin/env ruby

require './board.rb'
require 'pp'

class Tictactoe < Board
	def initialize(board)
		@board = board
	end

	def check_position(row, position)
		@board.board[row][position]
	end

	def clear_board
		@board.board.clear_board
	end

	def check_game
		case @board.board
		when [["x", "x", "x"], [1, 2, 3], [1, 2, 3]]
			"x is the winner!"
		when [[1, 2, 3], ["x", "x", "x"], [1, 2, 3]]
			"x is the winner!"
		when [[1, 2, 3], [1, 2, 3], ["x", "x", "x"]]
			"x is the winner!"
		when [[1, 2, "x"], [1, 2, "x"], [1, 2, "x"]]
			"x is the winner!"
		when [[1, "x", 3], [1, "x", 3], [1, "x", 3]]
			"x is the winner!"
		when [["x", 2, 3], ["x", 2, 3], ["x", 2, 3]]
			"x is the winner!"
		when [["x", 2, 3], [1, "x", 3], [1, 2, "x"]]
			"x is the winner!"
		when [[1, 2, "x"], [1, "x", 3], ["x", 2, 3]]
			"x is the winner!"
		when [["o", "o", "o"], [1, 2, 3], [1, 2, 3]]
			"o is the winner!"
		when [[1, 2, 3], ["o", "o", "o"], [1, 2, 3]]
			"o is the winner!"
		when [[1, 2, 3], [1, 2, 3], ["o", "o", "o"]]
			"o is the winner!"
		when [[1, 2, "o"], [1, 2, "o"], [1, 2, "o"]]
			"o is the winner!"
		when [[1, "o", 3], [1, "o", 3], [1, "o", 3]]
			"o is the winner!"
		when [["o", 2, 3], ["o", 2, 3], ["o", 2, 3]]
			"o is the winner!"
		when [["o", 2, 3], [1, "o", 3], [1, 2, "o"]]
			"o is the winner!"
		when [[1, 2, "o"], [1, "o", 3], ["o", 2, 3]]
			"o is the winner!"
		end
	end
end

# require 'minitest/autorun'
# require 'minitest/unit'

# class TestTictactoe < Minitest::Unit::TestCase

# 	def setup
# 		@test_game = Tictactoe.new(Board.new)
# 		@test_game.board.build_board
# 		@clear_game_board = Tictactoe.new(Board.new)
# 		@clear_game_board.board.build_board
# 	end

# 	def test_building_game_class
# 		assert @test_game
# 	end

# 	def test_game_class_responds_to_board
# 		assert @test_game.board
# 	end

# 	def test_game_includes_default_size_board
# 		assert_equal [[1, 2, 3], [1, 2, 3], [1, 2, 3]], @test_game.board.board
# 	end

# 	def test_for_checking_an_x_position_on_the_board
# 		@test_game.board.set_position(0,0,"x")
# 		assert_equal "x", @test_game.check_position(0,0)
# 	end

# 	def test_for_checking_an_o_position_on_the_board
# 		@test_game.board.set_position(0,0,"o")
# 		assert_equal "o", @test_game.check_position(0,0)
# 	end

# 	def test_checking_for_an_x_win_on_row_one
# 		@test_game.board.set_position(0,0,"x")
# 		@test_game.board.set_position(0,1,"x")
# 		@test_game.board.set_position(0,2,"x")
# 		assert_equal "x is the winner!", @test_game.check_game
# 	end

# 	def test_checking_for_an_o_win_on_row_one
# 		@test_game.board.set_position(0,0,"o")
# 		@test_game.board.set_position(0,1,"o")
# 		@test_game.board.set_position(0,2,"o")
# 		assert_equal "o is the winner!", @test_game.check_game
# 	end

# 	def test_checking_for_an_x_win_on_row_two
# 		@test_game.board.set_position(1,0,"x")
# 		@test_game.board.set_position(1,1,"x")
# 		@test_game.board.set_position(1,2,"x")
# 		assert_equal "x is the winner!", @test_game.check_game
# 	end

# 	def test_checking_for_an_o_win_on_row_two
# 		@test_game.board.set_position(1,0,"o")
# 		@test_game.board.set_position(1,1,"o")
# 		@test_game.board.set_position(1,2,"o")
# 		assert_equal "o is the winner!", @test_game.check_game
# 	end

# 	def test_checking_for_an_x_win_on_row_two
# 		@test_game.board.set_position(2,0,"x")
# 		@test_game.board.set_position(2,1,"x")
# 		@test_game.board.set_position(2,2,"x")
# 		assert_equal "x is the winner!", @test_game.check_game
# 	end

# 	def test_checking_for_an_o_win_on_row_two
# 		@test_game.board.set_position(2,0,"o")
# 		@test_game.board.set_position(2,1,"o")
# 		@test_game.board.set_position(2,2,"o")
# 		assert_equal "o is the winner!", @test_game.check_game
# 	end

# 	def test_clearing_the_board
# 		@test_game.board.set_position(1,0,"x")
# 		@test_game.board.set_position(1,1,"o")
# 		@test_game.board.set_position(1,2,"x")
# 		assert_kind_of Array, @test_game.board.board

# 		@test_game.board.clear_board
		
# 		assert_equal @clear_game_board.board.board, @test_game.board.board
# 	end

# end





























































































































































































