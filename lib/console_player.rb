class ConsolePlayer < AbstractPlayer
  def get_move(*)
   print "Enter index(xy): "
   input = gets.chomp
   Indices.new(input[0].to_i, input[1].to_i) 
  end
end