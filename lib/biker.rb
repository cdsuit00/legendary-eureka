class Biker
  attr_reader :name, :max_distance, :acceptable_terrain, :rides

  def initialize(name, max_distance)
    @name = name
    @max_distance = max_distance
    @acceptable_terrain = []
    @rides = {}
  end

  def learn_terrain(terrain)
    @acceptable_terrain << terrain
  end

  def log_ride(ride, time)
    if @acceptable_terrain.include?(ride.terrain) && ride.total_distance <= @max_distance
      @rides[ride] ||= []
      @rides[ride] << time
    end
  end

  def personal_record(ride)
    return false if @rides[ride].nil?
    @rides[ride].min
  end
end