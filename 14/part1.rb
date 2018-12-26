# frozen_string_literal: true

recipies = [3, 7]

elf1 = 0
elf2 = 1
threshold = 607331

while recipies.length < threshold + 10
  sum = recipies[elf1] + recipies[elf2]
  recipies.concat(sum.to_s.chars.map(&:to_i))
  elf1 += 1 + recipies[elf1]
  elf2 += 1 + recipies[elf2]

  elf1 = elf1 % recipies.length
  elf2 = elf2 % recipies.length
end

p recipies[-10..-1].join

# >> "5158916779"
