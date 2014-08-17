# encoding: UTF-8

require_relative 'piece.rb'

class Queen < SlidingPiece

  def name
    @color == :white ? "Q".red : "Q".black
  end

  def move_dirs
    HORIZ + DIAG
  end
end