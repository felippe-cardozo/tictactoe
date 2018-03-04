class Player
# Computer Player for tictactoe with 4 difficulty levels
# Takes an game instance and level as arguments

  attr_accessor :game, :level
  attr_reader :best_move
  def initialize game_instance, level='HARD'
    @game = game_instance
    @level = level
  end

  def get_move mark=@game.current_player
    return @game.legal_moves.sample if @level == 'EASY'
    return get_hard_move if @level == 'HARD'
    return [get_hard_move, @game.legal_moves.sample].sample if @level == 'MEDIUM'
    return min_max_move if @level == 'VERY_HARD'
  end
  
  private

    def min_max_move game=@game, player=@game.current_player
      min_max game
      @best_move
    end

    def get_hard_move(board=@game.board, player=@game.current_player)
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
        possible_game = @game.dup
        possible_game.move(spot, player)
        return spot if possible_game.winning? possible_game.board, player
      end
      return best
    end

    def score game
      return 10 if game.winner? 'X'
      return -10 if game.winner? 'O'
      return 0
    end

    def min_max game, depth=6
      return score(game) if game.over?
      return score(game) if depth < 1
      scores = {}
      depth -= 1
      game.legal_moves.each do |move|
        possible_game = game.dup
        possible_game.move(move)
        scores[move] = min_max(possible_game, depth=depth)
      end

      @best_move, best_score = find_best_move(game.current_player, scores)
      return best_score
    end

    def find_best_move(current_player, scores)
      if current_player == 'X'
        scores.max_by {|k, v| v}
      else
        scores.min_by {|k, v| v}
      end
    end
end
