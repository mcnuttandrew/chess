require_relative 'lib/board.rb'
require_relative 'lib/pieces.rb'

g = Board.new
g.render


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



g.move([0,1],[0,3])
#
g.move([0,0],[0,2])
#
# g.move([4,2],[4,6])
# g.move([4,6],[4,2])
g.render

