class Host
  def initialize
    @prize_door = Random.rand(3)
  end

  def choose(chosen_door)
    @chosen_door = chosen_door
  end

  def eliminate_one
    if @chosen_door.nil?
      raise RuntimeError#("cannot eliminate a door before an initial choice has been made")
    end
    openable_doors = [0, 1, 2]
    openable_doors -= [@prize_door]
    openable_doors -= [@chosen_door]
    @eliminated_door ||= openable_doors[0]
  end

  def won?
    @chosen_door == @prize_door
  end
end
