XboxController = require "xbox-controller"
arDrone = require 'ar-drone'

xbox = new XboxController
options = {ip: '192.168.1.1'}

client = arDrone.createClient(options)

client.config('control:outdoor', 'FALSE')
client.config('control:flight_without_shell', 'TRUE')

#in millimeters
client.config('control:altitude_max', 30000)
client.config('control:altitude_min', 3000)

#set to record to usb
client.config('video:video_on_usb', 'TRUE')

yaw = 3.05
euler = 0.26
vz = 1000

setSpeed = (delta) ->
  yaw = yaw + delta
  yaw = 6.11 if yaw > 6.11
  yaw = 0.7 if yaw < 0.7

  delta = delta / 10.7 #make the increase smaller for euler
  euler = euler + delta
  euler = 0.52 if euler > 0.52
  euler = 0.1 if euler < 0.1

  delta = delta * 10.7 * 100 #make the increase larger for vz
  vz = vz + delta
  vz = 2000 if vz  > 2000
  vz = 200 if vz < 200

  console.log("Setting yaw: " + yaw + " - euler: " + euler + " - vz: " + vz)
  #change to set rotation speed - 0.7 to 6.11
  client.config('control:control_yaw', yaw)
  #change to set tilt (left, right, front, back)
  #0 to 0.52 is max
  client.config('control:euler_angle_max', euler)

  #speed to go up and down 200 to 2000
  client.config('control:control_vz_max', vz)

setSpeed(0)


maxAngle = 32768
#change from 1 to -1 to change controller directions
invert = -1

client.on "batteryChange", (battery) ->
  if battery > 75
    xbox.setLed(0x09)
  else if battery > 50
    xbox.setLed(0x08)
  else if battery > 25
    xbox.setLed(0x07)
  else if battery > 15
    xbox.setLed(0x06)

client.on "lowBattery", (battery) ->
  xbox.setLed(0x01)

xbox.on "start:press", (key) ->
  console.log "start press (takeoff or land)"
  if client._lastState == 'CTRL_LANDED'
    client.takeoff()
  else
    client.land()

xbox.on "xboxbutton:press", (key) ->
  console.log "xboxbutton press (reset)"
  client.disableEmergency()

xbox.on "leftshoulder:press", (key) ->
  console.log "leftshoulder - decreasing speed"
  setSpeed(-1)

xbox.on "rightshoulder:press", (key) ->
  console.log "rightshoulder - increasing speed"
  setSpeed(1)

xbox.on "left:move", (position) ->
  x = parseFloat(position.x / maxAngle)
  y = parseFloat(position.y / maxAngle)
  console.log "left:move", {x: x, y: y}
  client.stop() if x == 0 && y == 0

  if x != 0
    client.right(x)

  if y != 0
    client.front(invert * y)

xbox.on "right:move", (position) ->
  x = parseFloat(position.x / maxAngle)
  y = parseFloat(position.y / maxAngle)
  console.log "right:move", {x: x, y: y}

  if x != 0
    client.clockwise(x)

  if y != 0
    client.up(invert * y)

xbox.on "dup:press", (key) ->
  console.log('D up (flip front)')
  client.animate('flipAhead', 1500);

xbox.on "ddown:press", (key) ->
  console.log('D down (flip back)')
  client.animate('flipBehind', 1500);

xbox.on "dleft:press", (key) ->
  console.log('D left (flip left)')
  client.animate('flipLeft', 1500);

xbox.on "dright:press", (key) ->
  console.log('D right (flip right)')
  client.animate('flipRight', 1500);

xbox.on "x:press", (key) ->
  client.animateLeds('fire', 5, 2)

xbox.on "y:press", (key) ->
  client.animateLeds('blinkStandard', 5, 2)

xbox.on "rightstick:press", (key) ->
  console.log 'rightstick press'
  client.animate('turnaround', 5000);

xbox.on "a:press", (key) ->
  console.log('a')
