class Game
  attr_accessor :board, :player_1, :player_2

  def initialize(board = Board.new, player_1 = Player.new('X'), player_2 = Player.new('O'))
    @board = board
    @player_1 = player_1
    @player_2 = player_2
    @current_player = @player_1
  end

  def start
    display_rules
    loop do
      @board.display
      take_turn
      break if game_over?

      swap_player
    end
  end

  def swap_player
    @current_player = if @current_player == @player_1
                        @player_2
                      else
                        @player_1
                      end
  end

  def display_rules
    puts <<-HEREDOC
    Welcome to Connect Four!

    Players will take turns dropping their game pieces into a column on the board.

    The goal is to be the first player to connect 4 consecutive pieces either horizontally,
    vertically, or diagonally. Be sure to block your opponent from getting there first!
    
    HEREDOC
  end

  def game_over?
    if @board.full?
      tie
    elsif @board.consecutive?
      winner
    end
  end

  def tie
    @board.display
    puts "Draw!"
    true
  end

  def winner
    @board.display
    puts "Player #{@current_player.marker} has won the game!"
    true
  end

  def take_turn
    loop do
      puts "Player #{@current_player.marker} choose a column from the board: "
      column = @current_player.ask_player
      if @board.available?(column)
        @board.update(column, @current_player.marker)
        break
      end
    end
  end

end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def ask_player
    position = gets.to_i
    return position if position.between?(1, 7)
  end

end

class Board
  attr_accessor :one, :two, :three, :four, :five, :six, :seven

  def initialize
    @one = []
    @two = []
    @three = []
    @four = []
    @five = []
    @six = []
    @seven = []
  end

  def display
    puts <<-HEREDOC

    1  | 2  | 3  | 4  | 5  | 6  | 7
    #{@one[5]}  | #{@two[5]}  |  #{@three[5]}  |  #{@four[5]}  |  #{@five[5]}  |  #{@six[5]}  |  #{@seven[5]}
    #{@one[4]}  | #{@two[4]}  |  #{@three[4]}  |  #{@four[4]}  |  #{@five[4]}  |  #{@six[4]}  |  #{@seven[4]}
    #{@one[3]}  | #{@two[3]}  |  #{@three[3]}  |  #{@four[3]}  |  #{@five[3]}  |  #{@six[3]}  |  #{@seven[3]}
    #{@one[2]}  | #{@two[2]}  |  #{@three[2]}  |  #{@four[2]}  |  #{@five[2]}  |  #{@six[2]}  |  #{@seven[2]}
    #{@one[1]}  | #{@two[1]}  |  #{@three[1]}  |  #{@four[1]}  |  #{@five[1]}  |  #{@six[1]}  |  #{@seven[1]}
    #{@one[0]}  | #{@two[0]}  |  #{@three[0]}  |  #{@four[0]}  |  #{@five[0]}  |  #{@six[0]}  |  #{@seven[0]}
    
    HEREDOC

  end

  def full?
    if @one.count == 6 &&
       @two.count == 6 &&
       @three.count == 6 &&
       @four.count == 6 &&
       @five.count == 6 &&
       @six.count == 6 &&
       @seven.count == 6

      true
    else
      false
    end
  end

  def available?(column)
    if column == 1 && @one.count < 6
      true
    elsif column == 2 && @two.count < 6
      true
    elsif column == 3 && @three.count < 6
      true
    elsif column == 4 && @four.count < 6
      true
    elsif column == 5 && @five.count < 6
      true
    elsif column == 6 && @six.count < 6
      true
    elsif column == 7 && @seven.count < 7
      true
    end
  end

  def update(column, marker)
    if column == 1
      one.push(marker)
    elsif column == 2
      two.push(marker)
    elsif column == 3
      three.push(marker)
    elsif column == 4
      four.push(marker)
    elsif column == 5
      five.push(marker)
    elsif column == 6
      six.push(marker)
    elsif column == 7
      seven.push(marker)
    end
  end

  def consecutive?   
    if horizontal?
      true
    elsif vertical?
      true
    elsif diagonal?
      true
    else
      false
    end
  end

  def horizontal?
    horizontal = []
    horizontal.push(@one, @two, @three, @four, @five, @six, @seven)
    horizontal_check(horizontal)
  end

  def horizontal_check(horizontal)
    trans = horizontal.safe_transpose

    trans.each_with_index do |row, index|
      p row[index]
        # if marker[index] == "X" && marker[index + 1] == "X" && marker[index + 2] == "X" && marker[index + 3] == "X"
        #   return true
        # else
        #   return false
        # end
    end
    false
      
  end

  def vertical?
    vertical = []
    vertical.push(@one, @two, @three, @four, @five, @six, @seven)
    vertical_check(vertical)
  end

  def vertical_check(vertical)
    vertical.each do |column|
      string = column.join()
      if string.include?('XXXX')
        return true
      elsif string.include?('OOOO')
        return true
      else
        return false
      end
    end
  end
  
  def diagonal?
    false
    # Keep false for now
  end

end

class Array
  def safe_transpose
    result = []
    max_size = self.max { |a,b| a.size <=> b.size }.size
    max_size.times do |i|
      result[i] = Array.new(self.first.size)
      self.each_with_index { |r,j| result[i][j] = r[i] }
    end
    result
  end
end


game = Game.new
game.start