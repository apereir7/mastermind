require 'debug'

# Mastermind
module Mastermind
  def computer_choice(array)
    array.map.with_index do |_element, index|
      unless index > 3
        array[index] = ['red'.red, 'green'.green, 'blue'.blue, 'yellow'.yellow, 'cyan'.cyan, 'pink'.pink].sample
      end
    end
    puts "Computer's choice is [ #{array[0]} #{array[1]} #{array[2]} #{array[3]} ]"
    array
  end

  def convert_to_color(string)
    case string
    when 'red', 'green'
      string == 'red' ? string.red : string.green
    when 'cyan', 'blue'
      string == 'cyan' ? string.cyan : string.blue
    when 'yellow', 'pink'
      string == 'yellow' ? string.yellow : string.pink
    else
      'Not a valid color'
    end
  end

  def players_choice(array)
    array.map.with_index do |_color, index|
      unless index > 3
        puts 'Pick a color'
        array[index] = convert_to_color(gets.chomp)
      end
    end
    puts "You picked [ #{array[0]} #{array[1]} #{array[2]} #{array[3]} ]"
    array
  end

  def display_choice(array)
    puts "[ #{array[0]} #{array[1]} #{array[2]} #{array[3]} ]"
  end

  def play(code_breaker, code_maker, hint_array)
    code_maker1 = code_maker
    one_2_one(code_breaker, code_maker1, hint_array)
    puts "hellow"
  end

  def one_2_one(code_breaker, code_maker, hint_array)
    code_maker.each_with_index do |_, index|
      if code_breaker[index] == code_maker[index]
        code_maker[index] = nil
        hint_array.push('Right color AND right slot')
      end
    end
  end
end

# Board game
class Board
  attr_accessor :array

  include Mastermind
  def initialize(array = [1, 2, 3, 4])
    @array = array
  end

  def hint_array
    @@hint_array
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

player = Board.new
computer = Board.new

computers_choice = computer.computer_choice(computer.array)

players_choice = player.players_choice(player.array)

#player.play(player.array, player.computer, player.hint_array)

puts "hello"