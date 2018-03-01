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

  def move spot, move_symbol
    new_board = gen_new_board(@board.state, spot, move_symbol)
    update_history @board
    @board = new_board
  end

  def gen_new_board board_state, spot, move_symbol
    board_state[spot] = move_symbol
    board_class.new board_state
  end

  def update_history board
    @board_history << board
  end

  def undo
    @board_history.pop
    @board = @board_history.last
  end

  def game_is_over?
    b = @board.state

    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie?
    return false if game_is_over?
    @board.avaiable_slots.empty?
  end

end
