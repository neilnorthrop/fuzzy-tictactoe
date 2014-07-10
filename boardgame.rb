#! /usr/bin/env ruby

class BoardGame
  attr_accessor :board

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
  end

  def set_position(position, letter)
    if check_position(position, letter) == false
      return nil
    end
    index = @board.find_index(position)
    @board[index] = letter
  end

  def set_at_index(index, letter)
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

  def check_for_winner(player_moves, computer_moves)
    WINNING_POSITIONS.each do |row|
      3.times do
        first_three = player_moves.take(3)
        if row == first_three.sort
          return "PLAYER WINS!"
        else
          player_moves = player_moves.rotate
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

  def display_board
    return @board
  end

  def computer_opening_move
    if !moves("X").include?(4)
      set_position(5, "O")
      @turn_taken = true
    else 
      set_position(1, "O")
      @turn_taken = true
    end
  end

  def position_empty(index, letter1, letter2)
    move_does_not_contain(index, letter1) && move_does_not_contain(index, letter2)
  end

  def computer_win_or_block
    WINNING_POSITIONS.each do |row|
      if (row - moves("O")).count == 1 && @turn_taken == false
        move_remaining = (row - moves("O")).shift
        if position_empty(move_remaining, "O", "X")
          set_at_index(move_remaining, "O")
          @turn_taken = true
        end
      elsif (row - moves("X")).count == 1 && @turn_taken == false
        move_remaining = (row - moves("X")).shift
        if position_empty(move_remaining, "O", "X")
          set_at_index(move_remaining, "O")
          @turn_taken = true
        end
      end
    end
  end

  def computer_blocking_fork
    if @turn_taken == false
      if moves("X") == [0, 2, 5, 7]
        set_position(tally_moves_remaining.sample, "O")
      elsif moves("X") == [0, 5, 6]
        set_position(4, "O")
      elsif moves("X") == [1, 3]
        set_position(1, "O")
      elsif moves("X") == [5, 7] || 
            moves("X") == [1, 5] || 
            moves("X") == [4, 8] || 
            moves("X") == [0, 5]
        set_position(3, "O")
      elsif moves("X") == [3, 7]
        set_position(7, "O")
      elsif moves("X") == [0, 8] ||
            moves("X") == [2, 6]
        set_position(2, "O")
      elsif moves("X") == [0, 7]
        set_position(4, "O")
      else
        set_position(tally_moves_remaining.sample, "O")
      end
    end
  end

  def computer_turn
    @turn_taken = false

    case 
    when moves("X").count == 1
      computer_opening_move
    when moves("X").count > 1
      computer_win_or_block
      computer_blocking_fork
    end
  end

  def check_game
    check_for_winner(moves("X"), moves("O"))
  end
end

if __FILE__==$0
  require 'minitest/autorun'
  require 'minitest/unit'
  print `clear`

  class TestBoard < MiniTest::Unit::TestCase

    def setup
      @test_game = BoardGame.new
    end

    def test_building_board_class
      assert BoardGame.new
    end

    def test_game_class_responds_to_board
      assert @test_game.display_board
    end

    def test_game_includes_default_size_board
      assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_player_across
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.computer_turn
      assert_equal ["X", "X", "O", 4, 5, 6, 7, 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_player_down
      @test_game.set_position(1, "X")
      @test_game.set_position(4, "X")
      @test_game.computer_turn
      assert_equal ["X", 2, 3, "X", 5, 6, "O", 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_player_down_the_middle
      @test_game.set_position(1, "O")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "O")
      @test_game.set_position(5, "X")
      @test_game.set_position(7, "X")
      @test_game.computer_turn
      assert_equal ["O", "X", "O", 4, "X", 6, "X", "O", 9], @test_game.display_board
    end

    def test_computer_turn_blocks_player_diagonal
      @test_game.set_position(5, "X")
      @test_game.set_position(1, "X")
      @test_game.computer_turn
      assert_equal ["X", 2, 3, 4, "X", 6, 7, 8, "O"], @test_game.display_board
    end

    def test_on_opening_computer_turn_takes_middle_if_open
      @test_game.set_position(1, "X")
      @test_game.computer_turn
      assert_equal ["X", 2, 3, 4, "O", 6, 7, 8, 9], @test_game.display_board
    end

    def test_on_opening_computer_turn_takes_middle_outter_if_open
      @test_game.set_position(5, "X")
      @test_game.computer_turn
      assert_equal ["O", 2, 3, 4, "X", 6, 7, 8, 9], @test_game.display_board
    end

    def test_computer_turn_takes_the_win_down
      @test_game.set_position(1, "O")
      @test_game.set_position(4, "O")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "X")
      @test_game.set_position(6, "X")
      @test_game.computer_turn
      assert_equal ["O", "X", "X", "O", 5, "X", "O", 8, 9], @test_game.display_board
    end

    def test_computer_turn_takes_the_win_across
      @test_game.set_position(1, "O")
      @test_game.set_position(2, "O")
      @test_game.set_position(4, "X")
      @test_game.set_position(7, "X")
      @test_game.set_position(6, "X")
      @test_game.computer_turn
      assert_equal ["O", "O", "O", "X", 5, "X", "X", 8, 9], @test_game.display_board
    end

    def test_computer_turn_takes_the_win_diagonal
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "O")
      @test_game.set_position(5, "O")
      @test_game.set_position(6, "X")
      @test_game.computer_turn
      assert_equal ["X", "X", "O", 4, "O", "X", "O", 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_players_fork
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(4, "X")
      @test_game.set_position(5, "O")
      @test_game.set_position(6, "O")
      @test_game.computer_turn
      assert_equal ["X", "X", "O", "X", "O", "O", 7, 8, 9], @test_game.display_board
    end

    def test_player_wins_three_in_a_row_across
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(3, "X")
      assert_equal "PLAYER WINS!", @test_game.check_game
    end

    def test_player_wins_three_in_a_row_down
      @test_game.set_position(1, "X")
      @test_game.set_position(4, "X")
      @test_game.set_position(7, "X")
      assert_equal "PLAYER WINS!", @test_game.check_game
    end

    def test_player_wins_three_in_a_row_diagonal
      @test_game.set_position(1, "X")
      @test_game.set_position(5, "X")
      @test_game.set_position(9, "X")
      assert_equal "PLAYER WINS!", @test_game.check_game
    end

    def test_computer_wins_three_in_a_row_across
      @test_game.set_position(1, "O")
      @test_game.set_position(2, "O")
      @test_game.set_position(3, "O")
      assert_equal "COMPUTER WINS!", @test_game.check_game
    end

    def test_computer_wins_three_in_a_row_down
      @test_game.set_position(1, "O")
      @test_game.set_position(4, "O")
      @test_game.set_position(7, "O")
      assert_equal "COMPUTER WINS!", @test_game.check_game
    end

    def test_computer_wins_three_in_a_row_diagonal
      @test_game.set_position(1, "O")
      @test_game.set_position(5, "O")
      @test_game.set_position(9, "O")
      assert_equal "COMPUTER WINS!", @test_game.check_game
    end

    def test_game_is_a_draw
      @test_game.set_position(1, "X")
      @test_game.set_position(3, "X")
      @test_game.set_position(4, "X")
      @test_game.set_position(8, "X")
      @test_game.set_position(9, "X")
      @test_game.set_position(2, "O")
      @test_game.set_position(5, "O")
      @test_game.set_position(6, "O")
      @test_game.set_position(7, "O")
      assert_equal "IT IS A DRAW!", @test_game.check_game
    end

    def test_player_wins_with_full_game_board
      @test_game.set_position(1, "X")
      @test_game.set_position(6, "X")
      @test_game.set_position(7, "X")
      @test_game.set_position(8, "X")
      @test_game.set_position(9, "X")
      @test_game.set_position(2, "O")
      @test_game.set_position(3, "O")
      @test_game.set_position(4, "O")
      @test_game.set_position(5, "O")
      assert_equal "PLAYER WINS!", @test_game.check_game
    end

    def test_computer_wins_with_full_game_board
      @test_game.set_position(1, "X")
      @test_game.set_position(2, "X")
      @test_game.set_position(5, "X")
      @test_game.set_position(7, "X")
      @test_game.set_position(3, "O")
      @test_game.set_position(6, "O")
      @test_game.set_position(9, "O")
      assert_equal "COMPUTER WINS!", @test_game.check_game
    end

    def test_computer_turn_blocks_players_positioning_for_a_top_left_fork
      @test_game.set_position(2, "X")
      @test_game.set_position(4, "X")
      @test_game.set_position(5, "O")
      @test_game.computer_turn
      assert_equal ["O", "X", 3, "X", "O", 6, 7, 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_players_positioning_for_a_top_right_fork
      @test_game.set_position(2, "X")
      @test_game.set_position(6, "X")
      @test_game.set_position(5, "O")
      @test_game.computer_turn
      assert_equal [1, "X", "O", 4, "O", "X", 7, 8, 9], @test_game.display_board
    end

    def test_computer_turn_blocks_players_positioning_for_a_bottom_left_fork
      @test_game.set_position(4, "X")
      @test_game.set_position(8, "X")
      @test_game.set_position(5, "O")
      @test_game.computer_turn
      assert_equal [1, 2, 3, "X", "O", 6, "O", "X", 9], @test_game.display_board
    end

    def test_computer_turn_blocks_players_positioning_for_a_bottom_right_fork
      @test_game.set_position(6, "X")
      @test_game.set_position(8, "X")
      @test_game.set_position(5, "O")
      @test_game.computer_turn
      assert_equal [1, 2, "O", 4, "O", "X", 7, "X", 9], @test_game.display_board
    end

    def test_edge_case_for_computer_block
      @test_game.set_position(1, "X")
      @test_game.set_position(6, "X")
      @test_game.set_position(7, "X")
      @test_game.set_position(3, "O")
      @test_game.set_position(5, "O")
      @test_game.computer_turn
      assert_equal ["X", 2, "O", "O", "O", "X", "X", 8, 9], @test_game.display_board
    end

    def test_building_default_board_size
      assert_kind_of Array, @test_game.board
    end

    def test_setting_an_X_position_on_the_board
      @test_game.set_position(1, "X")
      assert_includes @test_game.board, "X"
    end

    def test_setting_an_O_position_on_the_board
      @test_game.set_position(1, "O")
      assert_includes @test_game.board, "O"
    end

    def test_setting_another_position_on_the_board
      @test_game.set_position(2,"X")
      @test_game.set_position(4,"X")
      assert_equal [1, "X", 3, "X", 5, 6, 7, 8, 9], @test_game.board
    end

    def test_setting_a_position_ontop_of_another_position
      @test_game.set_position(2,"X")
      assert_equal nil, @test_game.set_position(2,"X")
    end

    def test_that_board_responds_to_display
      assert_respond_to @test_game, :display, "#{@test_game} does not respond to display"
    end

    def test_that_board_checks_for_player_position_at_1
      @test_game.set_position(1, "X")
      assert_equal false, @test_game.check_position(1, "X")
    end

    def test_that_board_checks_for_player_position_at_2
      @test_game.set_position(1, "X")
      assert_equal true, @test_game.check_position(2, "X")
    end

    def test_setting_an_X_index_position
      @test_game.set_at_index(1, "X")
      assert_equal [1, "X", 3, 4, 5, 6, 7, 8, 9], @test_game.display_board
    end

    def test_setting_X_index_position_on_top_of_another_X
      @test_game.set_at_index(1, "X")
      assert_equal false, @test_game.set_at_index(1, "X")
    end

    def test_that_position_does_not_contain_an_X
      @test_game.set_position(1, "X")
      assert_equal true, @test_game.move_does_not_contain(9, "X")
    end

    def test_that_position_does_contain_an_X
      @test_game.set_position(1, "X")
      assert_equal false, @test_game.move_does_not_contain(0, "X")
    end
  end
end


__END__
