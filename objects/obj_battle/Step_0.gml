/// @description Insert description here
// You can write your code in this editor

// Aborting things if we're out of enemies.
if(instance_number(obj_battle_enemy) <= 0) {
	instance_destroy()
}

// Running spellcasting.
if (mouse_check_button_pressed(mb_left) && selected_attack_index >= 0 && hover_attack_index == -1 && obj_main.player_focus >= attacks[selected_attack_index].cost) {
	attacks[selected_attack_index].func(obj_cursor.x, obj_cursor.y)
	obj_main.player_focus -= attacks[selected_attack_index].cost
	audio_play_sound(snd_spell_cast, 4, false)
	if(obj_main.player_focus < attacks[selected_attack_index].cost) selected_attack_index = -1
}

if (mouse_check_button_pressed(mb_left) && hover_attack_index >= 0 && obj_main.player_focus >= attacks[hover_attack_index].cost) {
	selected_attack_index = hover_attack_index
	audio_play_sound(snd_spell_select, 4, false)
}