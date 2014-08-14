# encoding: UTF-8

require_relative './piece.rb'


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
          if !@board[new_position].nil? && @board[new_position].color == @color
            break
          end
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