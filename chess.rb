require_relative 'lib/board.rb'
require_relative 'lib/pieces.rb'

g = Board.new
g.render

g.move([0,1],[0,3])
g.render
g.move([0,0],[0,2])
g.render
g.move([0,2],[4,2])
g.render
g.move([4,2],[4,6])
g.render
g.move([4,6],[4,2])
g.render
p g.in_check?(:black)

