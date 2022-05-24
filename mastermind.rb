require 'debug'

# Mastermind
module Mastermind
  def computer_choice(array)
    array.map.with_index do |_element, index|
      unless index > 3
        array[index] = ['red'.red, 'green'.green, 'blue'.blue, 'yellow'.yellow, 'cyan'.cyan, 'pink'.pink].sample
      end
    end
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

  def colorize(string)
    case string
    when 'Right color AND right slot'
      string.red
    when 'Right color BUT wrong slot'
      string.yellow
    else
      string.gray
    end
  end

  def pick_colors(array)
    array.map.with_index do |_color, index|
      unless index > 3
        puts "Pick color #{index + 1}"
        array[index] = convert_to_color(gets.downcase.chomp)
      end
    end
    invalid_color(array)
  end

  def invalid_color(array)
    puts "You picked [ #{array[0]} #{array[1]} #{array[2]} #{array[3]} ]"
    if !array.include?('Not a valid color')
      array
    else
      puts 'You picked an invalid color. Choose your colors again'
      pick_colors(array)
    end
  end

  def check_round(code_breaker, code_maker, hint_array)
    right_slot(code_breaker, code_maker, hint_array)
    right_color(code_breaker, code_maker, hint_array)
    shuffle_array(hint_array)
  end

  def right_slot(code_breaker, code_maker, hint_array)
    code_maker.map.with_index do |_, index|
      if code_breaker[index] == code_maker[index]
        code_maker[index] = nil
        code_breaker[index] = nil
        hint_array[index] = 'Right color AND right slot'
      end
    end
  end

  def right_color(code_breaker, code_maker, hint_array)
    code_breaker.map.with_index do |element, index|
      next if element.nil?

      if code_maker.index(element) # check if element is in the right color, but wrong spot
        code_maker[code_maker.index(element)] = nil # check for first element with specified color
        code_breaker[index] = nil
        hint_array[index] = 'Right color BUT wrong slot'
      else # If color doesn't exist in chooser's array
        wrong_color(index, code_breaker, code_maker, hint_array)
      end
    end
  end

  def wrong_color(index, code_breaker, _code_maker, hint_array)
    code_breaker[index] = nil
    hint_array[index] = 'Wrong color'
  end

  def play_game(code_breaker, code_maker, hint_array, round)
    puts "#{'Round'.white} #{round += 1}"
    code_maker1 = first_step(code_maker)
    check_round(code_breaker, code_maker1, hint_array)
    if hint_array.all? { |color| color == 'Right color AND right slot' } || round > 13
      hint_array.all? { |color| color == 'Right color AND right slot' } ? message('Congratulations! You win!') : message('Sorry. You lose')
    else
      play_game(pick_colors(array), code_maker, hint_array, round)
    end
  end

  def message(message)
    puts message
  end

  def push_array(array1, array2)
    array1.map do |color|
      array2.push(color)
    end
  end

  def first_step(array, array1 = [])
    push_array(array, array1)
    array1
  end

  def shuffle_array(array)
    array2 = []
    push_array(array, array2) # returns array2
    array3 = array2.shuffle
    puts "#{'Hint array'.red} : [#{colorize(array3[0])}, #{colorize(array3[1])}, #{colorize(array3[2])},
     #{colorize(array3[3])}]"
  end
end

# Board game
class Board
  attr_accessor :array, :hint_array, :round

  include Mastermind
  def initialize(array = [1, 2, 3, 4], hint_array = [1, 2, 3, 4])
    @array = array
    @hint_array = hint_array
    @round = round
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
p 'You are the codebreaker. '
p 'The PC is the codemaker.'
p 'You have 12 guesses to crack the code'
p 'A hint array will be displayed in no particular order'
p 'The color choices are :'
puts 'Red'.red
puts 'Yellow'.yellow
puts 'Green'.green
puts 'Blue'.blue
puts 'Pink'.pink
puts 'Cyan'.cyan
players_choice = player.pick_colors(player.array)

hint_array = player.hint_array

player.play_game(players_choice, computers_choice, hint_array, 0)




