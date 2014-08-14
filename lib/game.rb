#cd Desktop/w2d2/chess;ruby chess.rb

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
  
  def initialize
    @board = Board.new
    @current = :white
  end
  
  def run
    until game_over?
      begin
        @board.render
        player_move = get_player_move
        move_executed = @board.move(player_move[0],player_move[1])
        @current = (COLORS - [@current])[0]
        raise "Your move was invalid" if !move_executed
      rescue Exception => e
        puts e.message
        retry
      end
    end
    
    @current = (COLORS - [@current])[0]
    @board.render
    if @board.stalemate?
      puts "Game ends in stalemate, eh"
    else
      puts "#{@current} player won!"
    end
  end
  
  def game_over?
    if @board.checkmate?(:white)||@board.checkmate?(:black)|| @board.stalemate?
      return true
    end
    false
  end
  
  def get_player_move
    move = [nil,nil]
    begin
      puts "#{@current} player please enter move (e2,e4)"
      input = gets.chomp
      raise "That isn't a valid input." unless valid_input?(input)
      view_captured if ((input.downcase) == "captured")
      # save if ((input.downcase) == "save")
      # load if ((input.downcase) == "load")
      input.split(",").each_with_index do |el, index|
        place = el.split("")
        place[0] = BOARD_LETTERS[place[0].downcase]
        place[1] = place[1].to_i - 1
        move[index] = place
      end 
      raise "There's no piece there." if no_piece?(move[0])
      raise "That piece isn't yours." if !same_color?(move[0])
    rescue Exception => e
       puts e.message
      retry
    end
    move
  end  
  
  def valid_input?(input)
    input =~ /[A-Ha-h][1-8],[A-Ha-h][1-8]|\Acaptured\z|\Asave\z|\Aload\z/ ? true : false
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
  end
  
  # def save
  #   objects_to_save = [@board]
  #   @board.rows.flatten.compact.each do |piece|
  #     objects_to_save << piece
  #   end
  #   savable = objects_to_save.to_yaml
  #   File.open('save_game', 'w') do |f|
  #     f.puts savable
  #   end
  #   puts "Game saved"
  # end
  #
  # def load
  #   data = YAML::parse(File.read('save_game'))
  #   @board = data.shift
  #   data.each do |piece|
  #     place_piece(piece)
  #   end
  #   puts "game loaded"
  # end
    
    
end


