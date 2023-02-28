//movement state
//move towards the player
if instance_exists(obj_player)
{
if distance_to_object(obj_player) <= 200
{
var dir = point_direction(x, y, obj_player.x, obj_player.y)
hspeed_ = lengthdir_x(speed_, dir)
vspeed_ = lengthdir_y(speed_, dir)
move(hspeed_, vspeed_)
if alarm[0] <= 0 
{
	var dir = point_direction(x, y, obj_player.x, obj_player.y- obj_player.sprite_height/2)
	var x_offset = lengthdir_x(20, dir)
	var y_offset = lengthdir_y(20, dir)
	var bullet = instance_create_layer(x + x_offset, y + y_offset, "Instances", obj_bullet_enemy);
	bullet.direction = dir
	bullet.image_angle = dir
	alarm[0] = bullet_cooldown
}
if distance_to_object(obj_player) < 50
{
	state_ = ATTACK
}
}
}