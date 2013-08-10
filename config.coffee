arDrone = require 'ar-drone'

client = arDrone.createClient({ip: '192.168.1.1'})

client.config('control:altitude_max', 30000)
client.config('control:control_vz_max', 500)
client.config('control:control_yaw', 2.5)
client.config('control:euler_angle_max', 0.2)
client.config('control:outdoor', false)
client.config('control:flight_without_shell', false)

console.log 'done'
