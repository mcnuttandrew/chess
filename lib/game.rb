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
    input = gets.chomp
    unless valid_input?(input)
      puts "that isn't a valid input. Please enter something like e2,e3"
      get_player_move
    end
    view_captured if ((input.downcase) == "captured")
      
    input.split(",").each_with_index do |el, index|
      place = el.split("")
      place[0] = BOARD_LETTERS[place[0].downcase]
      place[1] = place[1].to_i - 1
      move[index] = place
    end
    if !no_piece?(move[0])
      move
    else
      puts "there's no piece there"
      get_player_move
    end
    if same_color?(move[0])
      move
    else
      puts "that piece isn't yours"
      get_player_move
    end
  end  
  
  def valid_input?(input)
    input =~ /[A-Ha-h][1-8],[A-Ha-h][1-8]|\Acaptured\z/ ? true : false
  end
  
  def same_color?(place)
    @board[place].color == @current
  end
  
  def no_piece?(place)
    @board[place].nil?
  end
    
  def view_captured
    capt = @board.captured
    if capt.empty?
      puts "No pieces have been captured"
      get_player_move  
    else
      "Captured White Pieces"
      capt.each do |piece| 
        p piece.name if piece.color == :white
      end
      "Captured Black Pieces"
      capt.each do |piece| 
        p piece.name if piece.color == :black
      end
      
    end
    
    get_player_move
  end
end
  
  
class Player
  
  
  
  
end

