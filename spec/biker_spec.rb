require './lib/ride'
require './lib/biker'
require 'pry'

RSpec.configure do |config|
 config.formatter = :documentation
end

RSpec.describe Biker do
 before(:each) do
  @biker = Biker.new("Kenny", 30)
  @biker2 = Biker.new("Athena", 15)
  @ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
  @ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
 end


  describe '#initialize' do
    it 'exists' do
    expect(@biker).to be_a(Biker)
    expect(@biker2).to be_a(Biker)
    end
  end

  describe'#attributes' do
    it 'has a name' do
    expect(@biker.name).to eq("Kenny")
    expect(@biker2.name).to eq("Athena")
    end

    it 'has a max_distance' do
    expect(@biker.max_distance).to eq(30)
    expect(@biker2.max_distance).to eq(15)
    end
    
    it 'has and can add to acceptable_terrain' do
      expect(@biker.acceptable_terrain).to eq([])
      expect(@biker.acceptable_terrain).to eq([])
      
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)
      @biker2.learn_terrain(:gravel)
      
      expect(@biker.acceptable_terrain).to eq([:gravel, :hills]) 
      expect(@biker2.acceptable_terrain).to eq([:gravel]) 
    end

    it 'can keep track of rides' do
      expect(@biker.rides).to eq({})
      expect(@biker2.rides).to eq({})

        @biker.learn_terrain(:gravel)
        @biker.learn_terrain(:hills)

        @biker.log_ride(@ride1, 92.5)
        @biker.log_ride(@ride1, 91.1)
        @biker.log_ride(@ride2, 60.9)
        @biker.log_ride(@ride2, 61.6)

        @biker2.log_ride(@ride1, 97.0) #biker2 doesn't know this terrain yet
        @biker2.log_ride(@ride2, 67.0) #biker2 doesn't know this terrain yet

        expect(@biker.rides).to eq({
          @ride1 => [92.5, 91.1],
          @ride2 => [60.9, 61.6]
        })

        expect(@biker2.rides).to eq({})

        @biker2.learn_terrain(:gravel)
        @biker2.learn_terrain(:hills)

        @biker2.log_ride(@ride1, 95.0) # biker2 can't bike this distance
        @biker2.log_ride(@ride2, 65.0) # biker2 knows this terrain and can bike this distance
        
        expect(@biker2.rides).to eq({@ride2 => [65.0]})
    end 

    it 'has personal records' do
      @biker.learn_terrain(:gravel)
      @biker.learn_terrain(:hills)
      @biker2.learn_terrain(:gravel)
      @biker2.learn_terrain(:hills)
      @biker.log_ride(@ride1, 92.5)
      @biker.log_ride(@ride1, 91.1)
      @biker.log_ride(@ride2, 60.9)
      @biker.log_ride(@ride2, 61.6)
      @biker2.log_ride(@ride1, 95.0) # biker2 can't bike this distance
      @biker2.log_ride(@ride2, 65.0) # biker2 knows this terrain and can bike this distance


      expect(@biker.personal_record(@ride1)).to eq(91.1)
      expect(@biker.personal_record(@ride2)).to eq(60.9)

      expect(@biker2.personal_record(@ride2)).to eq(65.0)
      expect(@biker2.personal_record(@ride1)).to eq(false)
    end 
  end
end