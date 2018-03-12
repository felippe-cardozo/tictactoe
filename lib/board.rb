# Custom Array that takes an Array or Range as init parameter and
# requires length of 9 and values in the range 0..8 or 'X', or 'O'
class Board
  include Enumerable
  attr_reader :cells

  def initialize(cells = [])
    @cells = []
    cells.each { |i| @cells << i }
    @cells = (0..8).to_a if @cells.empty?
    validate
  end

  def avaiable_spots
    @cells.select { |i| i.is_a? Integer }
  end

  private

    def each
      @cells.map { |i| yield i }
    end

    def to_s
      new_line = "\n===+===+===\n"
      top = ' ' + @cells[0..2].join(' | ') + ' ' + new_line
      mid = ' ' + @cells[3..5].join(' | ') + ' ' + new_line
      bot = ' ' + @cells[6..8].join(' | ') + ' ' + "\n"
      top + mid + bot
    end

    def validate
      validate_len
      validate_values
    end

    def validate_len
      raise TypeError, 'Board must have 9 cells' unless count == 9
    end

    def validate_values
      return if all? { |i| i == 'O' || i == 'X' || (0..8).cover?(i) }
      raise TypeError, "Board's values must be 'X', 'O' or (0..8)"
    end
end
