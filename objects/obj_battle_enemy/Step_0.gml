/// @description Insert description here
// You can write your code in this editor

var _bounds = 128
if (move_timer < current_time || x < _bounds || x > room_width - _bounds || y < _bounds || y > room_height - _bounds) {
		direction = lerp(direction, random_range(0, 360), 0.8)
		move_timer += 1000
}

if (enemy_health <= 0) {
	instance_destroy()	
}