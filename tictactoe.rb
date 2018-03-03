require 'rubygems'
require 'bundler/setup'
require './lib/game'
require './lib/board'
require './lib/player'
require './lib/ui'

class TicTacToe
  def initialize game_class=Game, board_class=Board,
    player_class=Player, ui_class=UI

    @ui = ui_class.new game_class, board_class, player_class
    @ui.start_game
  end
end

TicTacToe.new
