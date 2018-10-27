require_relative '00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  attr_reader :root_node

  def initialize(pos)
    @pos = pos
    @root_node = PolyTreeNode.new(pos)
    @visited_positions = [pos]
    build_move_tree
  end

  def build_move_tree
    queue = [@root_node]

    until queue.empty?
      current_node = queue.shift
      new_move_positions(current_node.value).each do |move|
        move_node = PolyTreeNode.new(move)
        current_node.add_child(move_node)
        queue << move_node
      end
    end
  end

  def self.valid_moves(pos)
    valid_moves = []
    board_range = (0..7).to_a

    (-2..2).each do |x|
      (-2..2).each do |y|
        unless x == 0 || y == 0
          if (x.abs == 2 && y.abs == 1) || (x.abs == 1 && y.abs == 2)
            new_move = pos[0] + x, pos[1] + y
            valid_moves << new_move if new_move.all? { |el| board_range.include?(el) }
          end
        end
      end
    end

    valid_moves
  end

  def traceback(node)
    return [node.value] if node.parent.nil?
    traceback(node.parent) << node.value
  end

  def find_path(end_pos)
    queue = [@root_node]

    until queue.empty?
      current_node = queue.shift
      return traceback(current_node) if current_node.value == end_pos
      current_node.children.each { |child| queue << child }
    end

    nil
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    @visited_positions.each { |pos| moves.delete(pos) }
    @visited_positions += moves
    moves
  end

end
