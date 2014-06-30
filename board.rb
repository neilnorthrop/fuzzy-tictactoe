#! /usr/bin/env ruby
require 'logger'

class Board
	attr_accessor :board, :log, :play_collection, :computer_collection, :WINNING_POSITIONS

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

	def initialize
		@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
		@play_collection = []
		@computer_collection = []
		@log = Logger.new "tictactoe.txt"
	end

	def clear_board
		@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	end

	def print_board
		return @board
	end

	def set_position(position, letter)
		if check_position(position, letter) == false
			return nil
		end
		index = @board.find_index(position)
		@board[index] = letter
	end

	def set_index_position(index, letter)
		if @board[index] =~ /X|O/
			return false
		end
		@board[index] = letter
	end

	def check_position(position, letter)
		if @board.find_index(position) == nil
			false
		else
			true
		end
	end

	def move_does_not_contain(index, letter)
		@board[index] != letter
	end

	def moves(letter)
		computer_moves = []
		@board.each.with_index do |v,k|
			if v == letter
				computer_moves << k
			end
		end
		return computer_moves.sort
	end

	def tally_moves_remaining
		moves_remaining = []
		@board.each do |position|
			if position != "X" && position != "O"
				moves_remaining << position
			end
		end
		return moves_remaining
	end

	def check_for_winner(players_moves, computer_moves)
		WINNING_POSITIONS.each do |row|
			3.times do
				first_three = players_moves.take(3)
				if row == first_three.sort
					return "PLAYER WINS!"
				else
					players_moves = players_moves.rotate
				end
			end
			3.times do
				first_three = computer_moves.take(3)
				if row == first_three.sort
					return "COMPUTER WINS!"
				else
					computer_moves = computer_moves.rotate
				end
			end
		end
		if tally_moves_remaining.empty?
			return "IT IS A DRAW!"
		end
	end
end

if __FILE__==$0
	require 'minitest/autorun'
	require 'minitest/unit'
	print `clear`

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

		def test_that_board_checks_for_player_position_at_1
			@test_board.set_position(1, "X")
			assert_equal false, @test_board.check_position(1, "X")
		end

		def test_that_board_checks_for_player_position_at_2
			@test_board.set_position(1, "X")
			assert_equal true, @test_board.check_position(2, "X")
		end

		def test_setting_an_X_index_position
			@test_board.set_index_position(1, "X")
			assert_equal [1, "X", 3, 4, 5, 6, 7, 8, 9], @test_board.print_board
		end

		def test_setting_X_index_position_on_top_of_another_X
			@test_board.set_index_position(1, "X")
			assert_equal false, @test_board.set_index_position(1, "X")
		end

		def test_that_position_does_not_contain_an_X
			@test_board.set_position(1, "X")
			assert_equal true, @test_board.move_does_not_contain(9, "X")
		end

		def test_that_position_does_contain_an_X
			@test_board.set_position(1, "X")
			assert_equal false, @test_board.move_does_not_contain(0, "X")
		end
	end
end


__END__
