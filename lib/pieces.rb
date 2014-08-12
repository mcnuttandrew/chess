class Piece
  attr_reader :pos, :board, :color, :name
  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end
  
  def check_valid?(pos)
    unless @board[pos].nil?
      # puts "That space is taken"
      return false 
    end
    unless (0..7).include?(pos[0]) && (0..7).include?(pos[1])
      # puts "That space is out of bounds"
      return false 
    end
    true
  end
  
  def move! new_pos
    return unless check_valid?(new_pos)
    @board[@pos] = nil
    @pos = new_pos
    @board[new_pos] = self
    if self.is_a? Pawn
      self.mark_moved
    end

    # if @board[pos] && @board[pos].color != color
 #      capture!(@board[pos])
 #    end
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
      index = 1
      loop do
        x_component = pos[0] + (dir[0] * index)
        y_component = pos[1] + (dir[1] * index)
        possible_space = [x_component, y_component]
        if check_valid?(possible_space)
          total_moves << possible_space
        else
          break
        end
        index += 1
      end
    end
    p total_moves
    total_moves
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
    HORIZ.concat(DIAG)
  end
end
 