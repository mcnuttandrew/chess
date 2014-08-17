# encoding: UTF-8

require_relative 'piece.rb'

class Rook < SlidingPiece

  def name
    @color == :white ? "R".red : "R".black
  end
  
  def move_dirs
    HORIZ
  end
end
