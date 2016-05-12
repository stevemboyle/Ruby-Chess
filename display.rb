require "colorize"
require_relative "cursorable"

class Display
  include Cursorable

  attr_reader :board, :notifications

  def initialize(board)
    @board = board
    @cursor_pos = [0, 0]
    @notifications = {}
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def build_row(row, i)
    row.map.with_index do |piece, j|
      color_options = colors_for(i, j)
      piece.to_s.colorize(color_options)
    end
  end

  def colors_for(i, j)
    if [i, j] == @cursor_pos
      bg = :pink
    elsif (i + j).odd?
      bg = :light_blue
    else
      bg = :blue
    end
    { background: bg }
  end

  def reset!
    @notifications.delete(:error)
  end

  def uncheck!
    @notifications.delete(:check)
  end

  def set_check!
    @notifications[:check] = "Check!"
  end

  def render
    system("clear")
    puts "Let's play chess!"
    puts "You can use the arrow keys to move."
    puts "Then, press enter to select your piece or tile."
    # puts "Select the piece you would like to move,"
    # puts "and then the tile to which you would like to move it."
    build_grid.each { |row| puts row.join }

    @notifications.each do |key, val|
      puts "#{val}"
    end
  end
end
