# frozen_string_literal: true

coords = File.read('input.txt')

pairs = coords.split("\n").map do |ord|
  ord.split(',').map(&:to_i)
end

rows = pairs.map(&:first).max + 1
cols = pairs.map(&:last).max + 1

count = 0

rows.times do |x|
  cols.times do |y|
    sum = pairs.map.inject(0) do |sumother, (x1, y1)|
      sumother + (x - x1).abs + (y - y1).abs
    end

    count += 1 if sum < 10_000
  end
end

p count

# >> 45909
