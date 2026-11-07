/// @description Insert description here
// You can write your code in this editor

// Aborting things if we're out of enemies.
if(instance_number(obj_battle_enemy) <= 0) {
	instance_destroy()
}

// Running spellcasting.
if (mouse_check_button_pressed(mb_left) && selected_attack_index >= 0 && hover_attack_index == -1 && obj_main.player_focus >= attacks[selected_attack_index].cost) {
	attacks[selected_attack_index].func(x, y)
	obj_main.player_focus -= attacks[selected_attack_index].cost
	if(obj_main.player_focus < attacks[selected_attack_index].cost) selected_attack_index = -1
}

if (mouse_check_button_pressed(mb_left) && hover_attack_index >= 0 && obj_main.player_focus >= attacks[hover_attack_index].cost) {
	selected_attack_index = hover_attack_index
}