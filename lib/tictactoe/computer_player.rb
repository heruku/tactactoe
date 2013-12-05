class ComputerPlayer < AbstractPlayer
  def initialize(depth, mark)
    @depth = depth
    super(mark)
  end

  def get_move(game)
    moves = rank_moves(game)
    take_random_from_good_moves(moves)
  end

  private

  def rank_moves(game)
  moves = {}
    try_each_valid_move(game) do |game, index|
      moves[index] = -negamax(game)
    end
    moves
  end

  def negamax(game, depth=@depth)
    return get_score(game) if game.over? || depth == 0
    best_score = -Float::INFINITY
    try_each_valid_move(game) do |game|
      best_score = [best_score, negamax(game, depth-1)].max
    end
    return best_score
  end

  def get_score(game)
    return 1 if game.winner == self
    return -1 if game.winner == (game.players - [self]).first
    return 0
  end

  def try_each_valid_move(game)
    game.valid_moves.each do |index|
      game.make_move(index.row, index.column)
      yield(game,index)
      game.undo_move(index.row, index.column)
    end
  end

  def take_random_from_good_moves(moves)
    max_value = moves.values.max
    moves.select{|k,v| v == max_value}.keys.sample
  end
end
