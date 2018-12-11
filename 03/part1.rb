# frozen_string_literal: true

require 'awesome_print'

cloth = Array.new(10) { Array.new(10, 0) }
part2_cloth = Array.new(10) { Array.new(10) }
maps = []

def print_ar(arr)
  arr.each do |x|
    puts x.join(' ')
  end
  puts "\n"
end

File.open('test_input.txt', 'r').each_line do |line|
  _start, claim, left, top, width, height, _endl = line.split(/^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/).map(&:to_i)
  maps << [claim, left, top, width, height]
  (top..(top + height - 1)).each do |row|
    (left..(left + width - 1)).each do |col|
      cloth[row][col] += 1
      part2_cloth[row][col] = [] unless part2_cloth[row][col]
      part2_cloth[row][col] << claim
    end
  end
end

puts(cloth.flatten.count { |e| e >= 2 })

puts(maps.find { |claim, _, _, width, height| part2_cloth.flatten(1).count { |a| a == [claim] } == width * height}[0])

# >> 4
# >> 3
