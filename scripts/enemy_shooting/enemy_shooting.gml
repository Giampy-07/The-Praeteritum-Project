function enemy_shooting()
{
if alarm[0] <= 0 
{
	var dir = point_direction(x, y, obj_new_player.x, obj_new_player.y- obj_new_player.sprite_height/2)
	var x_offset = lengthdir_x(20, dir)
	var y_offset = lengthdir_y(20, dir)
	var bullet = instance_create_layer(x + x_offset, y + y_offset, "Instances", obj_bullet_enemy);
	bullet.direction = dir
	bullet.image_angle = dir
	alarm[0] = bullet_cooldown
}
}