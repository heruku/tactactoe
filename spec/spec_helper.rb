require 'tictactoe'
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

 def from_char_ary(ary)
    Board.new(ary.flatten.map{|char| Cell.new(char)}.each_slice(3).to_a)
 end
