# encoding: UTF-8

require_relative 'lib/game.rb'

g = Game.new
g.run

# require_relative 'lib/pieces.rb'
#
# g = Board.new
# g.render


#
# h = g.dup
#
# puts '1. Duped board contains new pieces'
# puts h[[0, 1]].object_id != g[[0, 1]].object_id
#
# puts '2. Duped board does not move pieces on original board'
# h.move([0,1],[0,3])
# puts g[[0, 3]] == nil
#
# puts '3. Duped board does not have starting lineup'
# g.move([0,1],[0,3])
# board = g.dup
# puts board[[0,1]] == nil
#
# puts "4. Duped board does have original board's pieces in place"
# puts board[[0,3]] != nil


#
# g.move([0,1],[0,3])
# #
# g.move([0,0],[0,2])
# g.move([0,2],[4,2])
# g.move([4,6],[4,4])
# g.move([4,2],[4,4])
#
# g.render
# g.move([5,7],[4,6])
# #p g.in_check?(:black)
# #g.move([5,7], [4,6])
# #g.render
# #p g.in_check?(:black)
# g.render
# g.move([4,6],[5,7])
# g.render
# puts g.captured
#
#
# g.move([4,1],[4,3] )
# g.move([4,6],[4,4] )
# g.move([5,0], [2, 3] )
# g.move([3,0], [7, 4] )
# g.render
# g.move([3, 7], [4,6] )
# g.move([7, 4], [5,6] )
# g.render
# p g.checkmate?(:black)

