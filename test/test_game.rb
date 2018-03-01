require 'minitest/autorun'
require_relative '../lib/game'
require_relative '../lib/board'

class TestGame < Minitest::Test
  def setup
    @game = Game.new Board
  end

  def test_game_board_initializes
    assert_equal @game.board.state, (0..8).to_a 
  end

  def test_move_is_made_on_call
    @game.move(4, 'O')
    assert_equal @game.board.state[4], 'O'
    @game.move(5, 'X')
    assert_equal @game.board.state[5], 'X'
  end

  def test_game_updates_game_history
    assert_equal @game.board_history.length, 1
    @game.move(1, 'O')
    assert_equal @game.board_history.length, 2
    @game.move(2, 'X')
    assert_equal @game.board_history.length, 3
  end

  def test_game_evaluates_a_tie_correctly
    assert_equal @game.tie?, false
    tied_board = Board.new ["X", "O", "X", "O", "O", "X", "O", "X", "O"]
    winning_board = Board.new ["X", "O", "X", "O", "X", 5, "X", "O", 8]
    @game.board = tied_board
    assert_equal @game.tie?, true
    @game.board = winning_board
    assert_equal @game.tie?, false
  end

  def test_game_is_over_evaluetes_correctly
    assert_equal @game.over?, false
    winning_board = Board.new ["X", "O", "X", "O", "X", 5, "X", "O", 8]
    tied_board = Board.new ["X", "O", "X", "O", "O", "X", "O", "X", "O"]
    @game.board = winning_board
    assert_equal @game.over?, true
    @game.board = tied_board
    assert_equal @game.over?, false
  end
end
