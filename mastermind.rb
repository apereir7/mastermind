# frozen_string_literal: true
require 'debug'

# Mastermind
module Mastermind
  def computer
    array = ['red'.red, 'green'.green, 'blue'.blue, 'yellow'.yellow, 'cyan'.cyan, 'pink'.pink].sample(4)
    puts "computer choice is #{array[0]} #{array[1]} #{array[2]} #{array[3]}"
  end
end

# Board game
class Board
  attr_accessor :red, :green, :blue, :yelow,
                :orange, :purple, :white, :gray

  include Mastermind

  def initialize(white)
    @white = white
  end
end

# change color of string
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def gray
    colorize(90)
  end

  def red
    colorize(91)
  end

  def green
    colorize(92)
  end

  def yellow
    colorize(93)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(95)
  end

  def cyan
    colorize(96)
  end

  def white
    colorize(97)
  end
end

binding.break

player = Board.
Board.computer
