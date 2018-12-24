# frozen_string_literal: true

input = File.read('input.txt')

points = input.split("\n").map do |point|
  point.scan(/[\s\-]*\d*,\s*[\s\-]\d*>/).map do |a|
    a.split(',').map(&:to_i)
  end
end

min_area = min_i = x1 = y1 = x2 = y2 = nil

200_000.times do |i|
  min_x = max_x = min_y = max_y = nil

  points.map do |pos, vel|
    x = pos[0] + (vel[0] * i)
    y = pos[1] + (vel[1] * i)

    min_x = [x, min_x].compact.min
    max_x = [x, max_x].compact.max

    min_y = [y, min_y].compact.min
    max_y = [y, max_y].compact.max
  end

  area = (max_x - min_x) * (max_y - min_y)

  break unless min_area.nil? || area < min_area

  min_area = area

  min_i = i

  x1 = min_x
  x2 = max_x
  y1 = min_y
  y2 = max_y
end

cols = x2 - x1 + 1
rows = y2 - y1 + 1

grid = Array.new(rows) { Array.new(cols, ' ') }

points.each do |pos, vel|
  x = pos[0] + (vel[0] * min_i) - x1
  y = pos[1] + (vel[1] * min_i) - y1

  grid[y][x] = '#'
end

puts grid.map(&:join).join("\n")
puts min_i

# >> #####   #####   #    #     ###  ######  ######  #    #  #    #
# >> #    #  #    #  ##   #      #   #       #       ##   #  #    #
# >> #    #  #    #  ##   #      #   #       #       ##   #  #    #
# >> #    #  #    #  # #  #      #   #       #       # #  #  #    #
# >> #####   #####   # #  #      #   #####   #####   # #  #  ######
# >> #       #       #  # #      #   #       #       #  # #  #    #
# >> #       #       #  # #      #   #       #       #  # #  #    #
# >> #       #       #   ##  #   #   #       #       #   ##  #    #
# >> #       #       #   ##  #   #   #       #       #   ##  #    #
# >> #       #       #    #   ###    ######  ######  #    #  #    #
# >> 10375
