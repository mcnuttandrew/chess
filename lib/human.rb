

class HumanPlayer
  attr_reader :color
  
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
  
  def initialize(color, board)
    @color = color
    @board = board
  end
  
  def play_turn(board)
    @board = board
    render
    puts "It is the #{@color} player's turn. "
    get_player_input
  end 
  
  def get_player_input
      puts "#{@color} player please enter move (e2,e4)"
      input = gets.chomp
      validity =  valid_input?(input)#input.all?{|el| valid_input?(el)}
      
      raise "That isn't a valid input." unless validity
      return 'quit' if input == "quit"
      return view_captured if ((input.downcase) == "capt")
      return compute_move(input)
      # save if ((input.downcase) == "save")
      # load if ((input.downcase) == "load")
    rescue Exception => e
      puts e.message
      retry
    end
  
  def compute_move(input)
    move = []
    input.split(",").each do |el|
      place = el.split("")
      move << [BOARD_LETTERS[place[0].downcase], place[1].to_i - 1]
    end 
    raise "There's no piece there." if no_piece?(move.first)
    raise "That piece isn't yours." unless same_color?(move.first)
    move
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
    nil
  end
  
  def valid_input?(input)
    input =~ /[A-Ha-h][1-8],[A-Ha-h][1-8]|\Aquit\z|z/ ? true : false
  end
  
 
 
  def same_color?(place)
    @board[place].color == @color
  end
  
  def no_piece?(place)
    @board[place].nil?
  end
    
  def render
    shift = false
    p ("  "+ ('A'..'H').to_a.join("  "))
    @board.rows.reverse.each_with_index do |row, row_index|
      index = -1
       row_output = row.map do |el|
        index = index + 1
        el.nil? ? render_empty(index, shift) : render_filled(index, el, shift)
      end
      puts ("#{8-row_index} " + row_output.join(""))
      shift = !shift
    end
  end
  
  def render_empty(index, shift)
    if ((index + (shift ? 1 : 0)) % 2) == 0 
      "   ".on_cyan 
    else   
      "   ".on_light_yellow
    end
  end
  
  def render_filled(index, el, shift)
    if ((index + (shift ? 1 : 0)) % 2) == 0 
      (" " + el.name + " ").on_cyan
    else
      (" " + el.name + " ").on_light_yellow 
    end
  end
  
end
