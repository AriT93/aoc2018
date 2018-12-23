# frozen_string_literal: true

require 'awesome_print'

# Node class
class Node
  attr_accessor :name, :metadata, :children, :meta_size

  def initialize(name = nil, children = nil, meta = nil)
    @name = name
    @metadata = meta
    @children = children
  end
end

nodes = ('A'..'Z').to_a

a = []
File.open('input.txt', 'r').each_line do |line|
  a = line.split(' ').map(&:to_i)
end

def build_tree(numbers, nodes)
  node = Node.new(nodes.shift, Array.new(numbers.shift), Array.new(numbers.shift))
  node.children.size.times do |c|
    node.children[c] = build_tree(numbers, nodes)
  end
  node.metadata.size.times { |m| node.metadata[m] = numbers.shift }
  node
end

head = build_tree(a, nodes)

def node_value(node)
  return 0 if node.nil?
  return node.metadata.sum if node.children.size.zero?

  sum_tree(node)
end

def sum_tree(head_node)
  sum = 0
  head_node.metadata.each do |meta|
    next if head_node.children.size < meta

    sum += node_value(head_node.children[meta - 1])
  end
  sum
end

p sum_tree(head)
