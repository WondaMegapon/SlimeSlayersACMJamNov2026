/// @description Insert description here
// You can write your code in this editor

// Vars!
player_health_max = 5 // The player's max health.
player_health = player_health_max // The player's current health.
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

function add_text(t_index, t_color, t_string, t_speaker = "") {
	return {
		type: STORY_BEAT.TEXT,
		text: t_string,
		color: t_color,
		index: t_index,
		speaker: t_speaker
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
	add_text(1, c_white, "A 24 hour game jam project by Wonda.\n\nMade with love. <3"),
	add_text(0, c_white, "It was a night like any other..."),
	add_text(2, c_white, "Four individuals are huddled around a table in a lab.\nCharacter sheets and game dice litter the room.\nPlanning fills the air."),
	add_text(3, c_ranna, "Here, Vella. Let's try out a simple little combat encounter.", "Ranna"),
	add_text(4, c_triff, "Do you have to make it easy for her?\nWe're wasting precious time.", "Triff"),
	add_text(4, c_ranna, "It wouldn't hurt to teach her.", "Ranna"),
	add_text(5, c_august, "You must trust the gods, Thorn! Their judgement is key.", "August"),
	add_text(6, c_triff, "Then give her the tutorial!", "Thorn (Triff)"),
	add_text(7, c_ranna, "Okay, then...", "Ranna"),
	add_text(8, c_ranna, "Two slimes appear from the entrance of the dungeon.\n\nYou must focus your magic and blast them away!", "GM (Ranna)"),
	add_text(9, c_ranna, "You have to stay close to the enemy to focus onto them.", "GM (Ranna)"),
	add_text(10, c_ranna, "But don't stay too close, otherwise they will attack you.", "GM (Ranna)"),
	add_text(11, c_ranna, "With enough focus, you can select one of your spells and cast it at the slimes.", "GM (Ranna)"),
	add_text(12, c_ranna, "If you deal enough damage, you will incapacitate the enemy.", "GM (Ranna)"),
	add_text(13, c_ranna, "Defeat all of them, and you will win the encounter.", "GM (Ranna)"),
	add_text(14, c_triff, "And if you don't...", "Thorn (Triff)"),
	add_text(15, c_triff, "You will have to write an essay on why you have failed.", "Thorn (Triff)"),
	add_text(16, c_ranna, "(Knock it off.)\n\nGood luck, Vella.", "GM (Ranna)"),
	add_battle(function() {
		for (var i = 0; i < 2; ++i) {
			var _w = room_width
			var _h = room_width
		    instance_create_depth(random_range(_w * 0.3, _w * 0.7), random_range(_h * 0.3, _h * 0.7), 0, obj_battle_enemy)
		}
	}, attacks),
	add_text(0, c_august, "Excellent work, O...\n\nWait, what was your name again, Vella?", "August"),
	add_text(0, c_vella, "Uhm... I think I wrote it down as...\n\nVert?", "Vella"),
	add_text(0, c_august, "Excellent work, O great Vert!\nYou have the bones in you for a wonderful mage.", "August"),
	add_text(0, c_vella, "Thank you...", "Vert (Vella)"),
	add_text(0, c_ranna, "With the slimes defeated, you delve into the dungeon proper.", "GM (Ranna)"),
	add_text(0, c_ranna, "The decrepit lobby is filled with a stagnant air. Stonework, cracked and worn with age. Tablets of unknown glyphs are framed by layers of mold.\nWhat do you do?", "GM (Ranna)"),
	add_text(0, c_triff, "I obviously review the tablets. I know linguistics, after all.", "Thorn (Triff)"),
	add_text(0, c_ranna, "*You* know linguistics. Thorn, meanwhile, doesn't know anything except Common.", "GM (Ranna)"),
	add_text(0, c_triff, "Well. I... run my hand against the wall and... deduce that the markings must mean something. Then I associate those meanings with patterns and--", "Thorn (Triff)"),
	add_text(0, c_ranna, "And ghosts leap out from the wall! Roll for initiative.", "GM (Ranna)"),
	add_battle(function() {
		//for (var i = 0; i < 2; ++i) {
		//	var _w = room_width
		//	var _h = room_width
		//    instance_create_depth(random_range(_w * 0.3, _w * 0.7), random_range(_h * 0.3, _h * 0.7), 0, obj_battle_enemy)
		//}
	}, attacks),
	add_text(0, c_august, "It's always ancient glyphs that are cursed. You better stop touching those things, Thorn.", "August"),
	add_text(0, c_triff, "Hey! It's not my fault that Ranna keeps trapping every one of them, August!", "Thorn (Triff)"),
	add_text(0, c_august, "It's April, thank you.", "August"),
	add_text(0, c_august, "What now, that the ghosts are gone?", "April (August)"),
	add_text(0, c_white, "End of demo."),
	add_text(0, c_white, "..."),
	add_text(0, c_white, "No, that's it. There's not another combat encounter here or anything."),
	add_text(0, c_white, "Heck we'll just like... close the game right now."),
	add_text(0, c_white, "As a treat."),
	add_battle(function() {
		game_end()
	}, []),
]