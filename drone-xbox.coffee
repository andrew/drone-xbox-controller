XboxController = require "xbox-controller"
Drone = require './drone'
arDrone = require 'ar-drone'

xbox = new XboxController
drone = new Drone(0.5)

client = arDrone.createClient()

xbox.on "start:press", (key) ->
  console.log "start press (takeoff)"
  drone.takeoff()

xbox.on "back:press", (key) ->
  console.log "back press (land)"
  drone.land()

xbox.on "a:press", (key) ->
  console.log "a press (stop)"
  drone.stop()

xbox.on "xboxbutton:press", (key) ->
  console.log "xboxbutton press (reset)"
  client.disableEmergency()

xbox.on "righttrigger", (position) ->
  console.log "righttrigger", position/255
  drone.setSpeed(0.5 + position/255)

xbox.on "left:move", (position) ->
  x = position.x/32768
  y = position.y/32768
  console.log "left:move", {x: x, y: y}
  drone.move({right: x, back: y}, false)
  
xbox.on "right:move", (position) ->
  x = position.x/32768
  y = position.y/32768
  console.log "right:move", {x: x, y: y}
  drone.move({clockwise: x, down: y}, false)
