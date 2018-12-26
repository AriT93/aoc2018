# frozen_string_literal: true

require 'set'

grid = []

File.open('input.txt', 'r').each_line do |line|
  grid << line.chomp.split('')
end

p # class Postion

class Position
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def eql?(other)
    [@x, @y] == [other.x, other.y]
  end

  def inspect
    [x, y]
  end

  alias == eql?
end

# cart Class
class Cart
  attr_accessor :id, :pos, :direction, :next_turn

  def initialize(pos, direction)
    @id = (0...8).map { (65 + rand(26)).chr }.join
    @pos = pos
    @direction = direction
    @next_turn = :left
    @directions = %i[up right down left]
  end

  def hash
    @id.hash
  end

  def eql?(other)
    @id == other.id
  end

  alias == eql?

  def turn
    @direction
    case @next_turn
    when :right
      @direction = @directions[(@directions.index(@direction) + 1) % 4]
    when :left
      @direction = @directions[(@directions.index(@direction) - 1) % 4]
    end
  end

  def step(grid)
    # move the permission
    case @direction
    when :up
      @pos.y -= 1
    when :right
      @pos.x += 1
    when :down
      @pos.y += 1
    when :left
      @pos.x -= 1
    end

    # update direction
    c = grid[@pos.y][@pos.x]

    return if ['|', '-'].include?(c)

    case c
    when '/'
      case @direction
      when :up
        @direction = :right
      when :right
        @direction = :up
      when :down
        @direction = :left
      when :left
        @direction = :down
      end
    when '\\'
      case @direction
      when :up
        @direction = :left
      when :down
        @direction = :right
      when :left
        @direction = :up
      when :right
        @direction = :down
      end
    when '+'
      turn
      turn_next
    end
  end

  def turn_next
    @next_turn = if @next_turn == :left
                   :straight
                 elsif @next_turn == :straight
                   :right
                 else
                   :left
                 end
  end
end

def find_carts(grid)
  carts = []
  grid.each_with_index do |l, y|
    l.each_with_index do |c, x|
      case c
      when '>'
        pos = Position.new(x, y)
        carts << Cart.new(pos, :right)
        grid[y][x] = '-'
      when '<'
        pos = Position.new(x, y)
        carts << Cart.new(pos, :left)
        grid[y][x] = '-'
      when '^'
        pos = Position.new(x, y)
        carts << Cart.new(pos, :up)
        grid[y][x] = '|'
      when 'v'
        pos = Position.new(x, y)
        carts << Cart.new(pos, :down)
        x # => 68, 108, 18, 2,  143, 72
        y # => 16, 54,  59, 85, 104, 105
        grid[y][x] = '|'
      end
    end
  end
  carts
end

carts = find_carts(grid)

def tick(carts, grid)
  carts.sort_by! { |c| [c.pos.y, c.pos.x] }
  cart_locations = carts.map(&:pos)
  carts.each do |cart|
    cart_locations.delete(cart.pos)
    cart.step(grid)
    if cart_locations.include?(cart.pos)
      puts "boooom #{cart.pos.inspect}"
      return cart.pos
    end
    cart_locations.push(cart.pos)
  end
  nil
end

def first_crash(carts, grid)
  loop do
    crash = tick(carts, grid)

    return crash unless crash.nil?
  end
end

def last_cart_standing(carts, grid)
  loop do
    carts.sort_by! { |c| [c.pos.y, c.pos.x] }
    cart_locations = carts.map(&:pos)
    removed = Set.new([])
    carts.each do |cart|
      cart_locations.delete(cart.pos)
      cart.step(grid)
      if cart_locations.include?(cart.pos)
        removed.add(cart)
        removed.add(carts.select { |c| !removed.include?(c) && c.pos == cart.pos }.first)
        cart_locations.delete(cart.pos)
      end
      cart_locations.push(cart.pos)
    end
    carts = carts.select { |cart|
      true unless removed.include?(cart)
    }
    if carts.size == 1
    end
    return carts if carts.length == 1
    nil
  end
end

#p first_crash(carts, grid).inspect

p last_cart_standing(carts, grid).first.pos

# >> [121, 22]
