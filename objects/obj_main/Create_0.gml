/// @description Insert description here
// You can write your code in this editor

// Vars!
player_health_max = 7 // The player's max health.
player_health = player_health_max // The player's current health.
player_focus_max = 300 // Max points from grazing.
player_focus = 0 // Points gained from grazing.
text_time = 30 // How many milliseconds does it take for text to advance?
text_time_prev = 0 // Tracking when the last text advance happened
text_breath = 0 // Consecutive non-whitespace character slowly reduce the volume.

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

function add_text(t_color, t_string, t_speaker = "", t_sound = snd_focus) {
	return {
		type: STORY_BEAT.TEXT,
		text: t_string,
		color: t_color,
		speaker: t_speaker,
		sound: t_sound
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
	add_attack("Fireball", 80, c_vella, function(_x, _y) {
		var _nearest = instance_nearest(_x, _y, obj_battle_enemy);
		if (_nearest) {
			_nearest.enemy_health -= 3
			_nearest.damaged = true
			audio_play_sound(snd_hit_slime, 3, false)
		}
	}, function(_x, _y) {
		var _nearest = instance_nearest(_x, _y, obj_battle_enemy);
		if (_nearest) {
			draw_line(_nearest.x - 32, _nearest.y, _nearest.x + 32, _nearest.y)
			draw_line(_nearest.x, _nearest.y - 32, _nearest.x, _nearest.y + 32)
		}
	}),
	add_attack("Explosion", 160, c_vella, function(_x, _y) {
		var _nearest = instance_nearest(_x, _y, obj_battle_enemy);
		if (_nearest) {
			audio_play_sound(snd_hit_slime, 3, false)
			for (var i = 0; i < instance_number(obj_battle_enemy); ++i) {
			   var _target = instance_find(obj_battle_enemy, i)
			   if (point_distance(obj_cursor.x, obj_cursor.y, _target.x, _target.y) < 128 + 32) {
				   _target.enemy_health -= 4
				   _target.damaged = true
			   }
			}
		}
	}, function(_x, _y) {
		draw_circle(_x, _y, 128, true)
	})
]

audio_play_sound(mus_sunlit_thunderscapes_ocularnebula, 10, true)

story_index = 30 // The current bit of the story we're on.
story_text_pos = 0 // And the position of the text to render.
story = [
	add_text(c_white, "A 24 hour game jam project by Wonda.\n\nUse Left Mouse Button to advance the story."),
	add_text(c_white, "It was a night like any other..."),
	add_text(c_white, "Four individuals are huddled around a table in a lab.\n\nCharacter sheets and game dice litter the room."),
	add_text(c_ranna, "Alright, Vella. Now that you have your character sheet, let's try out a simple little combat encounter.", "Ranna", snd_voice_ranna),
	add_text(c_triff, "Do you have to go through this entire thing for her?\nWe're wasting precious time.", "Triff", snd_voice_triff),
	add_text(c_ranna, "It wouldn't hurt to teach her.", "Ranna", snd_voice_ranna),
	add_text(c_august, "You must trust the gods, Thorn!\nTheir judgement is important.", "August", snd_voice_august),
	add_text(c_triff, "Then give her the tutorial.", "Thorn (Triff)", snd_voice_triff),
	add_text(c_ranna, "Okay, then...", "Ranna", snd_voice_ranna),
	add_text(c_ranna, "Slimes emerged from the entrance of the dungeon.\n\nYou must focus your magic and blast them away!", "GM (Ranna)", snd_voice_ranna),
	add_text(c_ranna, "You have to stay close to the enemy to focus them.", "GM (Ranna)", snd_voice_ranna),
	add_text(c_ranna, "But don't stay too close, or they will attack you.", "GM (Ranna)", snd_voice_ranna),
	add_text(c_ranna, "With enough focus, you can select one of your spells and cast it at the slimes.", "GM (Ranna)", snd_voice_ranna),
	add_text(c_ranna, "If you deal enough damage, you will kill the slime.", "GM (Ranna)", snd_voice_ranna),
	add_text(c_ranna, "Defeat all of them, and you will win the encounter.", "GM (Ranna)", snd_voice_ranna),
	add_text(c_triff, "And if you don't...", "Thorn (Triff)", snd_voice_triff),
	add_text(c_triff, "You'll have to write an essay on why you failed.", "Thorn (Triff)", snd_voice_triff),
	add_text(c_ranna, "(Knock it off.)\n\nGood luck, Vella.", "GM (Ranna)", snd_voice_ranna),
	add_battle(function() {
		for (var i = 0; i < 2; ++i) {
			var _w = room_width
			var _h = room_height
		    instance_create_depth(random_range(_w * 0.3, _w * 0.7), random_range(_h * 0.3, _h * 0.7), 0, obj_battle_enemy, {
				speed: 1,
				create: function() {},
				step: function() {
					with(other) {
						if (move_timer < current_time || !_withinBounds) {
							direction = lerp(direction, random_range(0, 360), 0.95)
							move_timer = current_time + 1000
						}
					}
				},
				draw: function() {
					with(other) {
						draw_set_color(damaged ? c_white : c_red)
						draw_circle(x, y, 24, true)
						var _xx = x + lengthdir_x(8, direction)
						var _yy = y + lengthdir_y(8, direction)
						draw_line(_xx - 8, _yy - 8, _xx - 8, _yy + 8)
						draw_line(_xx + 8, _yy - 8, _xx + 8, _yy + 8)
					}
				}
			})
		}
	}, attacks),
	add_text(c_august, "Excellent work, O...\n\nWait, what was your character's name again, Vella?", "August", snd_voice_august),
	add_text(c_vella, "Uhm... I think I wrote it down as...\n\nVert?", "Vella", snd_voice_vella),
	add_text(c_august, "Excellent work, O great Vert!\nYou have the bones in you for a wonderful mage.", "August", snd_voice_august),
	add_text(c_vella, "Thank you...", "Vert (Vella)", snd_voice_vella),
	add_text(c_ranna, "With the slimes defeated, you delve into the dungeon proper.", "GM (Ranna)", snd_voice_ranna),
	add_text(c_ranna, "The decrepit lobby is filled with a stagnant air. Stonework, cracked and worn with age. Tablets of unknown glyphs are framed by layers of mold.\nWhat do you do?", "GM (Ranna)", snd_voice_ranna),
	add_text(c_triff, "I obviously review the tablets. I'm the linguistics professor, after all.", "Thorn (Triff)", snd_voice_triff),
	add_text(c_ranna, "*You* know linguistics.\nThorn, meanwhile, doesn't know anything except Common.", "GM (Ranna)", snd_voice_ranna),
	add_text(c_triff, "Well. I... run my hand against the wall and... deduce that the markings must mean something. Then I associate those meanings with patterns and--", "Thorn (Triff)", snd_voice_triff),
	add_text(c_ranna, "And ghosts leap out from the wall! Roll for initiative.", "GM (Ranna)", snd_voice_ranna),
	add_battle(function() {
		for (var i = 0; i < 3; ++i) {
			var _w = room_width
			var _h = room_height
		    instance_create_depth(random_range(_w * 0.3, _w * 0.7), random_range(_h * 0.3, _h * 0.7), 0, obj_battle_enemy, {
				speed: 0.8 + (i * 0.3),
				create: function() {},
				step: function() {
					with(other) {
						if (move_timer < current_time || !_withinBounds) {
							direction = point_direction(x, y, obj_cursor.x, obj_cursor.y)
							move_timer = current_time + 100
						}
					}
				},
				draw: function() {
					with(other) {
						draw_set_color(damaged ? c_white : c_red)
						draw_circle(x, y, 24, true)
						var _xx = x + lengthdir_x(8, direction)
						var _yy = y + lengthdir_y(8, direction)
						draw_line(_xx - 8, _yy - 8, _xx - 8, _yy + 8)
						draw_line(_xx + 8, _yy - 8, _xx + 8, _yy + 8)
						draw_line(x - 32, y - 32, x - 24, y - 24)
						draw_line(x + 32, y - 32, x + 24, y - 24)
					}
				}
			})
		}
	}, attacks),
	add_text(c_august, "It's always ancient glyphs that are cursed. You better stop touching those things, Thorn.", "August", snd_voice_august),
	add_text(c_triff, "Hey! It's not my fault that Ranna keeps trapping every one of them, August!", "Thorn (Triff)", snd_voice_triff),
	add_text(c_august, "It's April, thank you.", "August", snd_voice_august),
	add_text(c_vella, "Now that the ghosts are gone,\nwhat do we do?", "Vert (Vella)", snd_voice_vella),
	add_text(c_white, "End of demo.\n\nI wanted to make sure what we had was good."),
	add_text(c_white, "This game jam ended up being the perfect opprotunity to test out mechanics relevant to Slime Slayers."),
	add_text(c_white, "Since I've tested how these mechanics feel, I can now make a better decision where I want to take this project of mine."),
	add_text(c_white, "This was very, very fun. I'm glad I got to spend these 24 hours with y'all."),
	add_text(c_white, "As for credits..."),
	add_text(c_white, "The song is Sunlit Thunderscapes by OcularNebula.\nTheir music is under CC BY-NC license, which makes it free game for use in the jam.\nGo listen to their other music! Especially Reedz.", "Music Credits"),
	add_text(c_white, "Gamemaker 2022\nThe only IDE that is ergonomic for my brain. I've sunk countless hours into it, and I have a feeling I'll sink many, many more.", "Tool Credits"),
	add_text(c_white, "Bfxr\nStar reminded me that this tool existed, and it's so lovely for making noises. You define a bunch of parameters and it makes cute blips.", "Tool Credits"),
	add_text(c_white, "Special thanks to all my friends who are kind of responsible for the characters here.\n\nMeow at me to make more Slime Slayers things!", "Special Thanks"),
	add_text(c_white, ". . ."),
	add_text(c_white, "That's it.\nThere's not another combat encounter here."),
	add_text(c_white, "We can close the game right now.\n\nIf that's fine with you."),
	add_text(#ffe998, "Thank you for playing.", "Wonda", snd_voice_ranna),
	add_battle(function() {
		game_end()
	}, []),
]