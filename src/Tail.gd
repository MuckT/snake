extends Area2D

signal end_game

var directions = []
var pos_array = []
var cur_dir = Vector2()
var game_started = false


func add_to_tail(head_pos, dir):
	print("add to tail")
	pos_array.append(head_pos)
	directions.append(dir)

func _on_Tail_area_shape_entered(area_id, area, area_shape, self_shape):
	print(area)
	print(self_shape)
	print(area.name)
	if area.name.begins_with("Player"):
		if game_started == false:
			game_started = true
		else:
#			get_parent().get_tree().reload_current_scene()
			print("End Game From Tail")
#		get_tree().reload_current_scene()
