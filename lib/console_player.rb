class ConsolePlayer < TicTacToe::AbstractPlayer
  def get_move(*)
   print "Enter index(xy): "
   gets.chomp.to_i - 1
  end
end