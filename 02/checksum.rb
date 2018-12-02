# frozen_string_literal: true

checkdig = Hash.new(0)
def hash_chars(ary)
  ary.each_with_object(Hash.new(0)) { |e, h| h[e] += 1; h }.select { |_k, v| v > 1 }
end

File.open('./input.txt', 'r').each_line do |line|
  h = hash_chars(line.split(''))
  next if h.empty?

  h.values.uniq.each { |c| checkdig[c] += 1 }
end


puts checkdig[2] * checkdig[3]

# >> 5166
