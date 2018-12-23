# frozen_string_literal: false


h = Hash.new { |h,k| h[k] = [] }
File.open('input.txt', 'r').each_line do |line|
  req, step = line.chomp.scan(/\s(\w)\s/).flatten
  h[step] << req
end


todo = ('A'..(h.keys.max)).to_a
done = []

while todo.any?
  todo.each do |step|
    next if h[step].any?
    todo.delete(step)
    done << step

    h.each do |_, k|
      k.delete(step)
    end
    break
  end
end

p done.join

# >> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
# >> "OKBNLPHCSVWAIRDGUZEFMXYTJQ"
