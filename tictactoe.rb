require 'rubygems'
require 'bundler/setup'
require './lib/game'
require './lib/board'
require './lib/player'
require './lib/ui'

class TicTacToe
  attr_accessor :ui
  def initialize game_class=Game, board_class=Board,
    player_class=Player, ui_class=UI

    @ui = ui_class.new game_class, board_class, player_class
  end

  def start_game
    @ui.setup_game
    handle_game_mode
  end

  def handle_game_mode
    @ui.pvp if @ui.mode == 'PVP'
    @ui.pvc if @ui.mode == 'PVC'
    @ui.cvc if @ui.mode == 'CVC'
  end
end

game = TicTacToe.new
game.start_game
