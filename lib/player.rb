class Player
  attr_accessor :game, :level
  def initialize game_instance, level='HARD'
    @game = game_instance
    @level = level
  end

  def get_move mark=@game.current_player
    moves = {:hard => get_best_move(@game.board, mark),
             :easy => @game.board.avaiable_spots.sample}
    return moves[:hard] if @level == 'HARD'
    return moves[:easy] if @level == 'EASY'
    return moves.values.sample
  end

  def get_best_move(board, player)
    opponent = player == 'X' ? 'O' : 'X'
    best_move =  win_next(board, player)
    return best_move if best_move
    best_move = win_next(board, opponent)
    return best_move if best_move
    return 4 if board.avaiable_spots.include? 4
    return board.avaiable_spots.sample
  end

  def win_next(board, player)
    best = nil
    board.avaiable_spots.each do |spot|
      possible_board = @game.gen_new_board board, spot, player
      return spot if @game.winning? possible_board, player
    end
    return best
  end
end
