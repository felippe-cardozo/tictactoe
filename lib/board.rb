class Board
  attr_reader :state
  def initialize state=(0..8).to_a
    valid? state
    @state = state
  end

  def avaiable_spots
    @state.select{|i| i.is_a? Integer}
  end

  def print
    new_line = "\n===+===+===\n"
    top = " " + @state[0..2].join(' | ') + " " + new_line
    mid = " " + @state[3..5].join(' | ') + " " + new_line
    bot = " " + @state[6..8].join(' | ') + " "
    puts top + mid + bot
    puts "\n"
  end

  private
  def valid_len? arr
    raise TypeError, 'Board must have 9 cells' unless arr.length == 9
    true
  end

  def valid_contents? arr
    unless arr.all? {|i| i == 'X' || i == 'O' || (0..8).include?(i)}
      raise TypeError, 'Board Contents only acceps X, O or (0..8)'
    end
    true
  end

  def valid? state
    valid_len? state
    valid_contents? state
    true
  end
end
