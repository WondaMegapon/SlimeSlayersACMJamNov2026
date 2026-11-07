/// @description Insert description here
// You can write your code in this editor

draw_set_font(fnt_story)

if(game_over) {
	var _text = "Game Over"
	draw_text_ext_color(room_width * 0.5 - string_width(_text) * 0.5, room_height * 0.5 - string_height(_text) * 0.5, _text, 24, room_width, c_vella, c_vella, c_white, c_white, 1.0)
}

if(story[story_index].type == STORY_BEAT.TEXT) {
	draw_sprite(spr_story, story_index, 0, 0)
	var _substring = string_copy(story[story_index].text, 0, clamp(story_text_pos, 0, string_length(story[story_index].text)))
	draw_set_color(c_black)
	draw_set_alpha(0.8)
	draw_rectangle(32, room_height * 0.7 - 24, 256, room_height * 0.7 - 1, false)
	draw_rectangle(0, room_height * 0.7, room_width, room_height, false)
	draw_set_color(c_white)
	draw_set_alpha(1.0)
	draw_text_ext_color(32 + 8, room_height * 0.7 - 24, story[story_index].speaker, 32, room_width - 64, story[story_index].color, story[story_index].color, c_white, c_white, 1.0)
	draw_text_ext_color(32, room_height * 0.7 + 24, _substring, 32, room_width - 64, story[story_index].color, story[story_index].color, c_white, c_white, 1.0)
}