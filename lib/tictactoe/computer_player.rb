class ComputerPlayer < AbstractPlayer
  def initialize(level, mark)
    case level
    when :easy
      @depth = 4
    when :hard
      @depth = 12
    end
    super(mark)
  end

  def get_move(game)
    best_score = -Float::INFINITY
    best_index = nil
    try_each_valid_move(game.copy) do |game, index|
      score = -negamax(game, -1)
      best_score, best_index = score, index if score > best_score
    end
    return best_index
  end

  private

  def negamax(game, color, depth=@depth)
    return color * get_score(game) if game.over? || depth == 0
    best_score = -Float::INFINITY
    try_each_valid_move(game) do |game|
      best_score = [best_score, -negamax(game, -color, depth-1)].max
    end
    return best_score
  end

  def get_score(game)
    return 1.0 if game.winner == self
    return -1.0 if game.winner == (game.players - [self]).first
    return 0.0
  end

  def try_each_valid_move(game)
    game.valid_moves.shuffle.each do |index|
      game.make_move(index)
      yield(game,index)
      game.undo_move(index)
    end
  end
end
