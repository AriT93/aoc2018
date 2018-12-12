require 'awesome_print'

test_string = File.read('input.txt').chomp

loop do
  prev_len = test_string.length

  test_string.gsub!(/([A-z])\1+/i) do |match|

    chr = match[0]
    pattern = chr.downcase + chr.upcase

    match
      .gsub(pattern, '')
      .gsub(pattern.reverse, '')
  end
  break if test_string.length == prev_len
end

ap test_string.length

# >> 9238
