require 'byebug'

class PolyTreeNode
  
  attr_reader :parent
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
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
  
  def parent
    @parent
  end
  
  def children
    @children
  end
  
  def value
    @value
  end
end

