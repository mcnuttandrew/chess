# encoding: UTF-8

require_relative 'piece.rb'

class Queen < SlidingPiece

  def name
    @color == :white ? "♛" : "♕"
  end

  def move_dirs
    HORIZ + DIAG
  end
end