# frozen_string_literal: true

require './lib/cell'

# GameBoard
class GameBoard
  attr_reader :board

  def initialize
    @board = Array.new(3) { Array.new(3) { Cell.new } }
  end

  def clear
    @board.each { |row| row.each(&:clear) }
  end

  def get_mark(row, col)
    @board[row][col].mark
  end

  def set_mark(row, col, mark)
    @board[row][col].set(mark)
  end

  def to_s
    "#{@board[0][0]}#{@board[0][1]}#{@board[0][2]}\n" \
      "#{@board[1][0]}#{@board[1][1]}#{@board[1][2]}\n" \
      "#{@board[2][0]}#{@board[2][1]}#{@board[2][2]}"
  end
end
