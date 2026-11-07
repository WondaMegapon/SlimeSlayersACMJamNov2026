/// @description Insert description here
// You can write your code in this editor

draw()
draw_rectangle(x - 20, y - 38, x + 20, y - 32, true)
draw_rectangle(lerp(x + 18, x - 18, clamp(enemy_health / enemy_health_max, 0, enemy_health_max)), y - 36, x + 18, y - 34, false)
draw_set_color(c_white)
damaged = false