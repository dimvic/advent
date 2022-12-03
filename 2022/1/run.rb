#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read("#{__dir__}/input.txt").lines

elf_calories = {}
i = 0
input.each do |num|
  num = num.to_i

  if num.positive?
    elf_calories[i] ||= 0
    elf_calories[i] += num
  else
    i += 1
  end
end

# part 1
part1 = elf_calories.values.max
puts "Part 1: #{part1}"

# part 2
part2 = elf_calories.values.sort.slice(-3, 3).sum
puts "Part 2: #{part2}"
