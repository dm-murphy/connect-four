# frozen_string_literal: true

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end

  def ask_player
    gets.chomp.to_i
  end
end
