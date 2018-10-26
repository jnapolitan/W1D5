require_relative '00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  
  def initialize(pos)
    @pos = pos
    @root_node = PolyTreeNode.new(pos)
    @visited_positions = [pos]
  end
  
  def self.valid_moves(pos)
    # debugger
    valid_moves = []
    board_range = (0..7).to_a
    
    (-1..1).each do |x|
      (-1..1).each do |y|
        new_move = pos[0] + x, pos[1] + y
        valid_moves << new_move if new_move.all? { |el| board_range.include?(el) }
      end
    end
    
    valid_moves    
  end
  
  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    @visited_positions.each { |pos| moves.delete(pos) }
    @visited_positions += moves
    moves
  end
  
end