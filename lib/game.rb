#cd Desktop/w2d2/chess;ruby chess.rb

require 'colorize'
require_relative 'board.rb'
require_relative 'pieces.rb'
require_relative 'human.rb'

class Game
  def initialize  
    @board = Board.new
    @p1 = HumanPlayer.new(:white, @board)
    @p2 = HumanPlayer.new(:black, @board)
    @current = @p1
  end
  
  def run
    until @board.game_over?
      begin
        player_move = @current.play_turn(@board)
        break if player_move == 'quit'
        move_executed = @board.move(player_move[0], player_move[1])
        @current = ((@current == @p1) ? @p2 : @p1 ) unless @board.game_over?
       raise "Your move was invalid" unless move_executed
      rescue Exception => e
        puts e.message
        retry
      end
    end  
    #invalid moves gotta be fixed
      
    @current.render
    if @board.stalemate?
      puts "Game ends in stalemate, eh"
    else
      puts "#{@current.color} player won!"
    end
  end
end

g = Game.new
g.run

