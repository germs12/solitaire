require 'colorize'
require 'pry'

class Card
  attr_accessor :output
  def initialize(suite, value)
    @suite = suite
    @value = value
    @output = []
  end

  def draw
    @output = []
    color = ['Heart', 'Diamond'].include?(@suite) ? 'red' : 'white'
    @output.push " -----------   ".send(color)
    tmp = "/  #{@suite}"
    (9 - @suite.size).times do  
      tmp = tmp + ' '
    end
    tmp = tmp + "\\  "
    @output.push tmp.send(color)
    @output.push "|           |  ".send(color)
    @output.push "|           |  ".send(color)
    tmp = "\\        #{@value}"
    (3 - @value.size).times do 
      tmp = tmp + ' '
    end
    tmp = tmp + '/  '
    @output.push tmp.send(color)
    @output.push " -----------   ".send(color)
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
    @display = Display
    @deck.shuffle
    @cols = {1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => []}
    @top = {'Spade' => {}, 'Heart' => {}, 'Diamond' => {}, 'Club' => {}}
  end

  def show
    @deck.show
  end

  def play
    deal()
  end

  def deal
    cur = 1
    i = 1
    28.times do 
      tmp_card = @deck.draw
      tmp_card.draw
      @cols[cur] << tmp_card
      cur += 1
      if cur > 7
        if i == 6
          cur = 7
        else
          cur = 7 - i
        end
        puts cur
        i += 1
      end
    end
    @display.show(@cols)
   end
end

class Display

  def self.show(columns)
    tmps = {1 => '', 2 => '', 3 => '', 4 => '', 5 => '', 6 => '', 7 => '', 8 => '', 9 => '', 10 => '', 11 => '', 12 => ''}
    columns.each do |a|
      tmp_cards = a.last
      if true
        tmp_col = tmp_cards.last.output
        tmps.each do |k, v|
          if k < tmp_cards.size 
            tmps[k] = tmps[k] + ' ***********   '
            next
          end 
          z = tmp_col.shift
          if z
            tmps[k] = tmps[k] + z
          else
            tmps[k] = tmps[k] + '               '
          end
        end
      end
    end

    tmps.each_value do |value|
      puts value
    end

    binding.pry
    nil


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
      game.deal() 
    else
      puts "nothing"
    end
  end
end


Menu.display
Menu.get_input