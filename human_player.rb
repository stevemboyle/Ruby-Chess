require_relative 'display'
require_relative 'player'

class HumanPlayer < Player

  def make_move(board)
    from_pos, to_pos = nil, nil

    until from_pos && to_pos
      display.render

      if from_pos
        puts "Current Player: #{color.capitalize}"
        puts "#{color.capitalize}, which tile would you like to move to?"

        to_pos = display.get_input

        display.reset! if to_pos
      else
        puts "Current Player: #{color.capitalize}"
        puts "#{color.capitalize}, which piece would you like to move?"
        from_pos = display.get_input

        display.reset! if from_pos
      end
    end

    [from_pos, to_pos]
  end

end
