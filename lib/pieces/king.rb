# encoding: UTF-8

require_relative 'piece.rb'

class King < SteppingPiece
  
  def name
    @color == :white ? "K".red : "K".black
  end
  
  def move_dirs
    [[0, 1], [0, -1], [1, 0],[-1, 0], [1, 1], [-1, -1], [-1, 1], [1, -1]]
  end
end
