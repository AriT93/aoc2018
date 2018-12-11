# frozen_string_literal: true

require 'awesome_print'

logs = File.open('input.txt', 'r').lines.sort.slice_before do |l|
  l.include?('begin')
end

guards = Hash.new { |h, k| h[k] = [] }

logs.each do |log|
  id = log.shift.scan(/#(\d+)/).flatten.map(&:to_i)[0]

  log.each_slice(2) do |asleep, awake|
    h, m = asleep.scan(/(\d+):(\d+)/).flatten(1).map(&:to_i)
    start = h * 60 + m

    h, m = awake.scan(/(\d+):(\d+)/).flatten(1).map(&:to_i)
    stop = h * 60 + m
    # puts "#{start} - #{stop}"
    guards[id] << (start..stop)
  end
end

max_minutes = guards.map do |id, ranges|
  minute_count = Hash.new(0)

  ranges.each do |range|
    (range.min...range.max).each do |i|
      minute_count[i] += 1
    end
  end
  minute, count = minute_count.max_by { |_k, v| v }
  [id, count, minute]
end

id, _, minute = max_minutes.max_by do |_id, count, _minute|
  count
end

puts id * minute

# >> 89347
