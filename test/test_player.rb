require 'minitest/autorun'
require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/board'

class TestBoard < Minitest::Test
  def setup
    @game = Game.new Board
    @player = Player.new @game, 'X'
  end

  def test_player_plays_in_the_center_if_board_is_empty_and_mode_is_hard
    move = @player.get_move
    assert_equal 4, move
  end

  def test_player_is_able_to_point_to_a_valid_move
    move = @player.get_move
    assert_includes @game.board.avaiable_spots, move
  end

  def test_player_finds_mate_in_one
    b = Board.new [0, 'X', 'X', 'O', 'O', 5, 'O', 'X', 'O']
    @game.board = b
    move = @player.get_move
    assert_equal 0, move
  end

end
