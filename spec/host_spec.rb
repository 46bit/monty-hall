require 'spec_helper'
require './host'

describe Host do
  let(:host) { Host.new }

  it "allows the initial choice" do
    chosen_door = Random.rand(3)
    host.choose(chosen_door)
  end

  it "refuses to eliminate a door before the initial choice" do
    expect { host.eliminate_one }.to raise_error(RuntimeError)
  end

  it "allows eliminating a door after an initial choice" do
    chosen_door = Random.rand(3)
    host.choose(chosen_door)
    expect([0, 1, 2] - [chosen_door]).to include(host.eliminate_one)
  end

  it "does not eliminate different doors when re-choosing" do
    chosen_door = Random.rand(3)
    host.choose(chosen_door)
    eliminated_door = host.eliminate_one
    host.choose([0, 1, 2] - [chosen_door, eliminated_door])
    expect(host.eliminate_one).to eq(eliminated_door)
  end

  it "tells you whether you chose correctly" do
    chosen_door = Random.rand(3)
    host.choose(chosen_door)
    eliminated_door = host.eliminate_one
    host.choose(eliminated_door)
    expect(host.won?).to eq(false)
  end

  it "chooses fairly" do
    choices = {0 => 0, 1 => 0, 2 => 0}
    number_of_tests = 100000
    number_of_tests.times do
      host = Host.new
      choices[host.instance_variable_get("@prize_door")] += 1
    end
    choices.each do |k, v|
      expect(v).to be_within(number_of_tests / 100).of(number_of_tests / 3)
    end
  end
end
