class Game
  def initialize
    @game_end = false
    @turn = true
    @avl_p = []
  end

  def draw_board(p1,p2)
    system('clear') || system('cls') # clear screen on each draw
    space = '  '
    line = '-----'
    num = 1
    6.times do |i|
      if i.even?
        3.times do |j|
          # Replace with p symbols
          if p1.spots.include?(num.to_s)
            print "#{space}#{p1.sym}#{space}"
          elsif p2.spots.include?(num.to_s)
            print "#{space}#{p2.sym}#{space}"
          else
            print "#{space}#{num}#{space}"
          end
          num += 1
          j < 2 ? print('|') : puts('')
        end
      else
        puts "#{line}|#{line}|#{line}"
      end
    end
  end

  def play(p1, p2)
    turns = 0
    self.draw_board(p1,p2)
    while not @game_end
      if turns < 9
        @turn ? self.ch_turn(p1) : self.ch_turn(p2)
        self.draw_board(p1,p2)
        turns += 1
      else
        @game_end = true
      end
    end
    puts 'There are no avaliable turns left... game over'
  end

  def ch_turn(p)
    print "#{p.name.capitalize} choose a number to play -> "
    choice = gets.chomp
    until Array(1..9).include?(choice.to_i) && !@avl_p.include?(choice.to_i)
      print "#{p.name.capitalize} enter a valid no -> "
      choice = gets.chomp
    end
    p.store_turn(choice)
    @avl_p.append(choice.to_i)
    @turn = not(@turn)
  end
end

class Player
  @@players = 0
  attr_accessor :name, :sym

  def initialize(name, sym)
    @@players += 1
    @name = name
    @sym = sym
    @pl_no = @@players
    @pl_score = 0
    @pl_cells = []
  end

  def store_turn(spot)
    @pl_cells.push(spot)
  end
  
  def spots
    @pl_cells
  end

  def show_info
    puts "Player #{@pl_no}: #{@name}\nSymbol: #{@sym}\nScore: #{@pl_score}"
  end
end

play1 = Player.new('Thor', 'X')
play2 = Player.new('Loki', 'O')
test = Game.new
test.play(play1, play2)
