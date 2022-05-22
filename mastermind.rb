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

  def play(code_breaker, code_maker, hint_array)
    code_breaker.map.with_index do |element, index|
      if code_breaker[index] == code_maker[index] # check if element in the right spot & place
        code_maker[index] = nil
        hint_array.push('Right color AND right slot')
      elsif code_maker.index(element) # check if element is in the right color, but wrong spot
        code_maker[code_maker.index(element)] = nil # check for first element with specified color
        hint_array.push('Right color BUT wrong slot')
      else # If color doesn't exist in chooser's array
        code_maker[index] = nil
        hint_array.push('Wrong color')
      end
    end
  end

  def color_slot_change(code_breaker, code_maker, index, element, hint_array)
    if code_breaker[index] == code_maker[index]
      code_maker[index] = nil
      hint_array.push('Right color AND right slot')
    elsif code_maker.index(element)
      code_maker[code_maker.index(element)] = nil # check for first element with specified color
      hint_array.push('Right color BUT wrong slot')
    else
      code_maker[index] = nil
      hint_array.push('Wrong color')
    end
  end
end

# Board game
class Board
  attr_accessor 

  include Mastermind

  @@array = [0, 1, 2, 3]
  @@computer = [0, 1, 2, 3]
  @@hint_array = []

  def array
    @@array
  end

  def computer
    @@computer
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

player.computer_choice(player.computer)

player.players_choice(player.array)

player.play(player.array, player.computer, player.hint_array)

puts 'hello'
