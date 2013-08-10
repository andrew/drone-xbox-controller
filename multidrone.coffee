XboxController = require "xbox-controller"
Drone = require './drone'

xbox = new XboxController
drone1 = new Drone(0.5, '192.168.1.18')
drone2 = new Drone(0.5, '192.168.1.19')
drone3 = new Drone(0.5, '192.168.1.16')

# drone1.takeoff()
# drone2.takeoff()
# drone3.takeoff()

maxAngle = 32768

xbox.on "start:press", (key) ->
  console.log "start press (takeoff)"
  drone1.takeoff()
  drone2.takeoff()
  drone3.takeoff()

xbox.on "back:press", (key) ->
  console.log "back press (land)"
  drone1.land()
  drone2.land()
  drone3.land()

xbox.on "xboxbutton:press", (key) ->
  console.log "xboxbutton press (reset)"
  drone1.reset()
  drone2.reset()
  drone3.reset()

xbox.on "lefttrigger", (position) ->
  console.log "lefttrigger", position / 255
  drone1.move({up: position / -255}, false)
  drone2.move({up: position / -255}, false)
  drone3.move({up: position / -255}, false)

xbox.on "righttrigger", (position) ->
  console.log "righttrigger", position / 255
  drone1.move({up: position / 255}, false)
  drone2.move({up: position / 255}, false)
  drone3.move({up: position / 255}, false)

xbox.on "left:move", (position) ->
  x = position.x / maxAngle 
  y = position.y / maxAngle 
  console.log "left:move", {x: x, y: y}
  drone1.move({right: x, back: y}, false)
  drone2.move({right: x, back: y}, false)
  
xbox.on "right:move", (position) ->
  x = position.x / maxAngle 
  y = position.y / maxAngle 
  console.log "right:move", {x: x}
  drone1.move({clockwise: x}, false)
  drone2.move({clockwise: x}, false)
  drone3.move({clockwise: x}, false)
