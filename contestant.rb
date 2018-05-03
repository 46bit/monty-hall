class Contestant
  def play(host)
    chosen_door = Random.rand 3
    host.choose(chosen_door)
    rechosen_door = [0, 1, 2] - [chosen_door, host.eliminate_one]
    host.choose(rechosen_door[0])
    host.won?
  end
end
