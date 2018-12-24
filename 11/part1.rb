# frozen_string_literal: true

require 'rspec/autorun'

def calc_power(x, y, serial)
  rid = x + 10
  power = y * rid
  power += serial
  power *= rid
  mag = (power / 100) % 10
  mag - 5
end

# build our grid
def build_grid(serial)
  grid = Array.new(300) { Array.new(300, 0) }
  300.times do |x|
    300.times do |y|
      grid[x][y] = calc_power(x, y, serial)
    end
  end
  grid
end

def find_highest_power(serial)
  grid = build_grid(serial)
  max = max_x = max_y = nil

  297.times do |x|
    297.times do |y|
      sum = 0
      3.times do |x1|
        3.times do |y1|
          sum += grid[x + x1][y + y1]
        end
      end

      next unless max.nil? || sum > max

      max = sum
      max_x = x
      max_y = y
    end
  end
  [max_x, max_y]
end

def find_highest_square(serial)
  grid = build_grid(serial)
  max = max_x = max_y = max_size = nil

  40.times do |size|
    size += 1

    (300 - size).times do |x|
      (300 - size).times do |y|
        sum = 0

        size.times do |x1|
          size.times do |y1|
            sum += grid[x + x1][y + y1]
          end
        end

        next unless max.nil? || sum > max

        max = sum
        max_x = x
        max_y = y
        max_size = size
      end
    end
  end
  [max_x, max_y, max_size]
end

p find_highest_square(1788)
p find_highest_power(1788)

describe '#calc_power' do
  it 'calcs power correctly' do
    expect(calc_power(3, 5, 8)).to eq(4)
    expect(calc_power(122, 79, 57)).to eq(-5)
    expect(calc_power(217, 196, 39)).to eq(0)
    expect(calc_power(101, 153, 71)).to eq(4)
  end
end

describe 'Get the Grid' do
  it 'passes example 1' do
    expect(find_highest_power(18)).to eq([33, 45])
  end
  it 'passes example 2' do
    expect(find_highest_power(42)).to eq([21, 61])
  end
end

# describe 'Get the Biggest square' do
#   it 'solves first example' do
#     expect(find_highest_square(18)).to eq([90, 269, 16])
#   end
#   it 'solves the second example' do
#     expect(find_highest_square(42)).to eq([232, 251, 12])
#   end
# end
