/// @description Insert description here
// You can write your code in this editor

// Vars!
player_health_max = 5 // The player's max health.
player_health = player_health_max // The player's current health.
player_damage = 1 // The damage the player does.
player_focus_max = 600 // Max points from grazing.
player_focus = 0 // Points gained from grazing.
world_difficulty = 0 // Wawa

// Colors?
c_ranna = #fc2c03
c_vella = #00a105
c_triff = #ff2190
c_august = #ffae21

// Creating our test objects.
instance_create_depth(x, y, depth - 2, obj_cursor) // The lovely cursor.

// For attacky things.
function add_attack(a_name, a_cost, a_color, a_func, a_draw) {
	return {
		name: a_name,
		cost: a_cost,
		color: a_color,
		func: a_func,
		draw: a_draw,
	}
}

// Handling story stuff.
enum STORY_BEAT {
	TEXT,
	BATTLE
}

function add_text(t_index, t_color, t_string) {
	return {
		type: STORY_BEAT.TEXT,
		text: t_string,
		color: t_color,
		index: t_index
	}
}

function add_battle(b_spawn, b_attacks) {
	return {
		type: STORY_BEAT.BATTLE,
		spawn: b_spawn,
		attacks: b_attacks
	}
}

attacks = [
	add_attack("Fireball", 50, c_vella, function(_x, _y) {
		var _nearest = instance_nearest(_x, _y, obj_battle_enemy);
		if (_nearest) {
			_nearest.enemy_health -= 3	
		}
	}, function(_x, _y) {
		var _nearest = instance_nearest(_x, _y, obj_battle_enemy);
		if (_nearest) {
			draw_line(_nearest.x - 32, _nearest.y, _nearest.x + 32, _nearest.y)
			draw_line(_nearest.x, _nearest.y - 32, _nearest.x, _nearest.y + 32)
		}
	}),
	add_attack("Explosion", 200, c_vella, function(_x, _y) {
		var _nearest = instance_nearest(_x, _y, obj_battle_enemy);
		if (_nearest) {
			obj_battle_enemy.enemy_health -= 2
		}
	}, function(_x, _y) {
		draw_circle(_x, _y, 128, true)
	})
]

story_index = 0 // The current bit of the story we're on.
story_text_pos = 0 // And the position of the text to render.
story = [
	add_text(1, c_white, "Slime Slayers\nA 24 hour game jam project by Wonda.\n\nMade with love. <3"),
	add_text(0, c_white, "It was a night like any other..."),
	add_text(0, c_white, "Four individuals are huddled around a table in a lab.\nCharacter sheets and game dice litter the room."),
	add_text(0, c_ranna, "Here, Vella. Let's try out a simple little combat encounter."),
	add_text(0, c_ranna, "Two slimes appear from the entrance of the dungeon!\nYou must focus your magic and blast them away!"),
	add_battle(function() {
		for (var i = 0; i < 2; ++i) {
			var _w = window_get_width()
			var _h = window_get_height()
		    instance_create_depth(random_range(_w * 0.2, _w * 0.8), random_range(_h * 0.2, _h * 0.8), 0, obj_battle_enemy)
		}
	}, attacks),
	add_text(0, c_white, "The end."),
	add_text(0, c_white, "..."),
	add_text(0, c_white, "No, that's it. There's not another combat encounter here or anything."),
	add_text(0, c_white, "Heck we'll just like... close the game right now."),
	add_text(0, c_white, "As a treat."),
	add_battle(function() {
		game_end()
	}, []),
]