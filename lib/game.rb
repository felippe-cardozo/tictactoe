class Game
  attr_accessor :board_class, :board, :history, :redo_history
  attr_reader :current_player

  def initialize
    @history = []
    @redo_history = []
  end

  def new_game
    @board = @board_class.new
    @history << @board
  end

  def current_player
    legal_moves.length.even? ? 'X' : 'O'
  end

  def move spot, move_symbol=self.current_player
    new_board = gen_new_board(@board.state, spot, move_symbol)
    update_history @board
    @board = new_board
  end

  def gen_new_board board_state, spot, move_symbol
    new_board_state = board_state.dup
    new_board_state[spot] = move_symbol
    @board_class.new new_board_state
  end

  def legal_moves
    @board.avaiable_spots
  end

  def update_history board
    @history << board
  end

  def undo
    @redo_history << @history.pop
    @board = @history.last
  end

  def redo
    @history << @redo_history.pop
    @board = @history.last
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
    legal_moves.empty?
  end

  def winner? mark
    winning? @board.state, mark
  end

end
