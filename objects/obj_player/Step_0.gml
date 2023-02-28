if instance_exists(obj_controller)
{
if global.game_state = states.paused 
{
	exit
}
}

#region movement
#region horizontal movent
var hinput = keyboard_check(vk_right) - keyboard_check(vk_left)
hspeed_ = hinput*acceleration_
if hinput != 0
{

	sprite_index = spr_legs_arm
	image_xscale = hinput
	image_speed = 1
		if keyboard_check(vk_up)
		{
		shooting_upwards = true
		sprite_index = spr_run_upshooting
		image_xscale = hinput
		image_speed = 1
	}
	else
	{
		shooting_upwards = false
		sprite_index = spr_legs_arm
		image_speed = 1
	}
}
else 
{
	sprite_index = spr_idle
	image_speed = 1
	image_index = 0
	if keyboard_check(vk_up)
	{
		shooting_upwards = true
		sprite_index = spr_idle_upshooting
		image_speed = 1
		image_index = 0
	}
	else
	{
		shooting_upwards = false
		sprite_index = spr_idle
	}
}
#endregion
#region vertical movement
#region jump imputs
if keyboard_check_pressed(vk_space)
{
	alarm[4] = 45
}
if keyboard_check_released(vk_space) && alarm[4] >= 30 && jump_already_decreased = false
{
jump_height += 4
jump_already_decreased = true
short_jump = true
long_jump = false
} else if keyboard_check_released(vk_space) and alarm[4] < 30
{
jump_height = -16
jump_already_decreased = false
short_jump = false
long_jump = true
}
#endregion
//not in the ground
if !place_meeting(x, y+1, obj_wall_in_game)
{
	vspeed_ += gravity_  
		if hinput != 0
	{
		hspeed_ -= 2
	}
	sprite_index = spr_new_jump
	image_speed = 1
	if shooting_upwards = true
	{
	sprite_index = spr_jump_up
		image_speed = 1
	}
	else
	{
		sprite_index = spr_new_jump
}
}
//jumping
else if place_meeting(x, y+1, obj_wall_in_game) && keyboard_check_released(vk_space)
{
	vspeed_ = jump_height
	audio_play_sound(jump_sound, 3, false)
		sprite_index = spr_new_jump
		image_speed = 1
}
move(hspeed_, vspeed_)
#endregion
#region shooting downwards
if keyboard_check(vk_down) && !place_meeting(x, y+1, obj_wall_in_game) 
 {
	shooting_downwards = true
	sprite_index = spr_jump_gun
	image_speed = 1
	image_index = 0
	} else 
	{
	shooting_downwards = false
		image_speed = 1
	}
#endregion
#endregion
#region shooting
#region input sistem
pressed_ = mouse_check_button_pressed(mb_left)
hold_ = mouse_check_button(mb_left)
var input_type_ = pressed_
//gun change
if current_gun = 2
{
	input_type_ = pressed_
	bullet_for_time = 5
	ammo_per_time = 5
	current_bullet = obj_bullet_long_shot
	shooting_cooldown =120
} else if current_gun = 3
{
		input_type_ = pressed_
	bullet_for_time = 5
	ammo_per_time = 5
	current_bullet = obj_bow_charge
	shooting_cooldown = 120
} else if current_gun = 1
{
		input_type_ = pressed_
	bullet_for_time = 10
	ammo_per_time = 10
	current_bullet = obj_bullet_revolver
	shooting_cooldown = 120
}
else if current_gun = 4
{
		input_type_ = hold_
	bullet_for_time = 2
	ammo_per_time = 2
	current_bullet = obj_bullet
	shooting_cooldown = 60
}
#endregion
#region bullet creation
if input_type_ && ammo_repeat = true
{
if ammo > 0
{
if alarm[0] <= 0
{	
	 if aiming = 0
	{
	
	ammo -= 1
	//var flipped = image_xscale * 2 - 1 sostituito col codice che segue
	//var gun_x = x - 4 * flipped
	//var x_offset = lengthdir_x(8, 80)
	//var y_offset = lengthdir_y(8, 80)
	var delta_x = 6 * image_xscale
	var bullet = instance_create_layer(x + delta_x, y - 6, "Effects", current_bullet);
	audio_play_sound(shot_sound, 2, false)
	#region recoil sprites
	if hinput != 0
{
//running
	sprite_index = spr_legs_arm_recoil
	image_xscale = hinput
	image_speed = 1
		if !place_meeting(x, y+1, obj_wall_in_game)
		{
			//running and jumping
			sprite_index = spr_new_jump
			image_xscale = hinput
			image_speed = 1	
		} else
		{
			//running
			sprite_index = spr_legs_arm_recoil
			image_xscale = hinput
			image_speed = 1
		}
		if keyboard_check(vk_up)
		{
			//running and upwards
		shooting_upwards = true
		sprite_index = spr_run_upshooting_recoil
		image_xscale = hinput
		image_speed = 1
			if !place_meeting(x, y+1, obj_wall_in_game)
			{
				//running, jumping and upwards
				sprite_index = spr_jump_up
				image_xscale = hinput
				image_speed = 1
			}
			else 
			{
				//runnig and upwards
				shooting_upwards = true
				sprite_index = spr_run_upshooting_recoil
				image_xscale = hinput
				image_speed = 1
			}
	}
	else
	{
		shooting_upwards = false
		sprite_index = spr_legs_arm_recoil
		image_speed = 1
	}
		if keyboard_check(vk_down)
		{
		shooting_downwards = true
		sprite_index = spr_jump_gun
		image_xscale = hinput
		image_speed = 1
	}
	else
	{
		shooting_downwards = false
		sprite_index = spr_jump_gun
		image_speed = 1
	}
}
	else
{
	sprite_index = spr_idle_shooting_recoil
	image_speed = 1
	image_index = 0
	if keyboard_check(vk_up)
	{
		shooting_upwards = true
		sprite_index = spr_idle_upshooting_recoil
		image_speed = 1
		image_index = 0
	}
	else
	{
		shooting_upwards = false
		sprite_index = spr_idle_shooting_recoil
	}
	if keyboard_check(vk_down) && !place_meeting(x, y+1, obj_wall_in_game) 
	{
	shooting_downwards = true
	sprite_index = spr_jump_gun
	image_speed = 1
	}
	else
	{
		shooting_downwards = false
		sprite_index = spr_idle_shooting_recoil
		image_speed = 1
	}
}
	#endregion
	#region angles and directions
	//if image_xscale = 1 or image_xscale = 0 sostituito con il codice che segue
	//{
	//	bullet_direction = 0
	//}
	//else if image_xscale = -1 
	//{
	//	bullet_direction = 180
	//}
	//if shooting_downwards = 1 
	//{
	//	bullet_direction = 270
	//}
	//if shooting_upwards = 1
	//{
	//	bullet_direction = 45
	//}
	if image_xscale = 1 or image_xscale = 0 
	{
		bullet_direction = shooting_upwards * 45;
		if shooting_downwards
			bullet_direction = 270
		
	} else
	{
		bullet_direction = 180 - shooting_upwards * 45;
		if shooting_downwards
			bullet_direction = 270
		
	}
	#endregion
		#region gun shooting
		if !place_meeting(x, y+1, obj_wall_in_game) && shooting_downwards
	{
	vspeed_ = -10
	} 
	#endregion
	bullet.direction = bullet_direction
	bullet.image_angle = bullet_direction
	alarm[0] = bullet_cooldown
	}	
}

}
}
#endregion
#endregion
#region ammo and ammo variables
if max_ammo > 0
{
if ammo = 0 and ammo_repeat = true
{
alarm[1] = shooting_cooldown
ammo_repeat = false
}
}
switch(current_gun)
{
case 3:
#region alarms
	if alarm[1] = 120
	{
	max_ammo -= 1
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 96
	{
	max_ammo -= 1
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 72
	{
	max_ammo -= 1
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 48
	{
	max_ammo -= 1
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 24
	{
	max_ammo -= 1
	ammo += bullet_for_time
	ammo_repeat = true
	audio_play_sound(handgun_click, 3, false)
	#endregion
	}
break;
case 2:
#region alarms
	if alarm[1] = 120
	{
	max_ammo -= 1
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 96
	{
	max_ammo -= 1
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 72
	{
	max_ammo -= 1
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 48
	{
	max_ammo -= 1
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 24
	{
	max_ammo -= 1
	ammo += bullet_for_time
	ammo_repeat = true
	audio_play_sound(handgun_click, 3, false)
	#endregion
	}
break;

case 4:
	if alarm[1] = 30
	{
	max_ammo -= bullet_for_time
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 0
{
	ammo += bullet_for_time
	ammo_repeat = true
}
	break;
	case 1:
	#region alarms
	if alarm[1] = 60
	{
	max_ammo -= bullet_for_time/2
		ammo += bullet_for_time/2
	audio_play_sound(handgun_click, 3, false)
	}
		if alarm[1] = 30
	{
	max_ammo -= bullet_for_time/2
		ammo += bullet_for_time/2
	audio_play_sound(handgun_click, 3, false)
	}
	if alarm[1] = 0
{
	ammo_repeat = true
}
#endregion
	break;
}
#endregion
#region damage
if health_ = 0 
{
instance_destroy()
}
#endregion
#region dash
var dashing = can_dash and keyboard_check_pressed(vk_control)
//phase 1
if dashing and not (already_dashing or dash_recharging)
{
	dash_goal = x + dash_power * image_xscale
	already_dashing = true
	sprite_index = spr_player_dash
	audio_play_sound(dash, 5, false)
}
//phase 2
if already_dashing and not dash_recharging
{
	vspeed_ = 0
	jump_height = 0
	gravity_ = 0

	dash_move = dash_speed * image_xscale
	if place_meeting(x+dash_move, y, obj_wall_in_game)
	{
		while not place_meeting(x + sign( dash_move), y, obj_wall_in_game)
		{
			x += sign(dash_move)
		}
		dash_move = 0
		already_dashing = false
		dash_recharging = true
	}
	
	x += dash_move
	
	already_dashing = already_dashing and ((image_xscale > 0 and dash_goal > x) or (image_xscale < 0 and dash_goal < x))
	
	dash_recharging = not already_dashing
	if not already_dashing
	{
		alarm[2] = room_speed * 0.2 // stop floating in 0.2 secs
	}
	}
	if  place_meeting(x, y+1, obj_wall_in_game) and alarm[3] = 0
	{
		dash_recharging = false
	}
#endregion
