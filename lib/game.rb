# frozen_string_literal: true

class Game
  attr_accessor :board, :player_one, :player_two

  def initialize(board = Board.new, player_one = Player.new('X'), player_two = Player.new('O'))
    @board = board
    @player_one = player_one
    @player_two = player_two
    @current_player = @player_one
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
    @current_player = if @current_player == @player_one
                        @player_two
                      else
                        @player_one
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
      true
    elsif @board.consecutive?
      winner
      true
    end
  end

  def tie
    @board.display
    puts "Draw!"
  end

  def winner
    @board.display
    puts "Player #{@current_player.marker} has won the game!"
  end

  def take_turn
    loop do
      puts "Player #{@current_player.marker} choose a column from the board: "
      position = @current_player.ask_player
      if position.between?(1, 7) && @board.available?(position)
        @board.update(position, @current_player.marker)
        break
      end
    end
  end
end
