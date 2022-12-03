#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read("#{__dir__}/input.txt").split("\n")

PRIORITIES = [nil].concat(('a'..'z').to_a).concat(('A'..'Z').to_a)

def p1_split_compartments(line)
  [line[0, line.size / 2], line[line.size / 2..]]
end

def p1_compartment_common_items(compartments)
  compartments[0].chars & compartments[1].chars
end

def p2_common_chars(lines)
  lines[0].chars & lines[1].chars & lines[2].chars
end

# part 1
part1 = input.map { |line| p1_split_compartments(line) }
             .map { |line| p1_compartment_common_items(line) }
             .flatten
             .map { |char| PRIORITIES.index(char) }
             .sum
puts "Part 1: #{part1}"

# part 2
part2 = input.each_slice(3).to_a
             .map { |lines| p2_common_chars(lines) }
             .flatten
             .map { |char| PRIORITIES.index(char) }
             .sum
puts "Part 2: #{part2}"
