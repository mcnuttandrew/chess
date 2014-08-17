# encoding: UTF-8

class Board
  attr_accessor :captured
  attr_reader :rows
  def initialize(prepoped = true)
    @rows = Array.new(8) { Array.new(8, nil) }
    @captured = []
    @stale_moves = 0
    place_pieces if (prepoped == true)
  end
 
  def move(start, end_pos)
    num_captures = @captured.length
    piece = self[start]
    if piece 
      moves_col = piece.get_moves
      if moves_col.include?(end_pos)
        moves_col.select!{|el| piece.check_valid?(el)}
        piece.move!(end_pos) if moves_col.include?(end_pos) 
        increment_stalemate(piece, num_captures)
      else
        false
      end
    else
      false
    end
    true
  end
  
  def increment_stalemate(piece, num_captures)
    if piece.class == Pawn || @captured.length > num_captures
      @stale_moves = 0
    else 
      @stale_moves += 1
    end
  end
 
  def dup(something)
    duped_board = Board.new(false)
    pieces_list = @rows.flatten.compact
    pieces_list.map do |el|
      duped_board.place_piece(el.class, el.pos.dup, el.color, duped_board)
    end
    duped_board
  end

  def place_pieces
    colors = [:white, :black]
    [0, 7].each_with_index do |el, clr_idx|
      place_piece(Rook, [0, el], colors[clr_idx])
      place_piece(Knight, [1, el], colors[clr_idx])
      place_piece(Bishop, [2, el], colors[clr_idx])
      place_piece(Queen, [3, el], colors[clr_idx])
      place_piece(King, [4, el], colors[clr_idx])
      place_piece(Bishop, [5, el], colors[clr_idx])
      place_piece(Knight, [6, el], colors[clr_idx])
      place_piece(Rook, [7, el], colors[clr_idx])
    end
    [1,6].each_with_index do |el, clr_inx|
      (0..7).each do |spot_inx|
         place_piece(Pawn, [spot_inx, el], colors[clr_inx])
      end
    end
  end
 
  def place_piece(class_name, pos, color, new_board = self)
    piece = class_name.new(pos.dup, new_board, color)
    new_board[piece.pos] = piece    
  end
  
  def get_color(color)
    @rows.flatten.compact.select { |item| (item.color == color) }
  end
 
  def in_check?(some_color)
    king = get_color(some_color).compact.select{|el| el.is_a?(King) }
    king = king[0]
    return false if king.nil? #workaround
    opposite_color = [:black, :white] - [some_color]
    enemies = get_color(opposite_color[0])
    enemies.each do |enemy|
       return true if enemy.get_moves.include? king.pos
    end
    false
  end
 
  def [](pos)
    @rows[pos[1]][pos[0]]
  end
 
  def []=(pos, val)
    @rows[pos[1]][pos[0]] = val
  end
  
  def checkmate?(color)
    return false unless in_check?(color)
    pieces = get_color(color)
    pieces.all? do |piece| 
      piece.get_moves.select{|el| piece.check_valid?(el)}.empty?
    end
  end
  
  def stalemate?
    [:white,:black].each do |color|
      return false if in_check?(color)
      pieces = get_color(color)
      pieces.all? do |piece| 
        piece.get_moves.select{|el| piece.check_valid?(el)}.empty?  
      end
    end
    return true if @stale_moves >= 50
  end
  
  def game_over?
    if checkmate?(:white)||checkmate?(:black)|| stalemate?
      return true
    end
    false
  end
  
  
end
