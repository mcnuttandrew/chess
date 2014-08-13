# encoding: UTF-8

class Piece
  attr_reader :pos, :board, :color
  def initialize(pos, board, color)
    @pos = pos
    @board = board
    @color = color
  end

  
  def check_valid?(pos)
    #check if moving into check
    if move_into_check?(pos)
      return false
    end
    #check if space is empty or capturable
    if @board[pos].nil? || (@board[pos].color != color)
      return true 
    end
    false
  end
  

  
  def move! new_pos
     #return unless check_valid?(new_pos)
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

class SteppingPiece < Piece
  def get_moves
    dirs = move_dirs
    total_moves = []
    dirs.each do |dir|
      possible_space = [pos[0] + dir[0], pos[1] + dir[1]]
      if (0..7).include?(possible_space[0]) && (0..7).include?(possible_space[1]) 
        total_moves << possible_space 
      end
    end
    total_moves
  end
end

class Pawn < SteppingPiece
  def initialize(*args)
    @moved = false
    super
  end
  
  def get_moves
    dirs = move_dirs
    dirs += attack_moves unless attack_moves.empty? 
    total_moves = []
    dirs.each do |dir|
      possible_space = [pos[0] + dir[0], pos[1] + dir[1]]
      if (0..7).include?(possible_space[0]) && (0..7).include?(possible_space[1]) 
        total_moves << possible_space 
      end
    end
    total_moves
  end
  
  def attack_moves
    #find position
    extra_moves = []
    attack_dirs.each do |dir|
      x = @pos[0] + dir[0]
      y = @pos[1] + dir[1]
      next unless (0..7).include? (x)
      next unless (0..7).include? (y)
      next if @board[[x,y]].nil?
      p [x,y]
      extra_moves << dir if @board[[x,y]].color != @color 
    end
    extra_moves
  end
  
  def name
    @color == :white ? "♟" : "♙"
  end
  
  def attack_dirs
    @color == :white ? [[1,1], [-1,1]] : [[-1,-1], [1,-1]]
  end
  
  def move_dirs
    #special case the colors
    if @color == :white
      @moved ? [[0,1]] : [[0,1], [0,2]]
    else
      @moved ? [[0,-1]] : [[0,-1], [0,-2]]
    end
  end
  
  def mark_moved
    @moved = true
  end
  
end



class King < SteppingPiece
  
  def name
    @color == :white ? "♚" : "♔"
  end
  
  def move_dirs
    [[0, 1], [0, -1], [1, 0],[-1, 0], [1, 1], [-1, -1], [-1, 1], [1, -1]]
  end
end

class Knight < SteppingPiece
  
  def name
    @color == :white ? "♞" : "♘"
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
        x_component = @pos[0] + (dir[0] * index)
        y_component = @pos[1] + (dir[1] * index)
        new_position = [x_component, y_component]
        if (0..7).include?(x_component) && (0..7).include?(y_component) 
          if !@board[new_position].nil? && @board[new_position].color != @color
            total_moves << [x_component, y_component]
            break
          end 
          total_moves << [x_component, y_component]
        end
      end
    end
    total_moves
  end

  def move_dirs
    []
  end
end

7372 


class Rook < SlidingPiece

  def name
    @color == :white ? "♜" : "♖"
  end
  
  def move_dirs
    HORIZ
  end
end

class Bishop < SlidingPiece
  
  def name
    @color == :white ? "♝" : "♗"
  end
  
  def move_dirs
    DIAG
  end
end

class Queen < SlidingPiece

  def name
    @color == :white ? "♛" : "♕"
  end

  def move_dirs
    HORIZ + DIAG
  end
end
 