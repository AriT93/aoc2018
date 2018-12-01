#!/usr/bin/env ruby

# frozen_string_literal: true

require 'set'
require 'awesome_print'

cur_freq = 0

freqs = Set.new
freqs.add(cur_freq)
loop do
  File.open('./aoc201801.txt', 'r').each_line do |line|
    cur_freq += line.to_i
    if freqs.include?(cur_freq)
      puts cur_freq
      return 0
    end
    freqs.add(cur_freq)
  end
end

# >> 81204
