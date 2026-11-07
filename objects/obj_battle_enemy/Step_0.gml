/// @description Insert description here
// You can write your code in this editor

_bounds = 128
_withinBounds = point_in_rectangle(x, y, _bounds, _bounds, room_width - _bounds, room_height - _bounds)
step()

if (enemy_health <= 0) {
	instance_destroy()	
}