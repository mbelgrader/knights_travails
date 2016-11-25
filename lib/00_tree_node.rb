# class PolyTreeNode
#   def initialize
#
#   end
# end
require 'byebug'

class PolyTreeNode
  attr_accessor :value, :parent, :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent=nil)

    # debugger
    self.parent.children.delete(self) if self.parent
    @parent = parent
    if !parent.nil?
      parent.children << self unless parent.children.include?(self)
    end
  end

  def add_child(child_node)
    @children << child_node
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "No child" unless children.include?(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target = nil)
    return self if self.value == target

    self.children.each do |child|
      result = child.dfs(target)
      return result if result
    end

    nil
  end

  def bfs(target = nil)
    queue = [self]

    until queue.empty?
      curr_node = queue.shift
      queue.concat(curr_node.children)
      return curr_node if curr_node.value == target
    end

    nil
  end

end
