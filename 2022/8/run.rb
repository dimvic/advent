#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read("#{__dir__}/input.txt").split("\n").map(&:chars).map { |line| line.map(&:to_i) }

def discover_trees(input, x_index, y_index)
  {
    top: input.slice(0, y_index).map { |line| line[x_index] }.reverse,
    right: input[y_index].slice((x_index + 1)..),
    bottom: input.slice((y_index + 1)..).map { |line| line[x_index] },
    left: input[y_index].slice(0, x_index).reverse
  }
end

def tallest?(height, other_heights)
  other_heights.all? { |other_height| height > other_height }
end

tree_visibilities = input.map.with_index do |line, y|
  line.map.with_index do |height, x|
    discover_trees(input, x, y)
      .values
      .map { |trees| tallest?(height, trees) }
      .any?
  end
end

def visible_trees(height, other_heights)
  other_heights.inject(0) do |visible_trees, other_height|
    visible_trees += 1

    break visible_trees if other_height >= height

    visible_trees
  end
end

tree_scenic_scores = input.map.with_index do |line, y|
  line.map.with_index do |height, x|
    discover_trees(input, x, y)
      .values
      .map { |trees| visible_trees(height, trees) }
      .reduce(&:*)
  end
end

# part 1
part1 = tree_visibilities.flatten.select { |v| v == true }.count
puts "Part 1: #{part1}"

# part 2
part2 = tree_scenic_scores.flatten.max
puts "Part 2: #{part2}"
