# frozen_string_literal: true

require 'awesome_print'
require 'set'

coords = File.read('input.txt')

pairs = coords.split("\n").map do |ord|
  ord.split(',').map(&:to_i)
end

rows = pairs.map(&:first).max
cols = pairs.map(&:last).max

counts = Array.new(pairs.size, 0)
infinite = Set.new

(rows + 2).times do |x|
  (cols + 2).times do |y|
    distances = {}

    pairs.map.with_index do |(x1, y1), idx|
      distances[idx] = (x - x1 + 1).abs + (y - y1 + 1).abs
    end

    min = distances.values.min

    min_ords = distances.select { |_idx, dist| dist == min }

    ord_idx = min_ords.keys.first

    if min_ords.size == 1
      counts[ord_idx] += 1

      if x.zero? || y.zero? || x == rows + 1 || y == cols + 1
        infinite.add(ord_idx)
      end
    end
  end
end

infinite.each do |ig|
  counts[ig] = 0
end

puts counts.max

# >> 3358
