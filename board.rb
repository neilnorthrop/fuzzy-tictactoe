#! /usr/bin/env ruby
require 'logger'

class Board
	attr_accessor :board, :log, :play_collection, :computer_collection

	def initialize
		@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		@play_collection = []
		@computer_collection = []
		@log = Logger.new "tictactoe.txt"
	end

	def set_position(position, letter)
		if @board.find_index(position) == nil
			return nil
		end
		index = @board.find_index(position)
		@board[index] = letter
	end

	def clear_board
		@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	end
end

if __FILE__==$0
	require 'minitest/autorun'
	require 'minitest/unit'

	class TestBoard < MiniTest::Unit::TestCase

		SIZES = [3, 4, 5, 6, 7, 8, 9, 10]

		def setup
			@test_board = Board.new
		end

		def test_building_board_class
			assert Board.new
		end

		def test_board_size_default_is_three
			skip
			assert_equal 3, @test_board.board_size
		end

		def test_building_a_board_four_squares_across
			skip
			test_board = Board.new(4)
			assert_kind_of Array, test_board.build_board
		end

		def test_board_size_can_be_multiple_sizes
			skip
			SIZES.each do |num|
				test_board = Board.new(num)
				assert_equal num, test_board.board_size
			end
		end

		def test_building_default_board_size
			assert_kind_of Array, @test_board.board
		end

		def test_setting_an_X_position_on_the_board
			@test_board.set_position(1, "X")
			assert_includes @test_board.board, "X"
		end

		def test_setting_an_O_position_on_the_board
			@test_board.set_position(1, "O")
			assert_includes @test_board.board, "O"
		end

		def test_setting_another_position_on_the_board
			@test_board.set_position(2,"X")
			@test_board.set_position(4,"X")
			assert_equal [1, "X", 3, "X", 5, 6, 7, 8, 9], @test_board.board
		end

		def test_setting_a_position_ontop_of_another_position
			@test_board.set_position(2,"X")
			assert_equal nil, @test_board.set_position(2,"X")
		end

		def test_that_board_responds_to_display
			assert_respond_to @test_board, :display, "#{@test_board} does not respond to display"
		end
	end
end


__END__
