require 'minitest/autorun'
require_relative '../lib/game'
require_relative '../lib/board'

class TestGame < Minitest::Test
  def setup
    @game = Game.new
    @game.board_class = Board
    @game.new_game
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

  def test_move_automatically_sets_correct_mark
    @game.move(1)
    assert_equal @game.board.state[1], 'O'
    @game.move(2)
    assert_equal @game.board.state[2], 'X'
  end

  def test_game_updates_game_history
    assert_equal @game.history.length, 1
    @game.move(1, 'O')
    assert_equal @game.history.length, 2
    @game.move(2, 'X')
    assert_equal @game.history.length, 3
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
    assert_equal @game.over?, true
  end

  def test_undo_works
    @game.move(5)
    @game.move(4)
    @game.undo
    assert_includes @game.legal_moves, 4
  end

  def test_redo_works
    @game.move(5)
    @game.move(4)
    @game.undo
    @game.redo
    !assert_includes @game.legal_moves, 4
  end
end
