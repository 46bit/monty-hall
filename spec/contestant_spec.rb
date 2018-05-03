require 'spec_helper'
require './contestant'

describe Contestant do
  it "wins 2/3rds of the time" do
    number_of_wins = 0
    number_of_tests = 100000
    number_of_tests.times do
      if Contestant.new.play(Host.new)
        number_of_wins += 1
      end
    end
    expect(number_of_wins).to be_within(number_of_tests / 100).of(number_of_tests * 0.66)
  end
end
