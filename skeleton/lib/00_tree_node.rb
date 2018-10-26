require 'byebug'

class PolyTreeNode
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent
    @parent
  end
  
  def children
    @children
  end
  
  def value
    @value
  end
  
  def parent=(parent_node)
    if parent_node
      if @parent
        @parent.children.delete(self)
        @parent = nil
      end
      @parent = parent_node
      @parent.children << self unless @parent.children.include?(self)
    else
      @parent = nil
    end
  end
  
  def add_child(child_node)
    child_node.parent = self
    self.children << child_node unless self.children.include?(child_node)
  end
  
  def remove_child(child_node)
    raise "That's not a child!" if !self.children.include?(child_node)
    self.children.delete(child_node)
    child_node.parent = nil
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    
    self.children.each do |child|
      current_val = child.dfs(target_value)
      return current_val if current_val
    end

    nil
  end
  
  def bfs(target_value)
    queue = [self]
    
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      current_node.children.each { |child| queue << child }
    end
  
    nil
  end
end

