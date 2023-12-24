# frozen_string_literal = true
# TicTacToe: contains game files
SPACE = '=' * 50

class TicTacToe
  def initialize(pl1, pl2)
    @p1 = pl1
    @p2 = pl2
    @cell = Hash.new{ 0 }
    @play_game = true #change this back to false
    @turn = false # false for pl1 and true for pl2
  end

  def greeting
    2.times { puts SPACE }
    puts 'Welcome to the GUI Tic Tac Toe by @Stefano'
    puts SPACE

    while not @play_game
    puts 'Play game(y,n)?'
    p_res = gets.chomp
    p_res == "y" || p_res == "n" ? (p_res == "y"? @play_game = true : return) 
                                  : puts('invalid input')
    end
    self.play
  end

  def play
    while @play_game
      self.draw_board(@p1,@p2)
      @turn ? self.ch_turn(@p1) : self.ch_turn(@p2)
    end
  end

  private

  def ch_turn(pl)
    print ("#{pl.name} choose an number to play -> ")
    choice = gets.chomp
    # add a check for valid entry
    pl.store_turns(choice)
    @turn = not(@turn)
  end

  def draw_board(p1_arr =[], p2_arr = [])
    9.times { |i| @cell["cell#{i + 1}"] = i + 1 }
    n_gap = ' ' * 2
    gap = '-----'
    num = 1
    system("clear") || system("cls")
 
    puts SPACE
    puts "=============== #{@p1.name}__vs__#{@p2.name} ============\n\n"
    
    # draw the board
    6.times do |i|
      if i.even?
        3.times do |i|
          if p1_arr.spots.include?(num.to_s)
            # change X to #{p1_arr.sym}
            print "#{n_gap}X#{n_gap}"
          elsif p2_arr.spots.include?(num.to_s)
            print "#{n_gap}O#{n_gap}"
          else
            print "#{n_gap}#{num}#{n_gap}"
          end
          num += 1
          i < 2 ? print('|') : puts('')
        end
      else
        print "#{gap}|#{gap}|#{gap}\n"
      end
    end
    puts "\n"
  end
  num = 1
end

# Player: collect and manage player information
class Player
  attr_accessor :name, :sym

  @@players = 0

  def initialize(name)
    @name = name
    @sym
    @no # player number
    @ply_score = 0
    @spots = []
    @@players += 1
  end

  def set_info
    self.player_info
  end

  def show_info
    p "Player: #{@no}\nName: #{@name}\nSymbol: #{@sym}\n Score: #{@ply_score}"
  end

  def add_score
    self.ply_score += 1
  end

  def store_turns(cell)
    @spots.push(cell)
    puts @spots
  end

  def spots
    @spots
  end

  private

  def player_info
    puts(SPACE)
    @no = @@players
    print "Player #{@@players} \nEnter name -> "
    self.name = gets.chomp
    print 'Enter you symbol -> '
    self.sym = gets.chomp
    puts(SPACE)
  end
end

# set up players and their symbol
# ply1 = Player.new
# ply1.set_info

# ply2 = Player.new
# ply2.set_info

# # initialize game
# ttt = TicTacToe.new(ply1, ply2)
# ttt.greeting

p1 = Player.new("Thor")
p2 = Player.new("Loki")
ttt = TicTacToe.new(p1,p2)
ttt.play
