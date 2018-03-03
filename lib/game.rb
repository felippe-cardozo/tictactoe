class Game
  attr_accessor :board_class, :board
  attr_reader :current_player, :history

  def initialize
    @history = []
  end

  def new_game
    @board = @board_class.new
    @history << @board
  end

  def current_player
    legal_moves.length.even? ? 'X' : 'O'
  end

  def move spot, move_symbol=self.current_player
    new_board = gen_new_board(@board, spot, move_symbol)
    update_history @board
    @board = new_board
  end

  def gen_new_board board, spot, move_symbol
    new_board = board.to_a
    new_board[spot] = move_symbol
    @board_class.new new_board
  end

  def legal_moves
    @board.avaiable_spots
  end

  def update_history board
    @history << board
  end

  def winning? board=@board, move_symbol=@current_player
    b = board.to_a

    [b[0], b[1], b[2]].uniq == [move_symbol] ||
    [b[3], b[4], b[5]].uniq == [move_symbol] ||
    [b[6], b[7], b[8]].uniq == [move_symbol] ||
    [b[0], b[3], b[6]].uniq == [move_symbol] ||
    [b[1], b[4], b[7]].uniq == [move_symbol] ||
    [b[2], b[5], b[8]].uniq == [move_symbol] ||
    [b[0], b[4], b[8]].uniq == [move_symbol] ||
    [b[2], b[4], b[6]].uniq == [move_symbol]
  end

  def win?
    winning?(@board.to_a, 'O') || winning?(@board.to_a, 'X')
  end
  
  def over?
    win? || tie?
  end

  def tie?
    return false if win?
    legal_moves.empty?
  end

  def winner? mark
    winning? @board.to_a, mark
  end

end
