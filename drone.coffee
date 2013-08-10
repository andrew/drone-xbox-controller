arDrone = require("ar-drone")

class Drone
  constructor: (speed, ip='192.168.1.1') ->
    @speed = speed
    @accel = 0.01
    @control = arDrone.createUdpControl({ip:ip})
    @ref = {}
    @pcmd = {}
    @rate = 30
    setInterval (=>
      @control.ref @ref
      @control.pcmd @pcmd
      @control.flush()
    ), @rate

  takeoff: =>
    @ref.emergency = false
    @ref.fly = true

  land: =>
    @ref.fly = false
    @pcmd = {}

  stop: =>
    @pcmd = {}

  reset: =>
    @pcmd = {}
    @ref.emergency = true
    @ref.fly = false

  move: (directions, reset = true) =>
    @pcmd = {} if reset
    for direction, speed of directions
      s = speed || @speed
      @pcmd[direction] = parseFloat(s)

  increaseSpeed: (accel) =>
    @speed += accel || @accel

  decreaseSpeed: (accel) =>
    @speed -= accel || @accel

  setSpeed: (speed) =>
    @speed = speed

module.exports = Drone