#! /usr/bin/env ruby

require 'pp'

class Board
	attr_accessor :board

	def initialize(size=3)
		@size = size
		@board = []
	end

	def board_size
		@size
	end

	def build_board
		@board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
		return @board
	end

	def set_position(row, index, letter)
		if @board[row][index] == "x" || @board[row][index] == "o"
			return false
		else
			@board[row][index] = letter
		end
	end

	def clear_board
		@board = []
		build_board
	end
end

# require 'minitest/autorun'
# require 'minitest/unit'

# class TestBoard < MiniTest::Unit::TestCase

# 	SIZES = [3, 4, 5, 6, 7, 8, 9, 10]

# 	def setup
# 		@test_board = Board.new
# 		@test_board.build_board
# 	end

# 	def test_building_board_class
# 		assert Board.new
# 	end

# 	def test_board_size_default_is_three
# 		assert_equal 3, @test_board.board_size
# 	end

# 	def test_board_size_can_be_multiple_sizes
# 		SIZES.each do |num|
# 			test_board = Board.new(num)
# 			assert_equal num, test_board.board_size
# 		end
# 	end

# 	def test_building_default_board_size
# 		assert_kind_of Array, @test_board.board
# 	end

# 	def test_building_a_board_four_squares_across
# 		test_board = Board.new(4)
# 		assert_kind_of Array, test_board.build_board
# 	end

# 	def test_setting_a_position_on_the_board
# 		@test_board.set_position(0,1,"x")
# 		assert_includes @test_board.board[0], "x"
# 	end

# 	def test_setting_another_position_on_the_board
# 		@test_board.set_position(0,1,"x")
# 		@test_board.set_position(1,0,"x")
# 		assert_equal [[1, "x", 3], ["x", 2, 3], [1, 2, 3]], @test_board.board
# 	end

# 	def test_that_board_displays
# 		assert_equal "[[1, 2, 3], [1, 2, 3], [1, 2, 3]]", @test_board.display
# 	end

# end
















































































































































































































































