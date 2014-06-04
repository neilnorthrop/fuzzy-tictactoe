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
		players_moves = []
		@board.board.each.with_index do |v,k|
			if v == "X"
				players_moves << k
			end
		end
		@board.log.info "#{players_moves}"
		# Check for computer win
		# @game.WINNING_POSITIONS.each do |row|
		# 	left_over_position = row - @game.board.computer_collection
		# 	if left_over_position.count == 1
		# 		return left_over_position
		# 	end
		# end
		# Check for block
		WINNING_POSITIONS.each do |row|
			if (row - players_moves).count == 1
				@board.board[(row - players_moves).pop] = "O"
			end
		end
		# Check for best move
	end

	def check_game
		# WINNING_POSITIONS.each do |row|
		# 	if row == @board.computer_collection
		# 		puts "COMPUTER IS THE WINNER!"
		# 	end
		# end
		WINNING_POSITIONS.each do |row|
			if row == @board.play_collection.sort
				puts "PLAYER IS THE WINNER!"
				enter_game
			end
		end
	end
end

if __FILE__==$0
	require 'minitest/autorun'
	require 'minitest/unit'

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

		def test_computer_turn_blocks_players_two_in_a_row_diagonal
			skip
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(2, "X")
			@test_game.computer_turn
			assert_equal ["X", "X", "O", 4, 5, 6, 7, 8, 9], @test_game.board.board
		end
	end
end



























































































































































































