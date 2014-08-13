require_relative 'board.rb'
require_relative 'pieces.rb'

class Game
  COLORS =[:white, :black]
  BOARD_LETTERS = {
    "a" => 0,
    "b" => 1,
    "c" => 2,
    "d" => 3,
    "e" => 4,
    "f" => 5,
    "g" => 6,
    "h" => 7
  }
  def initialize#(p1, p2)
    @board = Board.new
    @current = :white
#    @white_player = p1
#    @black_player = p2
  end
  

  
  def run
    until @board.checkmate?(@current)
      @board.render
      player_move = get_player_move
      @board.move(player_move[0],player_move[1])
      #raise errors or whatever
      @current = (COLORS - [@current])[0]
    end
  end
  
  def get_player_move
      puts "#{@current} player please enter move (e2,e4)"
      #filter
      move = [nil,nil]
      gets.chomp.split(",").each_with_index do |el, index|
        place = el.split("")
        place[0] = BOARD_LETTERS[place[0]]
        place[1] = place[1].to_i - 1
        move[index] = place
      end
      move
  end  
  
  def view_captured
    
    
  end
end
  
  
class Player
  
  
  
  
end

