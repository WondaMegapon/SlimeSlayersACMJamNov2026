/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_white)
draw_set_alpha(0.5)
draw_circle(mouse_x, mouse_y, 4, true)
draw_set_alpha(1.0)

if (iframes < current_time || current_time % 2 == 0) {
	draw_set_color(obj_main.c_vella)
	draw_circle(x, y, 6, false)
	draw_set_color(c_white)
	draw_circle(x, y, 4, false)
	
	var _nearest_enemy = instance_nearest(x, y, obj_battle_enemy)
	if(_nearest_enemy) {
		var _distance = point_distance(x, y, _nearest_enemy.x, _nearest_enemy.y)
		draw_set_alpha(48 / max(0.01,  _distance) - 0.2)
		draw_circle(x, y, 24, true)
	}
	draw_set_alpha(1.0)
}