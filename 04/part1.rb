# frozen_string_literal: true

require 'awesome_print'

logs = File.open('unsorted_test.txt', 'r').lines.sort.slice_before do |l|
  l.include?('begin')
end

guards = Hash.new {  |h, k| h[k] = []}

logs.each do |log|
  id = log.shift.scan(/#(\d+)/).flatten.map(&:to_i)
  #  puts id

  log.each_slice(2) do |asleep, awake|
    h, m = asleep.scan(/(\d+):(\d+)/).flatten(1).map(&:to_i)
    start = h * 60 + m

    h, m = awake.scan(/(\d+):(\d+)/).flatten(1).map(&:to_i)
    stop = h * 60 + m
    # puts "#{start} - #{stop}"
    guards[id] << (start..stop)
  end
end

id, _ = guards.max_by do |_ac, sleep|
  sleep.map(&:size).inject(:+)
end

minutes_counts = Hash.new(0)

guards[id].each do |range|
  range.min...range.max do |i|
    minutes_counts[i] += 1
  end
end
minute, _ = minutes_counts.max_by { |_minute, count| count }

ap minute - 1

# >> 24
