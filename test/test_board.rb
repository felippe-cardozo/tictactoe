require 'minitest/autorun'
require_relative '../lib/board'

class TestBoard < Minitest::Test
  def setup
    @empty_board = Board.new
    @full_board = Board.new ['O', 'X', 'O', 'X', 'O', 'X', 'O', 'X', 'O']
  end

  def test_empty_board_has_9_avaiable_spots
    assert_equal 9, @empty_board.avaiable_spots.length
  end

  def test_full_board_has_no_avaiable_spots
    assert_equal @full_board.avaiable_spots.empty?, true
  end

  def test_board_validates_contents
    invalid_contents = ['a', 9, 'x', 'o', 11]
    board = [0, 1, 2, 3, 4, 5, 6, 7]
    invalid_contents.each do |i|
      assert_raises(TypeError) {Board.new(board + [i])} 
    end
  end

  def test_board_validates_length
    boards = [(0..7).to_a, [], (0..9).to_a]
    boards.each do |i|
      assert_raises(TypeError) {Board.new(i)}
    end
  end
  
  def test_board_initialize_with_valid_contents
    board = (0..6).to_a + ['X', 'O']
    assert_equal Board.new(board).nil?, false
    assert_equal @full_board.nil?, false
  end
end
