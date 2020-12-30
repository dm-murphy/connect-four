#spec/game_spec.rb
require './lib/game'

describe Game do
  describe '#start' do
    # Public Script Method -> No test needed, but check methods inside
  end

  describe '#swap_player' do
    # Command sent to self so don't test?
  end

  describe '#display_rules' do
    # Query sent to self? 
    # Puts message. No test needed.
  end

  describe '#game_over?' do
    # Outgoing query message sent to Board object, so don't test?
  end

  describe '#tie' do
    # Sends outgoing (query?) message to Board object, so don't test?
    # Puts message sent to self, don't test
  end

  describe '#winner' do
    # Sends outgoing (query?) message to Board object, so don't test?
    # Puts message sent to self, don't test
  end

  describe '#take_turn' do
    # Sends outgoing query message to Player object, don't test
    # Sends outgoing query message to Board object, don't test
    # Sends outgoing command message to Boad object, don't test
  end
end