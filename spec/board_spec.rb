#spec/board_spec.rb
require './lib/board'

describe Board do

  describe '#display' do
    # Query sent to self, puts message, don't test
  end

  describe '#full?' do
    # Query incoming from Game object, test here
    context 'when all columns have a count of 6' do
      it 'returns true' do
        board = Board.new
        grid = [
          ['X', 'O', 'X', 'O', 'X', 'O'],
          ['O', 'X', 'O', 'X', 'O', 'X'],
          ['X', 'O', 'X', 'O', 'X', 'O'],
          ['X', 'O', 'X', 'O', 'X', 'O'],
          ['O', 'X', 'O', 'X', 'O', 'X'],
          ['O', 'X', 'O', 'X', 'O', 'X'],
          ['X', 'O', 'X', 'O', 'X', 'O']
        ]
        allow(board).to receive(:make_grid).and_return(grid)
        expect(board.full?).to be true
      end
    end

    context 'when one or more columns do not have a count of 6' do
      it 'returns false' do
        board = Board.new
        grid = [
          ['X', 'O', 'X', 'O'],
          ['O', 'X', 'O', 'X', 'O'],
          ['X', 'O'],
          ['X', 'O', 'X', 'O', 'X'],
          ['O'],
          ['O', 'X', 'O', 'X', 'O', 'X'],
          ['X', 'O', 'X', 'O']
        ]
        allow(board).to receive(:make_grid).and_return(grid)
        expect(board.full?).to be false
      end
    end
  end

  describe '#make_grid' do
    # Query sent to self?
    # Should this be a Private method?
  end

  describe '#available?' do
    # Incoming query from Game object

    context 'when player chose an open column' do

      it 'returns true' do
        board = Board.new
        column = board.instance_variable_set(:@three, ['X', 'O', 'X'])
        allow(board).to receive(:convert_to_column).and_return(column)
        expect(board.available?(3)).to eq(true)
      end
    end

    context 'when player chose a full column' do

      it 'returns false' do
        board = Board.new
        column = board.instance_variable_set(:@five, ['X', 'O', 'X', 'X', 'X', 'O'])
        allow(board).to receive(:convert_to_column).and_return(column)
        expect(board.available?(5)).to eq(false)
      end
    end
  end

  describe '#convert_to_column' do
    # Query sent to self?
    # Should this be a Private method?
  end
  
  describe '#update' do
    # Incoming command message from Game object

    subject(:game_board) { described_class.new }

    context 'when an available position is picked' do

      it 'updates column with player marker' do
        column = game_board.instance_variable_set(:@three, ['X'])
        allow(game_board).to receive(:convert_to_column).and_return(column) 
        updated_column = ['X', 'X']
        game_board.update(3, 'X')
        expect(column).to eq(updated_column)
      end

    end
  end

  describe '#consecutive?' do
    # Query incoming from Game object

    subject(:game_board) { described_class.new }

    context 'when a Player marker appears 4 consecutive times in a vertical line' do
      arrays = [
        ['X', 'O', 'X', 'O'],
        ['O', 'X', 'O', 'X', 'O'],
        ['X', 'O'],
        ['X', 'X', 'X', 'X'],
        ['O'],
        ['O', 'X', 'O', 'X', 'O', 'X'],
        ['X', 'O', 'X', 'O']
      ]

      it 'returns true' do
        allow(game_board).to receive(:make_grid).and_return(arrays)
        expect(game_board.consecutive?).to be true
      end
    end

    context 'when a Player marker appears 4 consecutive times in a horiztonal line' do
      arrays = [
        ['O', 'X', 'O', 'X', 'O', 'X', 'O'],
        ['O', 'X', 'O', 'O', 'O', 'X', 'X'],
        ['X', 'X', 'X', 'X', 'O', 'X', '*'],
        ['X', 'O', '*', '*', '*', '*', '*'],
        ['O', 'X', '*', '*', '*', '*', '*'],
        ['X', '*', '*', '*', '*', '*', '*']
      ]

      it 'returns true' do
        allow(game_board).to receive(:make_filled_rows).and_return(arrays)
        expect(game_board.consecutive?).to be true
      end
    end

    context 'when a Player marker appears 4 consecutive times in a forward diagonal line' do
      arrays = [
        ["X", "O", "O", "O", "O", "*"],
        ["X", "*", "*", "*", "*"],
        ["*", "*", "*", "*"],
        ["O", "X", "X", "O", "*", "*"],
        ["X", "O", "X", "*", "*"],
        ["O", "X", "*", "*"]
      ]

      it 'returns true' do
        allow(game_board).to receive(:make_forward_diagonals).and_return(arrays)
        expect(game_board.consecutive?).to be true
      end
    end

    context 'when a Player marker appears 4 consecutive times in a backward diagonal line' do
      arrays = [
        ["X", "X", "X", "X", "*", "*"],
        ["O", "*", "*", "*", "*"],
        ["*", "*", "*", "*"],
        ["O", "O", "O", "*", "*", "*"],
        ["X", "X", "*", "*", "*"],
        ["O", "O", "O", "*"]
      ]

      it 'returns true' do
        allow(game_board).to receive(:make_backwards_diagonals).and_return(arrays)
        expect(game_board.consecutive?).to be true
      end
    end
  end

  describe '#make_filled_rows' do
    # Query message sent to self
    # Should this be Private method?
  end

  describe '#make_forward_diagonals' do
    # Query message sent to self
    # Private method?
  end

  describe '#make_backwards_diagonals' do
    # Query message sent to self
    # Private method?
  end

  describe '#four_in_row?' do
    # Query message sent to self
    # Private method?
  end
end
