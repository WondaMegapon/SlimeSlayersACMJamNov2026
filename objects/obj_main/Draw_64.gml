/// @description Insert description here
// You can write your code in this editor

if(story[story_index].type == STORY_BEAT.TEXT) {
	draw_sprite(spr_story, story[story_index].index, 0, 0)
	var _substring = string_copy(story[story_index].text, 0, clamp(story_text_pos, 0, string_length(story[story_index].text)))
	draw_set_color(c_black)
	draw_set_alpha(0.5)
	draw_rectangle(0, room_height * 0.7, room_width, room_height, false)
	draw_set_color(c_white)
	draw_set_alpha(1.0)
	draw_set_font(fnt_story)
	draw_text_ext_color(32, room_height * 0.7 + 24, _substring, 32, room_width - 64, story[story_index].color, story[story_index].color, c_white, c_white, 1.0)
}