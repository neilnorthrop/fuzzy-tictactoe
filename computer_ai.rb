#! /usr/bin/env ruby

class ComputerAI
	attr_accessor :turn_taken, :WINNING_POSITIONS

	def self.computer_turn(game)
		@game = game
		@WINNING_POSITIONS = @game.WINNING_POSITIONS
		@turn_taken = false

		if @game.player_moves.count == 1
	    computer_opening_move
	  else
	    computer_win_or_block
	    computer_blocking_fork
	  end
	end

  def self.set_position(position, letter)
  	@game.set_position(position, letter)
  end

  def self.player_moves
  	@game.display_board
  end

  def self.computer_opening_move
    if !@game.player_moves.include?(4)
      set_position(5, "O")
      @turn_taken = true
    else 
      set_position(1, "O")
      @turn_taken = true
    end
  end

  def self.computer_win_or_block
    @WINNING_POSITIONS.each do |row|
      if (row - @game.computer_moves).count == 1 && @turn_taken == false
        move_remaining = (row - @game.computer_moves).shift
        if @game.position_empty(move_remaining, "O", "X")
          @game.set_at_index(move_remaining, "O")
          @turn_taken = true
        end
      elsif (row - @game.player_moves).count == 1 && @turn_taken == false
        move_remaining = (row - @game.player_moves).shift
        if @game.position_empty(move_remaining, "O", "X")
          @game.set_at_index(move_remaining, "O")
          @turn_taken = true
        end
      end
    end
  end

  def self.computer_blocking_fork
    if @turn_taken == false
      if @game.player_moves == [0, 2, 5, 7]
        set_position(@game.tally_moves_remaining.sample, "O")
      elsif @game.player_moves == [0, 5, 6]
        set_position(4, "O")
      elsif @game.player_moves == [1, 3]
        set_position(1, "O")
      elsif @game.player_moves == [5, 7] || 
            @game.player_moves == [1, 5] || 
            @game.player_moves == [4, 8] || 
            @game.player_moves == [0, 5]
        set_position(3, "O")
      elsif @game.player_moves == [3, 7]
        set_position(7, "O")
      elsif @game.player_moves == [0, 8] ||
            @game.player_moves == [2, 6]
        set_position(2, "O")
      elsif @game.player_moves == [0, 7]
        set_position(4, "O")
      else
        set_position(@game.tally_moves_remaining.sample, "O")
      end
    end
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  require './boardgame.rb'
  print `clear`

  class TestComputerAI < MiniTest::Unit::TestCase
  	def setup
  		@test_game = BoardGame.new
  	end

    def test_computer_turn_takes_the_win_down
      @test_game.set_position(1, "O")
      @test_game.set_position(4, "O")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "X")
      @test_game.set_position(6, "X")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["O", "X", "X", "O", 5, "X", "O", 8, 9], @test_game.display_board
    end

    def test_computer_turn_takes_the_win_across
      @test_game.set_position(1, "O")
      @test_game.set_position(2, "O")
      @test_game.set_position(4, "X")
      @test_game.set_position(7, "X")
      @test_game.set_position(6, "X")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["O", "O", "O", "X", 5, "X", "X", 8, 9], @test_game.display_board
    end

    def test_computer_turn_takes_the_win_diagonal
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "O")
      @test_game.set_position(5, "O")
      @test_game.set_position(6, "X")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["X", "X", "O", 4, "O", "X", "O", 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_players_fork
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(4, "X")
      @test_game.set_position(5, "O")
      @test_game.set_position(6, "O")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["X", "X", "O", "X", "O", "O", 7, 8, 9], @test_game.display_board
    end

    def test_player_wins_three_in_a_row_across
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "X")
      assert_equal "player", @test_game.check_game
    end

    def test_player_wins_three_in_a_row_down
      @test_game.set_position(1, "X")
      @test_game.set_position(4, "X")
      @test_game.set_position(7, "X")
      assert_equal "player", @test_game.check_game
    end

    def test_player_wins_three_in_a_row_diagonal
      @test_game.set_position(1, "X")
      @test_game.set_position(5, "X")
      @test_game.set_position(9, "X")
      assert_equal "player", @test_game.check_game
    end

    def test_computer_wins_three_in_a_row_across
      @test_game.set_position(1, "O")
      @test_game.set_position(2, "O")
      @test_game.set_position(3, "O")
      assert_equal "computer", @test_game.check_game
    end

    def test_computer_wins_three_in_a_row_down
      @test_game.set_position(1, "O")
      @test_game.set_position(4, "O")
      @test_game.set_position(7, "O")
      assert_equal "computer", @test_game.check_game
    end

    def test_computer_wins_three_in_a_row_diagonal
      @test_game.set_position(1, "O")
      @test_game.set_position(5, "O")
      @test_game.set_position(9, "O")
      assert_equal "computer", @test_game.check_game
    end

    def test_computer_turn_blocks_players_positioning_for_a_top_left_fork
      @test_game.set_position(2, "X")
      @test_game.set_position(4, "X")
      @test_game.set_position(5, "O")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["O", "X", 3, "X", "O", 6, 7, 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_players_positioning_for_a_top_right_fork
      @test_game.set_position(2, "X")
      @test_game.set_position(6, "X")
      @test_game.set_position(5, "O")
      ComputerAI.computer_turn(@test_game)
      assert_equal [1, "X", "O", 4, "O", "X", 7, 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_players_positioning_for_a_bottom_left_fork
      @test_game.set_position(4, "X")
      @test_game.set_position(8, "X")
      @test_game.set_position(5, "O")
      ComputerAI.computer_turn(@test_game)
      assert_equal [1, 2, 3, "X", "O", 6, "O", "X", 9], @test_game.display_board
    end

    def test_computer_turn_blocks_players_positioning_for_a_bottom_right_fork
      @test_game.set_position(6, "X")
      @test_game.set_position(8, "X")
      @test_game.set_position(5, "O")
      ComputerAI.computer_turn(@test_game)
      assert_equal [1, 2, "O", 4, "O", "X", 7, "X", 9], @test_game.display_board
    end

    def test_edge_case_for_computer_block
      @test_game.set_position(1, "X")
      @test_game.set_position(6, "X")
      @test_game.set_position(7, "X")
      @test_game.set_position(3, "O")
      @test_game.set_position(5, "O")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["X", 2, "O", "O", "O", "X", "X", 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_player_across
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["X", "X", "O", 4, 5, 6, 7, 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_player_down
      @test_game.set_position(1, "X")
      @test_game.set_position(4, "X")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["X", 2, 3, "X", 5, 6, "O", 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_player_down_the_middle
      @test_game.set_position(1, "O")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "O")
      @test_game.set_position(5, "X")
      @test_game.set_position(7, "X")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["O", "X", "O", 4, "X", 6, "X", "O", 9], @test_game.display_board
    end

    def test_computer_turn_blocks_player_diagonal
      @test_game.set_position(5, "X")
      @test_game.set_position(1, "X")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["X", 2, 3, 4, "X", 6, 7, 8, "O"], @test_game.display_board
    end

    def test_on_opening_computer_turn_takes_middle_if_open
      @test_game.set_position(1, "X")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["X", 2, 3, 4, "O", 6, 7, 8, 9], @test_game.display_board
    end

    def test_on_opening_computer_turn_takes_middle_outter_if_open
      @test_game.set_position(5, "X")
      ComputerAI.computer_turn(@test_game)
      assert_equal ["O", 2, 3, 4, "X", 6, 7, 8, 9], @test_game.display_board
    end
  end

end