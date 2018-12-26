# frozen_string_literal: true

require 'awesome_print'

input = File.open('test_input.txt').each_line.map(&:chomp)

initial = input.shift.split(':').last.strip.split('')

input.shift
input.each do |line|
  p line
end

# >> "...## => #"
# >> "..#.. => #"
# >> ".#... => #"
# >> ".#.#. => #"
# >> ".#.## => #"
# >> ".##.. => #"
# >> ".#### => #"
# >> "#.#.# => #"
# >> "#.### => #"
# >> "##.#. => #"
# >> "##.## => #"
# >> "###.. => #"
# >> "###.# => #"
# >> "####. => #"
