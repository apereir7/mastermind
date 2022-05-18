# frozen_string_literal: true
require 'debug'

# Mastermind
module Mastermind
  def computer
    array = ['red'.red, 'green'.green, 'purple'.purple, 'yellow'.yellow, 'cyan'.cyan, 'pink'.pink].sample(4)
    puts "The computer's choice is [ #{array[0]} #{array[1]} #{array[2]} #{array[3]} ]"
  end

  def convert_to_color(string)
    case string
    when 'red', 'green'
      string == 'red' ? string.red : string.green
    when 'cyan', 'purple'
      string == 'cyan' ? string.cyan : string.purple
    when 'yellow', 'pink'
      string == 'yellow' ? string.yellow : string.pink
    else
      'Not a valid color'
    end
  end
end

# Board game
class Board
  attr_accessor :red, :green, :blue, :yelow,
                :orange, :purple, :white, :gray

  include Mastermind

  @@pick = ['hello']

  def initialize
    @@pick
  end

  def display_pick(array)
    puts 'You picked'
    puts "[ #{array[0]} #{array[1]} #{array[2]} #{array[3]} ]"
  end

  def pick
    puts 'Pick a color'
    @@pick[0] = convert_to_color(gets.chomp)
    puts 'Pick a color'
    @@pick[1] = convert_to_color(gets.chomp)
    puts 'Pick a color'
    @@pick[2] = convert_to_color(gets.chomp)
    puts 'Pick a color'
    @@pick[3] = convert_to_color(gets.chomp)
    display_pick(@@pick)
  end

   
  




  def class_variable
    puts @@pick 
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

  def purple
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

player = Board.new

player.computer
player.class_variable
