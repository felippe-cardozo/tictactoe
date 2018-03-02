class UI
  attr_accessor :game, :board_class, :player, :mode, :level

  def initialize game, board_class, player_class
    @game = game
    @board_class = board_class
    @player_class = player_class
  end

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

  def print_state
    @game.board.print
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
    puts "select a difficult level\n'h' for Hard\n'm' for Medium\n'e' for Easy"
    levels = {'h' => 'HARD', 'm' => 'MEDIUM', 'e' => 'EASY'}
    level = get_user_input
    ask_for_level unless 'hmeHME'.include? level
    return levels[level.downcase]
  end

  def ask_for_move
    puts "Choose your move"
    move = get_user_input
    ask_for_move unless ("0".."9").include? move
    move.to_i
  end
end
