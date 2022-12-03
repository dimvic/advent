#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read("#{__dir__}/input.txt").split("\n").map { |line| line.split(' ') }

ABC_RPS = {
  'A' => :rock,
  'B' => :paper,
  'C' => :scissors
}.freeze

XYZ_RPS = {
  'X' => :rock,
  'Y' => :paper,
  'Z' => :scissors
}.freeze

XYZ_WDL = {
  'X' => :lose,
  'Y' => :draw,
  'Z' => :win
}.freeze

POINTS = {
  rock: 1,
  paper: 2,
  scissors: 3,
  win: 6,
  draw: 3,
  lose: 0
}.freeze

WINS = {
  rock: :scissors,
  paper: :rock,
  scissors: :paper
}.freeze

def result(op_rps, my_rps)
  case op_rps
  when my_rps
    :draw
  when WINS[my_rps]
    :win
  else
    :lose
  end
end

def count_points(rps, result)
  POINTS[rps] + POINTS[result]
end

def p1_round_score(abc, xyz)
  op_rps = ABC_RPS[abc]
  my_rps = XYZ_RPS[xyz]
  result = result(op_rps, my_rps)

  count_points(my_rps, result)
end

def p2_round_score(abc, xyz)
  op_rps = ABC_RPS[abc]
  result = XYZ_WDL[xyz]
  my_rps =
    case result
    when :win
      WINS.key(op_rps)
    when :draw
      op_rps
    else
      WINS[op_rps]
    end

  count_points(my_rps, result)
end

# part 1
part1 = input.map { |round| p1_round_score(*round) }.sum
puts "Part 1: #{part1}"

# part 2
part2 = input.map { |round| p2_round_score(*round) }.sum
puts "Part 2: #{part2}"
