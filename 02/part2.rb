# frozen_string_literal: true

box_ary = []

File.open('./input.txt', 'r').each_line do |line|
  box_ary.push line.chomp
end

box_ary.combination(2).any? do |left, right|
  a = left.chars.each_with_index.to_a - right.chars.each_with_index.to_a
  next unless a.size == 1

  badchar = a.first.last
  puts(left.tap { |s| s.slice!(badchar) })
  return 0
end
