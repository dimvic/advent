#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read("#{__dir__}/input.txt").split("\n")
            .map { |line| line.split(',') }
            .map do |line|
  line.map do |section|
    edges = section.split('-').map(&:to_i)
    ((edges[0]..edges[1]))
  end
end

def ranges_overlap?(a, b)
  b.begin <= a.end && a.begin <= b.end
end

# part 1
part1 = input.filter { |sections| sections[0].cover?(sections[1]) || sections[1].cover?(sections[0]) }
             .count
puts "Part 1: #{part1}"

# # part 2
part2 = input.filter { |sections| ranges_overlap?(sections[0], sections[1]) }
             .count
puts "Part 2: #{part2}"
