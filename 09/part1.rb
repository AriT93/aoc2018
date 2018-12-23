# frozen_string_literal: false

require 'rspec/autorun'

# tree class
class Tree
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left || self
    @right = right || self
  end

  def insert(value)
    right = self.right

    new_marble = Tree.new(value, self, right)

    self.right = new_marble
    right.left = new_marble
  end

  def remove
    left = self.left
    right = self.right

    left.right = right
    right.left = left
  end
end

def game(players, max)
  totals = Array.new(players, 0)
  value = 0

  current = Tree.new(value)

  max.times do
    value += 1
    player = value % players

    if (value % 23).zero?
      7.times { current = current.left }

      totals[player] += current.value
      totals[player] += value

      current.remove
      current = current.right
    else
      current.right.insert(value)
      current = current.right.right
    end
  end
  totals
end

describe Tree do
  let(:t) { Tree.new(0) }
  it 'is a class' do
    expect(t).to be_a(Tree)
    expect(t.right).to eq(t)
    expect(t.left).to eq(t)
  end

  it 'inserts a new value' do
    t.insert(1)
    expect(t.right.value).to eq(1)
  end

  it 'should remove a node' do
    t.right.remove
    expect(t.right).to eq(t)
  end
end

describe 'game' do
  it 'will return correct score for the examples' do
    expect(game(9, 25).max).to eq(32)
    expect(game(10, 1618).max).to eq(8317)
    expect(game(13, 7999).max).to eq(146373)
    expect(game(17, 1104).max).to eq(2764)
    expect(game(21, 6111).max).to eq(54718)
    expect(game(30, 5807).max).to eq(37305)
  end
end

p game(479, 71035).max
p game(479, 71035 * 100).max

# >> 367634
# >> 3020072891
# >> ....
# >>
# >> Finished in 0.02578 seconds (files took 3.71 seconds to load)
# >> 4 examples, 0 failures
# >>
