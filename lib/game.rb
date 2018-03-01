class Game
  attr_accessor :board, :board_history
  attr_reader :board_class

  def initialize board_class
    @board_class = board_class
    @board = board_class.new
    @board_history = [@board]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
  end

  def current_player
    @board.avaiable_spaces.length.even? ? 'O' : 'X'
  end

  def move spot, move_symbol
    new_board = gen_new_board(@board.state, spot, move_symbol)
    update_history @board
    @board = new_board
  end

  def gen_new_board board_state, spot, move_symbol
    new_board_state = board_state.dup
    new_board_state[spot] = move_symbol
    board_class.new new_board_state
  end

  def update_history board
    @board_history << board
  end

  def undo
    @board_history.pop
    @board = @board_history.last
  end

  def winning? b, move_symbol
    [b[0], b[1], b[2]].uniq == [move_symbol] ||
    [b[3], b[4], b[5]].uniq == [move_symbol] ||
    [b[6], b[7], b[8]].uniq == [move_symbol] ||
    [b[0], b[3], b[6]].uniq == [move_symbol] ||
    [b[1], b[4], b[7]].uniq == [move_symbol] ||
    [b[2], b[5], b[8]].uniq == [move_symbol] ||
    [b[0], b[4], b[8]].uniq == [move_symbol] ||
    [b[2], b[4], b[6]].uniq == [move_symbol]
  end

  def over?
    winning?(@board.state, 'O') || winning?(@board.state, 'X')
  end

  def tie?
    return false if over?
    @board.avaiable_spots.empty?
  end

  def winner? mark
    winning? @board.state, mark
  end

end
