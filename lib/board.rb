

 class Board
   def initialize
     @rows = Array.new(8) { Array.new(8) { nil } }
     place_pieces
   end
   
   def move(start, end_pos)#assume input in prply formatted move [x,y]
     piece = self[start]
     p piece.get_moves
     if piece && piece.get_moves.include?(end_pos)
       # piece.get_moves.each do |something|
#          p something
#        end
       p "ping"
              
       piece.move!(end_pos)
              

       # p piece.pos
     end
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

     pieces.each{ |piece| self[piece.pos] = piece }
   end
   
   def place_piece(class_name, pos, color)
     class_name.new(pos, self, color)
   end

   def render
     # system 'clear'
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
