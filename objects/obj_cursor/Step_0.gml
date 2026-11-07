/// @description Insert description here
// You can write your code in this editor

// Handling movement.
var _x = lerp(x, mouse_x, 0.6)
var _y = lerp(y, mouse_y, 0.6)
_x = clamp(_x, 0, room_width)
_y = clamp(_y, 0, room_height)

x = _x
y = _y

// If we aren't in a battle.
if !instance_exists(obj_battle) return;

// Handling Focus & Damage.
var _nearest_enemy = instance_nearest(x, y, obj_battle_enemy)
if(_nearest_enemy && iframes < current_time) {
	var _distance = point_distance(x, y, _nearest_enemy.x, _nearest_enemy.y)
	if(_distance < 52) {
		obj_main.player_focus = clamp(0, obj_main.player_focus_max, obj_main.player_focus + 1) // Awarding Focus
		audio_play_sound(snd_focus, 0, false)
	}
	if(_distance < 24) {
		obj_main.player_health = clamp(0, obj_main.player_health_max, obj_main.player_health - 1) // Hurting the player.
		audio_play_sound(snd_hit_player, 5, false)
		iframes = current_time + 1000
	}
}