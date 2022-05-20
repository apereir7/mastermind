require 'debug'

# Mastermind
module Mastermind
  def computer_choice(array)
    array.each_with_index do |element, index|
      unless index > 3
        array[element] = ['red'.red, 'green'.green, 'blue'.blue, 'yellow'.yellow, 'cyan'.cyan, 'pink'.pink].sample
      end
    end
    puts "The computer's choice is [ #{array[0]} #{array[1]} #{array[2]} #{array[3]} ]"
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
    array.each_with_index do |color, index|
      unless index > 3
        puts 'Pick a color'
        array[color] = convert_to_color(gets.chomp)
      end
    end
    puts "You picked [ #{array[0]} #{array[1]} #{array[2]} #{array[3]} ]"
    array
  end

  def display_choice(array)
    puts "[ #{array[0]} #{array[1]} #{array[2]} #{array[3]} ]"
  end

  def play(array1, array2)
    array1.map.with_index do |element, index|
      if element == array2[index] # check if element in the right spot & place
        array2[index] = nil
        'Right color and right slot'
      elsif array2.index(element) # check if element is in the right color, but wrong spot
        array2[array2.index(element)] = nil
        'Right color BUT wrong slot'
      else # If color doesn't exist in chooser's array
        array2[index] = nil
        'Wrong color'.gray
      end
    end
  end.sample(4)
end

# Board game
class Board
  attr_accessor 

  include Mastermind

  @@array = [0, 1, 2, 3]
  @@computer = [0, 1, 2, 3]

  def array
    @@array
  end

  def computer
    @@computer
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

player.computer_choice(player.computer)

player.players_choice(player.array)

player.play(player.array, player.computer)

