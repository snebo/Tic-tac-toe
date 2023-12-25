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
    #place scores here
    puts '=' * 35
    puts "#{line}#{space}#{p1.name}: #{p1.pl_score} VS #{p1.name}: #{p2.pl_score}#{space}#{line}"
    puts '=' * 35
    puts "\n"

    6.times do |i|
      if i.even?
        3.times do |j|
          # Replace with p symbols
          if p1.spots.include?(num)
            print "#{space}#{p1.sym}#{space}"
          elsif p2.spots.include?(num)
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
    self.draw_board(p1, p2)
    while not @game_end
      if turns < 9
        @turn ? self.ch_turn(p1) : self.ch_turn(p2)
        !@turn ? self.has_won(p1) : self.has_won(p2)
        #stop from drawing the board on game over
        @game_end ? nil : self.draw_board(p1, p2)

        @turn = not(@turn)
        turns += 1

      else
        @game_end = true
        puts 'There are no avaliable turns left... game over'
      end
    end
    puts "Do you want to play again? (y,n)"
    choice = gets.chomp
    until choice.downcase == 'y' || choice.downcase == 'n'
      puts "Do you want to play again? (y,n)"
      choice = gets.chomp
    end
    if choice.downcase == 'y'
      self.reset(p1, p2)
      play(p1, p2)
    end
  end

  def reset (p1, p2)
    @game_end = false
    @turn = true
    @avl_p = []

    p1.reset
    p2.reset
  end

  def ch_turn(p)
    print "#{p.name.capitalize} choose a number to play -> "
    choice = gets.chomp
    until Array(1..9).include?(choice.to_i) && !@avl_p.include?(choice.to_i)
      print "#{p.name.capitalize} enter a valid no -> "
      choice = gets.chomp
    end
    p.store_turn(choice.to_i)
    @avl_p.append(choice.to_i)
    # self.has_won(p)
  end

  def has_won(pl)
    win = false
    win_spots = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 5, 9], [3, 5, 8],
                 [1, 4, 7], [2, 5, 8], [3, 6, 9]]

    win_spots.each do |i|
      i.all? {|j| pl.spots.include?(j)} ? win = true : nil
      # pl.spots.sort.eql?(i) ? win = true : nil
    end
    if win
      puts "#{pl.name.capitalize} Won!..."
      pl.add_score
      @game_end = true
    end
  end
end

class Player
  @@players = 0
  attr_accessor :name, :sym, :pl_score

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

  def add_score
    @pl_score += 1
  end

  def reset
    @pl_cells = []
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
