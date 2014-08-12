require_relative 'lib/board.rb'
require_relative 'lib/pieces.rb'

g = Board.new
g.render
g.move([0,1],[0,3])
g.render
g.move([0,3],[0,5])
g.render
g.move([0,3],[0,4])
g.render