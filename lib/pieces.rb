class Piece
  attr_reader :pos, :board, :color, :name
  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end
  
  def check_valid?(pos)
    #cehck on board
    unless (0..7).include?(pos[0]) && (0..7).include?(pos[1]) 
      return false 
    end
    #check if moving into check
    if move_into_check?(pos)
      return false
    end
    #check if space is empty or capturable
    if @board[pos].nil? || (@board[pos].color != color)
      return true 
    end
    true
  end
  

  
  def move! new_pos
     #return unless check_valid?(new_pos)
     if @board[new_pos] && (@board[new_pos].color != color)
       capture!(@board[new_pos])
     end
     @board[@pos] = nil
     @pos = new_pos
     @board[new_pos] = self
     self.mark_moved if self.is_a?(Pawn)
  end
  
  def capture! piece
    p "captured!"
    piece.delete!
    @board.captured << piece
  end
  
  def move_into_check?(new_pos) 
    new_board = @board.dup
    #get piece at this location from duped
    clone_piece = new_board[@pos]
    clone_piece.move!(new_pos)
    #move piece
    #check
    new_board.in_check?(@color)
  end
  
  def delete! 
    @pos = nil
  end
end

class SteppingPiece < Piece
  def get_moves
    dirs = move_dirs
    total_moves = []
    dirs.each do |dir|
      possible_space = [pos[0] + dir[0], pos[1] + dir[1]]
      total_moves << possible_space if check_valid?(possible_space)
    end
    p total_moves
    total_moves
  end
end

class Pawn < SteppingPiece
  def initialize(*args)
    @name = "P"
    @moved = false
    super
  end
  
  def move_dirs
    @moved ? [[0,1]] : [[0,1], [0,2]]
  end
  
  def mark_moved
    @moved = true
  end
  
end



class King < SteppingPiece
  def initialize(*args)
    @name = "K"
    super
  end

  def move_dirs
    [[0, 1], [0, -1], [1, 0],[-1, 0], [1, 1], [-1, -1], [-1, 1], [1, -1]]
  end
end

class Knight < SteppingPiece
  def initialize(*args)
    @name = "H"
    super
  end

  def move_dirs
    [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
  end
end

class SlidingPiece < Piece
  
  HORIZ = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  DIAG = [[1, 1], [-1, -1], [-1, 1],[1, -1]]
  
  def get_moves
    dirs = move_dirs
    total_moves = []
    dirs.each do |dir|
      (1..7).each do |index|
        x_component = pos[0] + (dir[0] * index)
        y_component = pos[1] + (dir[1] * index)
        total_moves << [x_component, y_component]

      end
    end
    total_moves.select!{|el| check_valid?(el)}
  end

  def move_dirs
    []
  end
end


class Rook < SlidingPiece
  def initialize(*args)
    @name = "R"
    super
  end

  def move_dirs
    HORIZ
  end
end

class Bishop < SlidingPiece
  def initialize(*args)
    @name = "B"
    super
  end

  def move_dirs
    DIAG
  end
end

class Queen < SlidingPiece
  def initialize(*args)
    @name = "Q"
    super
  end

  def move_dirs
    HORIZ + DIAG
  end
end
 