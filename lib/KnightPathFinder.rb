require_relative '00_tree_node.rb'
require 'byebug'
OFFSET = [[-1, 2], [-2, 1], [2, 1], [1, 2], [-2, 1], [-1, 2], [-1, -2], [-2, -1]]

class KnightPathFinder
  attr_reader :root
  def initialize(position)
    @position = position
    @visited = [position]
    @board = Array.new(8) { Array.new(8) {' '} }
    @root = PolyTreeNode.new(position)
  end

  def new_move_positions(start_position)
      possible = []
      x_cord = start_position[0]
      y_cord = start_position[1]
      OFFSET.each do |pos_change|
        current = [x_cord + pos_change[0], y_cord + pos_change[1]]
        possible << current if self.class.valid_move?(current)
      end
      possible.reject { |pos| @visited.include?(pos) }
  end

  def self.valid_move?(position)
    row, col = position
    row.between?(0, 7) && col.between?(0, 7)
  end

  def find_path(end_pos)
    # debugger
    build_move_tree
    target_node = @root.dfs(end_pos)
    trace_path = []
    until target_node == @root
      trace_path << target_node.value
      target_node = target_node.parent
    end
    trace_path << @root.value 
    trace_path.reverse
  end

  def build_move_tree
    queue = [root]
    debugger
    until queue.empty?
      current = queue.shift
      @visited << current.value unless @visited.include?(current.value)
      moves = new_move_positions(current.value)
      new_nodes = moves.map { |pos| PolyTreeNode.new(pos)  }
      new_nodes.each { |node| current.add_child(node) }
      current.children.each { |child| child.parent = current }
      queue.concat(current.children)
      # return curr_node if curr_node.value == target
    end

  end

end
