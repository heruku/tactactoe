Indices = Struct.new(:row, :column)

class Board < Array
  
  def initialize(ary=nil)
    ary ||= Array.new(3){Array.new(3){Cell.new}}
    super(ary)
  end

  def open_indices
    self.map.with_index do |row, row_index|
      row.map.with_index do |cell, col_index|
        Indices.new(row_index, col_index) if cell.empty?
      end
    end
    .flatten
    .compact
  end

  def full?
    flatten.all?(&:marked?)
  end

  def diagonals
    [diagonal(self), diagonal(self.map(&:reverse))]
  end

  def columns
    self.transpose
  end

  private

  def diagonal(ary)
    (0..2).map {|i| ary[i][i]}
  end
end
