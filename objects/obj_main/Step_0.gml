/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(vk_f4)) {
	window_set_fullscreen(!window_get_fullscreen())	
}

if (keyboard_check_pressed(vk_escape)) {
	game_end()	
}

if (player_health <= 0) {
	game_restart()	
}

if ((mouse_check_button_pressed(mb_left) || mouse_check_button(mb_middle)) && (!instance_exists(obj_battle))) {
	if (story_text_pos >= string_length(story[story_index].text)) {
		story_index++ // Incrementing the current bit of the story.
		story_text_pos = 0 // Resetting text position.
		if (story[story_index].type == STORY_BEAT.BATTLE) {
			instance_create_depth(x, y, depth - 1, obj_battle, {
				spawn: story[story_index].spawn,
				attacks: story[story_index].attacks
			})  // Yay the battle.	
		}
	} else {
		story_text_pos = string_length(story[story_index].text)
	}
}

if (story[story_index].type == STORY_BEAT.TEXT && story_text_pos < string_length(story[story_index].text) && text_time_prev < current_time) {
	story_text_pos++
	switch(string_char_at(story[story_index].text, story_text_pos)) {
		case " ":
		case "\n":
			break;
		default:
			audio_play_sound(story[story_index].sound, 0, false, 1.0, 0.0, 1.0 + random_range(-0.02, 0.01))
	}
	text_time_prev = current_time + text_time
}