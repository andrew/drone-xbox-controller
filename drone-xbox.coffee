XboxController = require "xbox-controller"
Drone = require './drone'
arDrone = require 'ar-drone'

xbox = new XboxController
drone = new Drone(0.5)

client = arDrone.createClient()

maxAngle = 32768

xbox.on "start:press", (key) ->
  console.log "start press (takeoff)"
  drone.takeoff()

xbox.on "back:press", (key) ->
  console.log "back press (land)"
  drone.land()

xbox.on "xboxbutton:press", (key) ->
  console.log "xboxbutton press (reset)"
  drone.reset()

xbox.on "lefttrigger", (position) ->
  console.log "lefttrigger", position / 255
  drone.move({down: position / 255}, false)

xbox.on "righttrigger", (position) ->
  console.log "righttrigger", position / 255
  drone.move({up: position / 255}, false)

xbox.on "left:move", (position) ->
  x = position.x / maxAngle 
  y = position.y / maxAngle 
  console.log "left:move", {x: x, y: y}
  drone.move({right: x, back: y}, false)
  
xbox.on "right:move", (position) ->
  x = position.x / maxAngle 
  y = position.y / maxAngle 
  console.log "right:move", {x: x}
  drone.move({clockwise: x}, false)

