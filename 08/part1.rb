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

def sum_tree(head_node)
  sum = 0
  sum += head_node.metadata.sum
  head_node.children.each { |node| sum += sum_tree(node) }
  sum
end

p sum_tree(head)
