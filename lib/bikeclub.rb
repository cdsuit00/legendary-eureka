class BikeClub
  attr_reader :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def add_biker(biker)
    @members << biker
  end

  def most_rides
    @members.max_by do |biker|
      biker.rides.values.flatten.length
    end
  end  
end