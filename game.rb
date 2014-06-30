#! /usr/bin/env ruby
require './board.rb'

class Game < Board

	def initialize
		@board = Board.new
		@WINNING_POSITIONS = @board.WINNING_POSITIONS
	end

	def display_board
		@board.print_board
	end

	def computer_opening_move
		if !players_moves.include?(4)
			@board.set_position(5, "O")
			@turn_taken = true
		else 
			@board.set_position(1, "O")
			@turn_taken = true
		end
	end

	def set_index(index, letter)
		@board.set_index_position(index, letter)
	end

	def players_moves
		return @board.moves("X")
	end

	def computers_moves
		return @board.moves("O")
	end

	def position_empty(index, letter1, letter2)
		@board.move_does_not_contain(index, letter1) && @board.move_does_not_contain(index, letter2)
	end

	def computer_win_or_block
		WINNING_POSITIONS.each do |row|
			if (row - computers_moves).count == 1 && @turn_taken == false
				move_remaining = (row - computers_moves).shift
				if position_empty(move_remaining, "O", "X")
					set_index(move_remaining, "O")
					@turn_taken = true
				end
			elsif (row - players_moves).count == 1 && @turn_taken == false
				move_remaining = (row - players_moves).shift
				if position_empty(move_remaining, "O", "X")
					set_index(move_remaining, "O")
					@turn_taken = true
				end
			end
		end
	end

	def computer_blocking_fork
		if @turn_taken == false
			if players_moves == [0, 2, 5, 7]
				@board.set_position(@board.tally_moves_remaining.sample, "O")
			elsif players_moves == [0, 5, 6]
				@board.set_position(4, "O")
			elsif players_moves == [1, 3]
				@board.set_position(1, "O")
			elsif players_moves == [5, 7] || players_moves == [1, 5] || players_moves == [4, 8] || players_moves == [0, 5]
				@board.set_position(3, "O")
			elsif players_moves == [3, 7]
				@board.set_position(7, "O")
			elsif players_moves == [0, 8]
				@board.set_position(2, "O")
			elsif players_moves == [0, 7]
				@board.set_position(4, "O")
			else
				@board.set_position(@board.tally_moves_remaining.sample, "O")
			end
		end
	end

	def computer_turn
		@turn_taken = false

		case 
		when players_moves.count == 1
			computer_opening_move
		when players_moves.count > 1
			computer_win_or_block
			computer_blocking_fork
		end
	end

	def check_game
		@board.check_for_winner(players_moves, computers_moves)
	end
end

if __FILE__==$0
	require 'minitest/autorun'
	require 'minitest/unit'
	puts `clear`

	class TestTictactoe < Minitest::Unit::TestCase

		def setup
			@test_game = Game.new
		end

		def test_building_game_class
			assert @test_game
		end

		def test_game_class_responds_to_board
			assert @test_game.board
		end

		def test_game_includes_default_size_board
			assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9], @test_game.display_board
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
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(4, "X")
			@test_game.board.set_position(5, "O")
			@test_game.board.set_position(6, "O")
			@test_game.computer_turn
			assert_equal ["X", "X", "O", "X", "O", "O", 7, 8, 9], @test_game.board.board
		end

		def test_player_wins_three_in_a_row_across
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(3, "X")
			assert_equal "PLAYER WINS!", @test_game.check_game
		end

		def test_player_wins_three_in_a_row_down
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(4, "X")
			@test_game.board.set_position(7, "X")
			assert_equal "PLAYER WINS!", @test_game.check_game
		end

		def test_player_wins_three_in_a_row_diagonal
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(5, "X")
			@test_game.board.set_position(9, "X")
			assert_equal "PLAYER WINS!", @test_game.check_game
		end

		def test_computer_wins_three_in_a_row_across
			@test_game.board.set_position(1, "O")
			@test_game.board.set_position(2, "O")
			@test_game.board.set_position(3, "O")
			assert_equal "COMPUTER WINS!", @test_game.check_game
		end

		def test_computer_wins_three_in_a_row_down
			@test_game.board.set_position(1, "O")
			@test_game.board.set_position(4, "O")
			@test_game.board.set_position(7, "O")
			assert_equal "COMPUTER WINS!", @test_game.check_game
		end

		def test_computer_wins_three_in_a_row_diagonal
			@test_game.board.set_position(1, "O")
			@test_game.board.set_position(5, "O")
			@test_game.board.set_position(9, "O")
			assert_equal "COMPUTER WINS!", @test_game.check_game
		end

		def test_game_is_a_draw
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(3, "X")
			@test_game.board.set_position(4, "X")
			@test_game.board.set_position(8, "X")
			@test_game.board.set_position(9, "X")
			@test_game.board.set_position(2, "O")
			@test_game.board.set_position(5, "O")
			@test_game.board.set_position(6, "O")
			@test_game.board.set_position(7, "O")
			assert_equal "IT IS A DRAW!", @test_game.check_game
		end

		def test_player_wins_with_full_game_board
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(6, "X")
			@test_game.board.set_position(7, "X")
			@test_game.board.set_position(8, "X")
			@test_game.board.set_position(9, "X")
			@test_game.board.set_position(2, "O")
			@test_game.board.set_position(3, "O")
			@test_game.board.set_position(4, "O")
			@test_game.board.set_position(5, "O")
			assert_equal "PLAYER WINS!", @test_game.check_game
		end

		def test_computer_wins_with_full_game_board
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(5, "X")
			@test_game.board.set_position(7, "X")
			@test_game.board.set_position(3, "O")
			@test_game.board.set_position(6, "O")
			@test_game.board.set_position(9, "O")
			assert_equal "COMPUTER WINS!", @test_game.check_game
		end

		def test_computer_turn_blocks_players_positioning_for_a_top_left_fork
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(4, "X")
			@test_game.board.set_position(5, "O")
			@test_game.computer_turn
			assert_equal ["O", "X", 3, "X", "O", 6, 7, 8, 9], @test_game.board.board
		end

		def test_computer_turn_blocks_players_positioning_for_a_top_right_fork
			@test_game.board.set_position(2, "X")
			@test_game.board.set_position(6, "X")
			@test_game.board.set_position(5, "O")
			@test_game.computer_turn
			assert_equal [1, "X", "O", 4, "O", "X", 7, 8, 9], @test_game.board.board
		end

		def test_computer_turn_blocks_players_positioning_for_a_bottom_left_fork
			@test_game.board.set_position(4, "X")
			@test_game.board.set_position(8, "X")
			@test_game.board.set_position(5, "O")
			@test_game.computer_turn
			assert_equal [1, 2, 3, "X", "O", 6, "O", "X", 9], @test_game.board.board
		end

		def test_computer_turn_blocks_players_positioning_for_a_bottom_right_fork
			@test_game.board.set_position(6, "X")
			@test_game.board.set_position(8, "X")
			@test_game.board.set_position(5, "O")
			@test_game.computer_turn
			assert_equal [1, 2, "O", 4, "O", "X", 7, "X", 9], @test_game.board.board
		end

		def test_edge_case_for_computer_block
			@test_game.board.set_position(1, "X")
			@test_game.board.set_position(6, "X")
			@test_game.board.set_position(7, "X")
			@test_game.board.set_position(3, "O")
			@test_game.board.set_position(5, "O")
			@test_game.computer_turn
			assert_equal ["X", 2, "O", "O", "O", "X", "X", 8, 9], @test_game.board.board
		end
	end
end

__END__
