#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read("#{__dir__}/input.txt").chars

def length_until_distinct_chars(chars, distinct_length)
  chars.each_with_object({ chars: [], length: 0 }) do |char, carry|
    carry[:length] += 1
    carry[:chars].push char
    carry[:chars].shift if carry[:length] > distinct_length

    break carry[:length] if carry[:chars].uniq.length == distinct_length
  end
end

# part 1
puts "Part 1: #{length_until_distinct_chars(input, 4)}"

# part 2
puts "Part 2: #{length_until_distinct_chars(input, 14)}"
