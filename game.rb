#! /usr/bin/env ruby

require './board.rb'
require 'pp'

class Tictactoe < Board
	attr_accessor :WINNING_POSITIONS

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
		@WINNING_POSITIONS = WINNING_POSITIONS
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
			@clear_game_board = Tictactoe.new(Board.new)
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
	end
end



























































































































































































