# encoding: UTF-8

require_relative 'piece.rb'

class Pawn < SteppingPiece
  def initialize(*args)
    @moved = false
    super
  end
  
  def get_moves
    dirs = move_dirs
    total_moves = []
    dirs.each do |dir|
      possible_space = [pos[0] + dir[0], pos[1] + dir[1]]
      if (0..7).include?(possible_space[0]) && (0..7).include?(possible_space[1])
        if @board[possible_space].nil? 
          total_moves << possible_space 
        end
      end
    end
    
    am = attack_moves unless attack_moves.nil? 
    am.each do |dir|
      possible_space = [pos[0] + dir[0], pos[1] + dir[1]]
      if (0..7).include?(possible_space[0]) && (0..7).include?(possible_space[1])
        if !@board[possible_space].nil? && @board[possible_space].color != @color
          total_moves << possible_space 
        end
      end
    end
    total_moves
  end
  
  def attack_moves
    extra_moves = []
    attack_dirs.each do |dir|
      x = @pos[0] + dir[0]
      y = @pos[1] + dir[1]
      next unless (0..7).include? (x)
      next unless (0..7).include? (y)
      next if @board[[x,y]].nil?
      extra_moves << dir if @board[[x,y]].color != @color 
    end
    extra_moves
  end
  
  def name
    @color == :white ? "P".red : "P".black
  end
  
  def attack_dirs
    @color == :white ? [[1,1], [-1,1]] : [[-1,-1], [1,-1]]
  end
  
  def move_dirs
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