require 'colorize'
require 'pry'

class Card
  attr_accessor :output
  def initialize(suite, value)
    @suite = suite
    @value = value
    @output = {}
  end

  def draw
    @output = {1 => '', 2 => '', 3 => '', 4 => '', 5 => '', 6 => ''}
    color = ['Heart', 'Diamond'].include?(@suite) ? 'red' : 'white'
    @output[1] = " -----------   ".send(color)
    tmp = "/  #{@suite}"
    (9 - @suite.size).times do  
      tmp = tmp + ' '
    end
    tmp = tmp + "\\  "
    @output[2] = tmp.send(color)
    @output[3] = "|           |  ".send(color)
    @output[4] = "|           |  ".send(color)
    tmp = "\\        #{@value}"
    (3 - @value.size).times do 
      tmp = tmp + ' '
    end
    tmp = tmp + '/  '
    @output[5] = tmp.send(color)
    @output[6] = " -----------   ".send(color)
    nil
  end

  def show
    draw()
    @output.each_value do |value|
      puts value
    end
    nil
  end

  def to_s
    print "#{@value} #{@suite}"
  end
end

class Deck

  def initialize
    @cards = []
    ['Spade', 'Heart', 'Diamond', 'Club'].each do |suite|
      ['K', 'Q', 'J', '10', '9', '8', '7', '6', '5', '4', '3', '2', 'A'].each do |num|
        @cards.push(Card.new(suite, num))
      end
    end
    @dealt = []

  end

  def draw
    tmp = @cards.pop
    @dealt.push(tmp)
    tmp
  end

  def show
    puts "Here are your cards..."
    @cards.each do |card|
      system "clear"
      puts card.show
      sleep(0.25)
    end
  end

  def shuffle
    @cards.shuffle!
  end

end

class Solitaire
  def initialize(name)
    @name = name
    @deck = Deck.new
    @display = Display.new
    @deck.shuffle
    @cols = {1 => {}, 2 => {}, 3 => {}, 4 => {}, 5 => {}, 6 => {}, 7 => {}}
    @top = {'Spade' => {}, 'Heart' => {}, 'Diamond' => {}, 'Club' => {}}
  end

  def show
    @deck.show
  end

  def play
    tmps = {1 => '', 2 => '', 3 => '', 4 => '', 5 => '', 6 => ''}
    4.times do 
      a = @deck.draw
      a.draw
      tmps.update(a.output){|k, v1, v2| v1 + v2}
    end

    tmps.each_value do |value|
      puts value
    end
    nil
  end
end

class Display

  def show
    
  end
end

class Menu
  def self.display
    system "clear"
    puts "Welcome to Solitaire"
    puts "--------------------"
    puts ""
    puts "Please Select From The Following Options"
    puts "1 - New Game"
    puts "2 - Quit"
    puts ""
    print ": "
  end

  def self.get_input
    tmp = gets.chomp
    if tmp.eql?('1')
      game = Solitaire.new('James')
      game.play()
    else
      puts "nothing"
    end
  end
end


Menu.display
Menu.get_input