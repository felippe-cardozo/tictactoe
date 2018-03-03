require 'minitest/autorun'
require 'stringio'
require_relative '../lib/player'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/ui'

class TestUI < Minitest::Test
  def setup
    @ui = UI.new Game, Board, Player
    # Kernel.stub :sleep
  end

  def set_input input
    string_io = StringIO.new
    string_io.puts input.to_s
    string_io.rewind
    $stdin = string_io
  end

  def clear_stdin
    $stdin = STDIN
  end

  def test_ask_for_mode
    set_input 1
    mode = @ui.send :ask_for_mode
    clear_stdin
    assert_equal mode, 'PVC'
    set_input 2
    assert_equal @ui.send(:ask_for_mode), 'PVP'
    clear_stdin
    set_input 3
    assert_equal @ui.send(:ask_for_mode), 'CVC'
    clear_stdin
  end

  def test_ask_for_level
    set_input 'h'
    assert_equal @ui.send(:ask_for_level), 'HARD'
    clear_stdin
    set_input 'm'
    assert_equal @ui.send(:ask_for_level), 'MEDIUM'
    clear_stdin
    set_input 'e'
    assert_equal @ui.send(:ask_for_level), 'EASY'
    clear_stdin
  end

  def test_ask_for_move
    (0..9).each do |n|
      set_input n
      assert_equal @ui.send(:ask_for_move), n
      clear_stdin
    end
  end

end
