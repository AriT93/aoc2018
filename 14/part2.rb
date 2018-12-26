# frozen_string_literal: true

recipies = [3, 7]
last = []
elf1 = 0
elf2 = 1
target = '607331'.chars.map(&:to_i)

loop do
  sum = recipies[elf1] + recipies[elf2]

  sum.to_s.chars.map(&:to_i).each do |a|
    recipies << a
    last << a

    if last.length == target.length && last == target
      p recipies.length - target.length
      exit
    elsif last.length >= target.length
      last.shift
    end
  end

  elf1 += 1 + recipies[elf1]
  elf2 += 1 + recipies[elf2]

  elf1 = elf1 % recipies.length
  elf2 = elf2 % recipies.length
end

#p recipies[-10..-1].join

# >> 20258123
