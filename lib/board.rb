class Board
  attr_accessor :captured
  def initialize
    @rows = Array.new(8) { Array.new(8, nil) }
    @captured = []
    place_pieces
  end
 
  def move(start, end_pos)#assume input in prply formatted move [x,y]
    piece = self[start]
    if piece 
      moves_col = piece.get_moves
      if moves_col.include?(end_pos)
        moves_col.select!{|el| piece.check_valid?(el)}

        if moves_col.include?(end_pos) 
          moves_col
          piece.move!(end_pos)
        end
      end
    end
  end
 
  def dup
    duped_board = Board.new
    pieces_list = @rows.flatten.compact
    pieces_list.each do |el|
      duped_board.place_piece(el.class, el.pos.dup, el.color)
    end
    duped_board
  end

  def place_pieces
    pieces = []
    colors = [:white, :black]
    [0, 7].each_with_index do |el, clr_idx|
      pieces << place_piece(Rook, [0, el], colors[clr_idx])
      pieces << place_piece(Knight, [1, el], colors[clr_idx])
      pieces << place_piece(Bishop, [2, el], colors[clr_idx])
      pieces << place_piece(Queen, [3, el], colors[clr_idx])
      pieces << place_piece(King, [4, el], colors[clr_idx])
      pieces << place_piece(Bishop, [5, el], colors[clr_idx])
      pieces << place_piece(Knight, [6, el], colors[clr_idx])
      pieces << place_piece(Rook, [7, el], colors[clr_idx])
    end
    [1,6].each_with_index do |el, clr_inx|
      (0..7).each do |spot_inx|
        pieces << place_piece(Pawn, [spot_inx, el], colors[clr_inx])
      end
    end
    pieces.each { |piece| self[piece.pos] = piece }
  end
 
  def place_piece(class_name, pos, color)
    class_name.new(pos, self, color)
  end
  
  def get_color(color)
    @rows.flatten.compact.select { |item| (item.color == color) }
    # puts @rows
    # puts "PING"
    # puts @rows.flatten.compact.select{|item| (item.color == some_color)}
     # @rows.flatten.compact.select{|item| (item.color == some_color)}
  end
 
  def in_check?(some_color)
    king = get_color(some_color).select{|el| el.is_a?(King)}[0]
#    puts king
    return false if king.nil?
    opposite_color = [:black, :white] - [some_color]
    enemies = get_color(opposite_color[0])
    enemies.each do |enemy|
      #decouple
      #p enemy.pos
       if enemy.get_moves.include? king.pos
         return true
       end
    end
    false
  end
 
  def render
    @rows.each do |row|
      p row.map { |el| el.nil? ? "_" : el.name }.join(" ")
    end
  end

  def [](pos)
    @rows[pos[1]][pos[0]]
  end
 
  def []=(pos, val)
    @rows[pos[1]][pos[0]] = val
  end
end
