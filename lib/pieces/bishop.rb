# encoding: UTF-8

require_relative 'piece.rb'

class Bishop < SlidingPiece
  
  def name
    @color == :white ? "B".red : "B".black
  end
  
  def move_dirs
    DIAG
  end
end
