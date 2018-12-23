# frozen_string_literal: false

h = Hash.new { |l, k| l[k] = [] }
File.open('input.txt', 'r').each_line do |line|
  req, step = line.chomp.scan(/\s(\w)\s/).flatten
  h[step] << req
end

todo = ('A'..(h.keys.max)).to_a
num_workers = 5
workers = {}
time = -1
while todo.any? || workers.any?
  time += 1

  workers.keys.each do |step|
    workers[step] -= 1
    next if workers[step].positive?

    h.each do |_, value|
      value.delete(step)
    end
    workers.delete(step)
  end

  next unless workers.count < num_workers

  todo.each do |step|
    next if h[step].any?

    'a'.tr('a', 'b')
    todo.delete(step)
    job_length = step.ord - 'A'.ord + 1 + 60
    workers[step] = job_length
  end
end

puts time

# >> 982
