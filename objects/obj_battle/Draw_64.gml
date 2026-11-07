/// @description Insert description here
// You can write your code in this editor
// Targetting stuff for attacks.
if (selected_attack_index > -1) {
	attacks[selected_attack_index].draw(obj_cursor.x, obj_cursor.y)
}

// Debug UI.
draw_set_font(fnt_battle)
draw_text(16, 16, string("HP: {0}/{1}", obj_main.player_health, obj_main.player_health_max))
draw_text(16, 32, string("FP: {0}/{1}", obj_main.player_focus, obj_main.player_focus_max))

// Silly things.
var _width = 128
var _height = 32
var _padding = 2
var _margin = 16

// THE BUTTONS... and health.
hover_attack_index = -1
for(var i = 0; i < array_length(attacks); i++) {
	var _activeColor = attacks[i].color
	var _inactiveColor = merge_color(attacks[i].color, c_black, 0.25)
	var _bgColor = merge_color(attacks[i].color, c_black, 0.75)
	var _aboveCost = obj_main.player_focus >= attacks[i].cost
	var _x1 = _margin
	var _x2 = _margin + _width
	var _y1 = _margin + i * ( _height + _margin)
	var _y2 = _margin + _height + i * (_height + _margin)
	var _cursorOver = point_in_rectangle(window_mouse_get_x(), window_mouse_get_y(), _x1, _y1, _x2, _y2)
	var _cursorSelected = selected_attack_index == i
	if (_cursorOver) hover_attack_index = i
	draw_set_color(_aboveCost ? (_cursorOver ? c_yellow : (_cursorSelected ? c_red : _activeColor)) : _inactiveColor)
	draw_rectangle(_x1, _y1, _x2, _y2, false)
	draw_set_color(c_black)
	draw_rectangle(_x1 + _padding, _y1 + _padding, _x2 - _padding, _y2 - _padding, false)
	draw_set_color(_bgColor)
	draw_rectangle(_x1 + _padding, _y1 + _padding, lerp(_x1 + _padding, _x2 - _padding, clamp(obj_main.player_focus / attacks[i].cost, 0.0, 1.0)), _y2 - _padding, false)
	draw_set_color(_aboveCost ? (_cursorOver ? c_yellow : (_cursorSelected ? c_red : _activeColor)) : _inactiveColor)
	draw_text(_x1 + _margin, _y1 + (_height * 0.5) - 8, attacks[i].name)
}

draw_set_color(c_white)
draw_rectangle(_margin, room_height - _height - _margin, room_width - _margin, room_height - _margin, false)
draw_set_color(c_black)
draw_rectangle(_margin + _padding, room_height - _height - _margin + _padding, room_width - _margin - _padding, room_height - _margin - _padding, false)
draw_set_color(c_dkgray)
draw_rectangle(_margin + _padding, room_height - _height - _margin + _padding, lerp(_margin + _padding, room_width - _margin - _padding, clamp(obj_main.player_focus / obj_main.player_focus_max, 0.0, 1.0)), room_height - _margin - _padding, false)