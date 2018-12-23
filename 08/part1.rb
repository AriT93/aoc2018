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
  node = Node.new(nodes.shift, [], [])
  children = numbers.shift
  metadata = numbers.shift
  children.times { node.children << build_tree(numbers, nodes) }
  metadata.times { node.metadata << numbers.shift }
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
