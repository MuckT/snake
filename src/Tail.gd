extends Area2D

var directions = []
var pos_array = []
var cur_dir = Vector2()

func _process(delta):
#	print(pos_array)
#	print("global position: ", global_position)
	if(directions.size() > 0):
		if(global_position.distance_squared_to(pos_array[0]) < 0.01):
			cur_dir = directions[0]
			print("calling remove from tail")
			remove_from_tail()
	position += cur_dir/2
#	print("position after: ", position)

func remove_from_tail():
	directions.pop_front()
	pos_array.pop_front()

func add_to_tail(head_pos, dir):
	print("add to tail")
	pos_array.append(head_pos)
	directions.append(dir)

#func _on_tail_area_entered(area):
#	if(area.name == "head"):
#		get_tree().reload_current_scene()


func _on_Tail_area_entered(area):
	print("Area name from tail: ", area.get_parent().name)
	if area.get_parent().name.begins_with("Player"):
		print("Tail Impact")
	pass

#	emit_signal("end_game")
