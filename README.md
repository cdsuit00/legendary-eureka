# Bike Ride

## Instructions
* Fork this Repository
* Clone your forked repo
* Complete the activity Below
* Push your solution to your repo
* Submit a Pull Request from your repo to this repo
* In your PR, please include your name!
* Record a video explanation of the following methods, and send the video in a DM to your instructors:
  * Biker #log_rides (iteration 2)
  * One of: BikeClub #most_rides, #best_time or #bikers_eligible

## Iteration 1 - Rides

Graded Items:

1. Create Rides with attributes and a way to read that data
2. Rides can indicate if the ride is a loop or not.
3. A Ride can report its total distance. The total distance is double the base distance if the ride is not a loop.

```ruby
pry(main)> require './lib/ride'
# => true

pry(main)> ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
# => #<Ride:0x00007f845c279ee8...>

pry(main)> ride1.name
# => "Walnut Creek Trail"

pry(main)> ride1.distance
# => 10.7

pry(main)> ride1.terrain
# => :hills

pry(main)> ride1.loop?
# => false

pry(main)> ride1.total_distance
# => 21.4

pry(main)> ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
# => #<Ride:0x00007f845c228b38...>

pry(main)> ride2.loop?
# => true

pry(main)> ride2.total_distance
# => 14.9
```


## Iteration 2 - Bikers

Graded Items:

1. Create a Biker with attributes and a way to read that data
2. A Biker has a list of acceptable terrain and can learn new terrain
3. Bikers can log a ride with a time. The Biker can keep track of all of its previous rides and times for those rides.
4. A Biker will not log a ride if the ride's terrain does not match their acceptable terrain. They also won't log a ride if the ride's total distance is greater than the Biker's max distance.
5. A Biker can report its personal record for a specific ride. This is the lowest time recorded for a ride. This method will return false if the Biker hasn't completed the ride

```ruby
pry(main)> require './lib/ride'
# => true

pry(main)> require './lib/biker'
# => true

pry(main)> biker = Biker.new("Kenny", 30)
# => #<Biker:0x00007fc62ca41150...>

pry(main)> biker.name
# => "Kenny"

pry(main)> biker.max_distance
# => 30

pry(main)> biker.rides
# => {}

pry(main)> biker.acceptable_terrain
# => []

pry(main)> biker.learn_terrain(:gravel)

pry(main)> biker.learn_terrain(:hills)

pry(main)> biker.acceptable_terrain
# => [:gravel, :hills]

pry(main)> ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
# => #<Ride:0x00007fc62ca32a10...>

pry(main)> ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})
# => #<Ride:0x00007fc62cb42ba8...>

pry(main)> biker.log_ride(ride1, 92.5)

pry(main)> biker.log_ride(ride1, 91.1)

pry(main)> biker.log_ride(ride2, 60.9)

pry(main)> biker.log_ride(ride2, 61.6)

pry(main)> biker.rides
# => {
#      #<Ride:0x00007fc62ca32a10...> => [92.5, 91.1],
#      #<Ride:0x00007fc62cb42ba8...> => [60.9, 61.6]
#    }

pry(main)> biker.personal_record(ride1)
=> 91.1

pry(main)> biker.personal_record(ride2)
=> 60.9

pry(main)> biker2 = Biker.new("Athena", 15)
=> #<Biker:0x00007fc62cb399e0...>

pry(main)> biker2.log_ride(ride1, 97.0) #biker2 doesn't know this terrain yet

pry(main)> biker2.log_ride(ride2, 67.0) #biker2 doesn't know this terrain yet

pry(main)> biker2.rides
# => {}

pry(main)> biker2.learn_terrain(:gravel)

pry(main)> biker2.learn_terrain(:hills)

pry(main)> biker2.log_ride(ride1, 95.0) # biker2 can't bike this distance

pry(main)> biker2.log_ride(ride2, 65.0) # biker2 knows this terrain and can bike this distance

pry(main)> biker2.rides
#=> { #<Ride:0x00007fc62cb42ba8...> => [65.0] }

pry(main)> biker2.personal_record(ride2)
#=> 65.0

pry(main)> biker2.personal_record(ride1)
#=> false
```
## Iteration 3 - Bike Club

Use TDD to create a `BikeClub` class that adds the following functionality:

1. Each `BikeClub` has a name, as well as a way to read that data
1. Each `BikeClub` has a list of Bikers, and the `BikeClub` can add new Bikers.

Additionally, use TDD to add the following functionality to the `BikeClub` class. A passing challenge will complete at least one of the following. We recommend completing more than one if you have time.

1. A `BikeClub` can tell us which Biker has logged the most rides.
1. A `BikeClub` can tell us which Biker has the best time for a given Ride.
1. A `BikeClub` can tell us which Bikers are eligible for a given Ride. A Biker is eligible for a Ride if the terrain is acceptable to them and the total distance does not exceed their max distance.

| Method Name | Return Value |
| ----------- | ------------ |
| `name` | Club name as a `String` |
| `bikers` | `Array` of `Biker` objects |
| `add_biker(biker)` | `Array` of `Biker` objects |
| `most_rides` | `Biker` object |
| `best_time(ride)` | `Biker` object |
| `bikers_eligible(ride)` | `Array` of `Biker` objects |


## Iteration 4 - Extensions

Use TDD to add the following features:

1. Add on to your existing `BikeClub` class so that it can record a group ride:
    * When a ride starts, the start time is the current time. All eligible members for a ride start at the same time.
    * Each member finishes at a different time. When a member finishes, the current time is their finish time. The BikeClub calculates their ride time (in minutes) based on the start and end times, and logs that to the Bikers ride log.
    * In order to test this, you must use Mocks and Stubs to stub the current time.
1. The `BikeClub` class can return the rider with the best time for a given ride across **all** `BikeClub` instances.

| Method Name | Return Value |
| ----------- | ------------ |
| `record_group_ride(ride)` | `Hash` with the following format: key of `:start_time` pointing to a value of the ride's start time (a `Time` object), key of `:ride` pointing to a value of a `Ride` object, and a key of `:members` pointing to a value of an `Array` of `Biker` objects. Example:  ```{ start_time: Time(Object),  ride: Ride(Object), members: Array of Biker objects }``` |
| `group_rides` | `Array` of recorded group ride data (the hash from above)|
| `self.best_rider` | `Biker` object |
