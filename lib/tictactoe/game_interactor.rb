class GameInteractor
  attr_reader :player1, :player2, :winner, :players
  attr_accessor :board
  EMPTY = " "
  DEFAULTS = {board: Array.new(9){EMPTY}}

  def initialize(opts)
    opts = DEFAULTS.merge(opts)
    @board   = opts.fetch(:board)
    @player1 = opts.fetch(:player1)
    @player2 = opts.fetch(:player2)
    @players = [@player1, @player2]
    @winner  = nil
  end

  def make_move(index)
    board[index] = turn.mark
    switch_turn
  end

  def undo_move(index)
    board[index] = EMPTY
    switch_turn
  end

  def valid_moves
    board.map.with_index do |cell, index|
      index if cell == EMPTY
    end
    .compact
  end

  def over?
    true if win? || draw?
  end

  def turn
    players.first
  end

  def valid_move?(move)
    valid_moves.include?(move)
  end


  private

  def rows
    board.each_slice(3).to_a
  end

  def columns
    rows.transpose
  end

  def diagonals
    [diagonal(rows), diagonal(rows.map(&:reverse))]
  end

  def draw?
    valid_moves.empty? && !winner
  end

  def win?
    @winner = check_winner(rows) || check_winner(columns) || check_winner(diagonals)
  end

  def check_winner(ary)
    winner = nil
    ary.each do |subary|
      players.each do |player|
        winner = player if subary.all?{|cell| cell == player.mark }
      end
    end
    return winner
  end

  def switch_turn
    players.rotate!
  end

  def diagonal(ary)
    (0..2).map {|i| ary[i][i]}
  end

end
