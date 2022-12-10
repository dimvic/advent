#!/usr/bin/env ruby
# frozen_string_literal: true

input = File.read("#{__dir__}/input.txt").split("\n")

# device filesystem
class Filesystem
  attr_accessor :filesystem, :directory_sizes

  def initialize(input)
    @filesystem = { '/' => {} }
    @directory_sizes = {}

    input.inject([]) { |cwd, line| process_line(line, cwd) }
  end

  def process_line(line, cwd)
    case line
    when '$ cd /'
      cwd = ['/']
    when '$ cd ..'
      cwd.pop
    when /^\$ cd/
      cwd << line[5..]
    when /^dir /
      name = line[4..]
      add_directory(cwd, name)
    when /^\d+/
      name = line[/\S+$/]
      size = line[/^\d+/].to_i
      add_file(cwd, name, size)
    end

    cwd
  end

  def add_directory(path, name)
    add_node(path, name, {})
  end

  def add_file(path, name, size)
    add_node(path, name, size)
  end

  def add_node(path, name, value)
    current_dir = path.inject(filesystem) { |tree, next_dir| tree[next_dir] }
    current_dir[name] = value
  end

  def part1
    directory_size(filesystem['/'], nil)
    directory_sizes.values.inject(0) do |carry, size|
      next carry if size > 100_000

      carry + size
    end
  end

  def directory_size(starting_node, path)
    size_files = 0
    size_dirs = 0

    starting_node.each do |node_name, node_value|
      if node_value.is_a?(Numeric)
        size_files += node_value
      else
        size_dirs += directory_size(node_value, "#{path}/#{node_name}")
      end
    end

    directory_sizes[path || '/'] = size_files + size_dirs
  end

  def part2
    needed_space = 30_000_000 - (70_000_000 - directory_sizes['/'])
    directory_sizes_sorted = directory_sizes.values.sort
    directory_sizes_sorted.find { |size| size >= needed_space }
  end
end

filesystem = Filesystem.new(input)

# part 1
puts "Part 1: #{filesystem.part1}"

# part 2
puts "Part 2: #{filesystem.part2}"
