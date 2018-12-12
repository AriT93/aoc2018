require 'awesome_print'

def reactor(poly_string)
  loop do
    prev_len = poly_string.length
    poly_string.gsub!(/([A-z])\1+/i) do |match|
      chr = match[0]
      pattern = chr.downcase + chr.upcase
      match
        .gsub(pattern, '')
        .gsub(pattern.reverse, '')
    end
    break if poly_string.length == prev_len
  end
  poly_string.length
end

test_string = File.read('input.txt').chomp

scores = {}

test_string.downcase.split('').uniq.each { |l| scores[l] = 0 }
scores.each do |k, _v|
  scores[k] = reactor(test_string.gsub(/#{k}/i, ''))
end

ap scores.min_by { |_k, v| v }.first.last

# >> 4052
