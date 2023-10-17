# frozen_string_literal: true

# Cell
class Cell
  attr_reader :mark

  def initialize
    @mark = '-'
  end

  def set(mark)
    if @mark == '-'
      @mark = mark
      true
    else
      false
    end
  end

  def clear
    @mark = '-'
  end

  def to_s
    mark.to_s
  end
end
