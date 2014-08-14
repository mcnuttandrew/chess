# encoding: UTF-8

require_relative 'piece.rb'

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


