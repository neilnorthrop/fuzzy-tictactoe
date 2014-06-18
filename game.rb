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

	def tally_moves_left
		moves_left = []
		@board.board.each do |position|
			if position != "X" && position != "O"
				moves_left << position
			end
		end
		return moves_left
	end

	def computer_turn
		players_moves, computer_moves, computer_move_this_turn = [], [], false

		@board.board.each.with_index do |v,k|
			if v == "O"
				computer_moves << k
			elsif v == "X"
				players_moves << k
			end
		end

		case 
		when players_moves.count == 1 && computer_move_this_turn == false
			if !players_moves.include?(4)
				@board.set_position(5, "O")
				computer_move_this_turn = true
				return
			else 
				@board.set_position(1, "O")
				computer_move_this_turn = true
				return
			end
		when players_moves.count > 1 && computer_move_this_turn == false
			WINNING_POSITIONS.each do |row|
				if (row - computer_moves).count == 1 && computer_move_this_turn == false
					if @board.board[(row - computer_moves).pop] != "O" && @board.board[(row - computer_moves).pop] != "X"
						computer_move_this_turn = @board.board[(row - computer_moves).pop]
						@board.set_position(computer_move_this_turn, "O")
						computer_move_this_turn = true
						break
					end
				elsif (row - players_moves).count == 1 && computer_move_this_turn == false
					if @board.board[(row - players_moves).pop] != "O" && @board.board[(row - players_moves).pop] != "X"
						computer_move_this_turn = @board.board[(row - players_moves).pop]
						@board.set_position(computer_move_this_turn, "O")
						computer_move_this_turn = true
						break
					end
				end
			end
			if computer_move_this_turn == false
				if players_moves.include?(0) && players_moves.include?(2) && players_moves.include?(5) && players_moves.include?(7)
					@board.set_position(tally_moves_left.sample, "O")
				elsif players_moves.include?(0) && players_moves.include?(5)
					@board.set_position(3, "O")
				elsif players_moves.include?(0) && players_moves.include?(8)
					@board.set_position(2, "O")
				elsif players_moves.include?(0) && players_moves.include?(7)
					@board.set_position(4, "O")
				elsif players_moves.count != computer_moves.count				
					@board.set_position(tally_moves_left.sample, "O")
				end
			end
		end
	end

	def check_game
		players_moves, computer_moves = [], []
		@board.board.each.with_index do |v,k|
			if v == "O"
				computer_moves << k
			elsif v == "X"
				players_moves << k
			end
		end
		WINNING_POSITIONS.each do |row|
			if row == players_moves.sort
				puts "PLAYER IS THE WINNER!"
				enter_game
			elsif row == computer_moves.sort
				puts "COMPUTER IS THE WINNER!"
				enter_game
			end
		end
		if tally_moves_left.empty?
			puts "GAME IS A TIE!"
			enter_game
		end
	end
end

if __FILE__==$0
	require 'minitest/autorun'
	require 'minitest/unit'
	# puts `clear`

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

		def test_computer_turn_blocks_player_across
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(2, "X")
			@test_game.computer_turn
			assert_equal ["X", "X", "O", 4, 5, 6, 7, 8, 9], @test_game.board.board
		end

		def test_computer_turn_blocks_player_down
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(4, "X")
			@test_game.computer_turn
			assert_equal ["X", 2, 3, "X", 5, 6, "O", 8, 9], @test_game.board.board
		end

		def test_computer_turn_blocks_player_down_the_middle
			@test_game.board.set_position(1, "O")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(3, "O")
			@test_game.board.set_position(5, "X")
			@test_game.board.set_position(7, "X")
			@test_game.computer_turn
			assert_equal ["O", "X", "O", 4, "X", 6, "X", "O", 9], @test_game.board.board
		end

		def test_computer_turn_blocks_player_diagonal
			@test_game.board.set_position(5, "X")
			@test_game.board.set_position(1, "X")
			@test_game.computer_turn
			assert_equal ["X", 2, 3, 4, "X", 6, 7, 8, "O"], @test_game.board.board
		end

		def test_on_opening_computer_turn_takes_middle_if_open
			@test_game.board.set_position(1, "X")
			@test_game.computer_turn
			assert_equal ["X", 2, 3, 4, "O", 6, 7, 8, 9], @test_game.board.board
		end

		def test_on_opening_computer_turn_takes_middle_outter_if_open
			@test_game.board.set_position(5, "X")
			@test_game.computer_turn
			assert_equal ["O", 2, 3, 4, "X", 6, 7, 8, 9], @test_game.board.board
		end

		def test_computer_turn_takes_the_win_down
			@test_game.board.set_position(1, "O")
			@test_game.board.set_position(4, "O")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(3, "X")
			@test_game.board.set_position(6, "X")
			@test_game.computer_turn
			assert_equal ["O", "X", "X", "O", 5, "X", "O", 8, 9], @test_game.board.board
		end

		def test_computer_turn_takes_the_win_across
			@test_game.board.set_position(1, "O")
			@test_game.board.set_position(2, "O")
			@test_game.board.set_position(4, "X")
			@test_game.board.set_position(7, "X")
			@test_game.board.set_position(6, "X")
			@test_game.computer_turn
			assert_equal ["O", "O", "O", "X", 5, "X", "X", 8, 9], @test_game.board.board
		end

		def test_computer_turn_takes_the_win_diagonal
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(3, "O")
			@test_game.board.set_position(5, "O")
			@test_game.board.set_position(6, "X")
			@test_game.computer_turn
			assert_equal ["X", "X", "O", 4, "O", "X", "O", 8, 9], @test_game.board.board
		end

		def test_computer_turn_blocks_players_fork
		end

		def test_computer_turn_blocks_players_positioning_for_a_fork
		end

		def test_computer_turn_plays_next_to_a_previous_computer_play
		end

		def test_computer_turn_creates_fork
		end

		def test_computer_turn_
		end
	end
end

__END__



























































































































































































