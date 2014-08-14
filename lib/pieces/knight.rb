# encoding: UTF-8

require_relative 'piece.rb'

class Knight < SteppingPiece
  
  def name
    @color == :white ? "♞" : "♘"
  end

  def move_dirs
    [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
  end
end
