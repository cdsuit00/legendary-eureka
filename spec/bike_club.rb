require './lib/ride'
require './lib/biker'
require './lib/bikeclub'
require 'pry'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe BikeClub do
  before(:each) do
    @biker = Biker.new("Kenny", 30)
    @biker2 = Biker.new("Athena", 15)
    @biker3 = Biker.new("Blake", 20)
    @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
    @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
    @ride3 = Ride.new({name: "Hebra Mountain", distance: 20.0, loop: false, terrain: :mountain})
    @bikeclub = BikeClub.new("Kamen Riders")
  end

  describe '#initialize' do
    it 'exists' do
      expect(@bikeclub).to be_a(BikeClub)
    end
  end

  describe '#attributes' do
    it 'has a name' do
      expect(@bikeclub.name).to eq("Kamen Riders")
    end

    it 'can add bikers to the club' do
      expect(@bikeclub.members).to eq([])

      @bikeclub.add_biker(@biker)
      @bikeclub.add_biker(@biker2)
      @bikeclub.add_biker(@biker3)

      expect(@bikeclub.members).to eq([@biker, @biker2, @biker3])
    end

    it 'can show the biker with the most rides' do
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)
      @biker2.learn_terrain(:hills)
      @biker2.learn_terrain(:mountain)
      @biker3.learn_terrain(:mountain)
      @biker3.learn_terrain(:gravel)

      @biker.log_ride(@ride1, 92.5)
      @biker2.log_ride(@ride1, 91.1)
      @biker3.log_ride(@ride1, 60.9)
      @biker.log_ride(@ride2, 58.6)
      @biker2.log_ride(@ride2, 90.5)
      @biker3.log_ride(@ride2, 89.1)
      @biker2.log_ride(@ride3, 57.9)
      @biker3.log_ride(@ride3, 56.6)
      @biker3.log_ride(@ride3, 88.5)
      @biker.log_ride(@ride3, 87.5)

      expect(@bikeclub.most_rides).to eq(@biker3)
    end
  end
end