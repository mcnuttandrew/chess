# encoding: UTF-8

class Piece
  attr_reader :pos, :board, :color
  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  def check_valid?(pos)
    if move_into_check?(pos)
      return false
    end
    if @board[pos].nil? || (@board[pos].color != color)
      return true
    end
    false
  end
  
  def move! new_pos
     if !@board[new_pos].nil? && (@board[new_pos].color != color)
       capture!(@board[new_pos])
     end
     @board[@pos] = nil
     @pos = new_pos
     @board[new_pos] = self
     self.mark_moved if self.is_a?(Pawn)
  end
  
  def capture! piece
    piece.delete!
    @board.captured << piece
  end
  
  def move_into_check?(new_pos) 
     new_board = @board.dup(nil)
     clone_piece = new_board[@pos]
     clone_piece.move!(new_pos) unless clone_piece.nil?
     new_board.in_check?(@color)
  end
  
  def delete! 
    @pos = nil
  end
end








 