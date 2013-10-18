# Node Drone Xbox Controller

Control your Parrot AR Drone with a Xbox 360 controller

## Usage

git clone https://github.com/andrew/drone-xbox-controller

cd drone-xbox-controller

npm install

Connect to wifi on parrot ar drone

coffee drone-xbox.coffee

## Controls

* start => takeoff / land
* x => fire (animate leds)
* y => blink lights
* left stick => front/back, left/right
* right stick => up/down, counterClockwise/clockwise
* right stick press => turnaround
* right shoulder (rb) => increase speed
* left shoulder (lb) => decrease speed
* d pad will flip in direction pressed

## LED
The controller will light up based on percentage of battery left. 4 = full, 1 = 25% and will start flashing when low

## TODO

Make cli bin

## Copyright

Copyright (c) 2013 Andrew Nesbitt. See [LICENSE](https://github.com/andrew/drone-xbox-controller/blob/master/LICENSE) for details.