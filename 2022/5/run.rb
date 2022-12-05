#!/usr/bin/env ruby
# frozen_string_literal: true

stacks_input, commands_input = File.read("#{__dir__}/input.txt").split("\n\n")

def parse_crates(line)
  crates = [line[1]]
  (1..8).each { |i| crates.push line[1 + 4 * i] }
  crates.map { |crate| crate == ' ' ? nil : crate }
end

stacks = lambda {
  stacks_input.split("\n")
              .map { |line| parse_crates(line) }
              .transpose
              .map(&:compact)
              .each(&:pop)
              .map(&:reverse)
}

def parse_command(line)
  values = line.scan(/move (\d+) from (\d) to (\d)/).shift&.map(&:to_i)
  { quantity: values[0], from: values[1], to: values[2] }
end

commands = commands_input.split("\n")
                         .map { |line| parse_command(line) }

def run_command_p1(stacks, command)
  stacks[command[:from] - 1].pop(command[:quantity])
                            .reverse
                            .each { |crate| stacks[command[:to] - 1].push(crate) }
  stacks
end

def run_command_p2(stacks, command)
  crates = stacks[command[:from] - 1].pop(command[:quantity])
  stacks[command[:to] - 1].concat(crates)
  stacks
end

# part 1
part1 = commands.reduce(stacks.call) { |carry, command| run_command_p1(carry, command) }.map(&:last).compact.join
puts "Part 1: #{part1}"

# part 2
part2 = commands.reduce(stacks.call) { |carry, command| run_command_p2(carry, command) }.map(&:last).compact.join
puts "Part 2: #{part2}"
