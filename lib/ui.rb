class UI
# Command Line Interface to the tictactoe game

  attr_accessor :game, :player, :mode, :level

  def initialize game_class, board_class, player_class
    @game = game_class.new
    @board_class = board_class
    @player_class = player_class
  end

  def start_game
    setup_game
    handle_game_mode
  end

  private
    def setup_game
      @game.board_class = @board_class
      @game.new_game
      @mode = ask_for_mode
      @level = @mode != 'PVP' ? ask_for_level : nil
      setup_player unless @level.nil?
    end

    def setup_player
      @player = @player_class.new @game, @level 
    end

    def handle_game_mode
      pvp if @mode == 'PVP'
      pvc if @mode == 'PVC'
      cvc if @mode == 'CVC'
    end

    def pvc
      until @game.over?
        print_state
        if @game.current_player == 'O'
          print_commands
          make_human_move
        else
          sleep(1)
          puts "Computer Move\n"
          make_comp_move
        end
      end
      print_state
      (puts "You Won!"; return) if @game.winner? 'O'
      (puts "You Lost...";return) if @game.winner? 'X'
      puts "Game ended in a Draw."
    end

    def pvp
      until @game.over?
        print_state
        print_commands
        make_human_move
      end
      print_state
      (puts "'O' Won!"; return) if @game.winner? 'O'
      (puts "'X' Won!"; return) if @game.winner? 'X'
      puts "Game ended in a Draw."
    end

    def cvc
      until @game.over?
        print_state
        sleep(1)
        make_comp_move
      end
      (puts "'O' Won!"; return) if @game.winner? 'O'
      (puts "'X' Won!"; return) if @game.winner? 'X'
      puts "Game ended in a Draw."
    end

    def print_commands
      puts "Avaiable Moves: #{@game.legal_moves.to_s}\n"
    end

    def make_comp_move
      move = @player.get_move
      @game.move(move)
    end

    def make_human_move
      move = nil
      until move
        move = ask_for_move
        begin
          @game.move(move)
        rescue TypeError
          puts "Invalid Move " + move.to_s
          move = nil
        end
      end
    end

    def print_state
      puts @game.board
    end

    def get_user_input
      gets.chomp
    end

    def ask_for_mode
      puts "select a mode by number:\n1 = 'Player Vs Computer'\n"\
        "2 = 'Player Vs Player'\n3 = 'Computer Vs Computer'"
      modes = {1 => 'PVC', 2 => 'PVP', 3 => 'CVC'}
      mode = get_user_input
      ask_for_mode unless ('1'..'3').include? mode
      return modes[mode.to_i]
    end

    def ask_for_level
      puts "select a difficult level\n'v' for Very Hard\n"\
        "'h' for Hard\n'm' for Medium\n'e' for Easy"
      levels = {'v' => 'VERY_HARD', 'h' => 'HARD',
                'm' => 'MEDIUM', 'e' => 'EASY'}
      level = get_user_input
      ask_for_level unless 'vhmeVHME'.include? level
      return levels[level.downcase]
    end

    def ask_for_move
      puts "Choose your move:\n"
      move = get_user_input
      ask_for_move unless ("0".."9").include? move
      move.to_i
    end
end
