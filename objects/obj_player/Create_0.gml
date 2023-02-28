//movement
hspeed_ = 0
vspeed_ = 0
health_ = 10
max_health_ = health_
gravity_ = 1
jump_height = -16
jump_already_decreased = false
short_jump = false
long_jump = false
acceleration_ = 10
//gun 
current_gun = 4
current_bullet = obj_bullet 
aiming = 0
shooting_downwards = false
shooting_upwards = false
//ammo
ammo = 5
ammo_per_time = 2
max_ammo = 80
bullet_direction = 0
bullet_cooldown = room_speed/8
alarm[0] = bullet_cooldown
ammo_repeat = true
shooting_cooldown = 360
bullet_for_time = 1
//other abilities
//dash
can_dash = true
already_dashing = false
dash_speed = 25
dash_power = 200
dash_move = 0
dash_recharging = false