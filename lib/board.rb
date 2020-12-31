# frozen_string_literal: true

class Board
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
    #{@one[5]}  |  #{@two[5]}  |  #{@three[5]}  |  #{@four[5]}  |  #{@five[5]}  |  #{@six[5]}  |  #{@seven[5]}
    #{@one[4]}  |  #{@two[4]}  |  #{@three[4]}  |  #{@four[4]}  |  #{@five[4]}  |  #{@six[4]}  |  #{@seven[4]}
    #{@one[3]}  |  #{@two[3]}  |  #{@three[3]}  |  #{@four[3]}  |  #{@five[3]}  |  #{@six[3]}  |  #{@seven[3]}
    #{@one[2]}  |  #{@two[2]}  |  #{@three[2]}  |  #{@four[2]}  |  #{@five[2]}  |  #{@six[2]}  |  #{@seven[2]}
    #{@one[1]}  |  #{@two[1]}  |  #{@three[1]}  |  #{@four[1]}  |  #{@five[1]}  |  #{@six[1]}  |  #{@seven[1]}
    #{@one[0]}  |  #{@two[0]}  |  #{@three[0]}  |  #{@four[0]}  |  #{@five[0]}  |  #{@six[0]}  |  #{@seven[0]}
    
    HEREDOC

  end

  def full?
    grid = make_grid
    grid.all? { |col| col.count == 6 }
  end

  def make_grid
    grid = []
    grid.push(@one, @two, @three, @four, @five, @six, @seven)
  end

  def available?(position)
    column = convert_to_column(position)
    column.count < 6
  end

  def convert_to_column(position)
    numbers_to_name = {
      7 => 'seven',
      6 => 'six',
      5 => 'five',
      4 => 'four',
      3 => 'three',
      2 => 'two',
      1 => 'one'
    }
    instance_variable_get("@#{numbers_to_name[position]}")
  end

  def update(position, marker)
    column = convert_to_column(position)
    column.push(marker)
  end

  def consecutive?
    columns = make_grid
    rows = make_filled_rows(columns)
    forw_diagonals = make_forward_diagonals(rows)
    back_diagonals = make_backwards_diagonals(rows)
    true if four_in_row?(columns) || four_in_row?(rows) || four_in_row?(forw_diagonals) || four_in_row?(back_diagonals)
  end

  def make_filled_rows(columns)
    filled_columns = Marshal.load(Marshal.dump(columns))
    filled_columns.each do |column|
      column.push('*') until column.count == 6
    end
    filled_columns.transpose
  end

  def make_forward_diagonals(grid)
    (0..2).map do |i|
      (0..5 - i).map { |j| grid[i + j][j] }
    end.concat((1..3).map do |j|
      (0..6 - j).map { |i| grid[i][j + i] }
    end)
  end

  def make_backwards_diagonals(grid)
    (0..2).map do |i|
      (0..5 - i).map { |j| grid[i + j][6 - j] }
    end.concat((1..3).map do |j|
      (0..6 - j).map { |i| grid[i][6 - j - i] }
    end)
  end

  def four_in_row?(arrays)
    arrays.each do |line|
      a = line.each_cons(4).find { |pattern| pattern.uniq.size == 1 && pattern.first != '*' }
      return true unless a.nil?
    end
    false
  end
end
