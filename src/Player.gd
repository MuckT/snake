extends Area2D

signal game_over

onready var tail = preload("res://Tail.tscn")

#signal hit
var tile_size = 40
var half_tile_size = tile_size / 2
var inputs = {
	"right": Vector2.RIGHT, "left": Vector2.LEFT, 
	"up": Vector2.UP, "down": Vector2.DOWN
}

export var speed = 40  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

# Add this variable to hold the clicked position.
var target = Vector2()
var current_position = Vector2()
var current_direction = String() 
var set_direction = String()
var raw_direction = Vector2()
var radians = float()
var Grid
var last_direction = Vector2(1,0)
var last_position = Vector2(0,0)
var gap = 20

# Called when the node enters the scene tree for the first time.
func _ready():
#	hide()
	screen_size = get_viewport_rect().size
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	set_direction = 'right'
	Grid = get_parent()
	var inst = tail.instance()
	var temp_grid_pos = Grid.world_to_map(position)
#	temp_grid_pos.x -= 1
	inst.position = Grid.map_to_world(temp_grid_pos)
#	#inst.position.x = clamp(position.x, half_tile_size, screen_size.x - half_tile_size)
#	#inst.position.y = clamp(position.y, half_tile_size, screen_size.y - half_tile_size)
	add_child(inst)



func move(dir):
	# set dir_change
	var dir_change = false
	if last_direction != inputs[dir]:
		dir_change = true
	# Hold previous positions to check for game end
	last_position = position
	last_direction = inputs[dir]
#	print(dir_change)
#    print(last_position)
	# Change position based on direction
	var head_pos = position
#	if dir_change:
#		for i in range (4,get_child_count()):
#			get_child(i).add_to_tail(head_pos, inputs[dir])
	for i in range(get_child_count() - 1, 4, -1):
#		print(get_child(i).name)
		get_child(i).global_position = get_child(i - 1).global_position
		get_child(i).position -= inputs[dir] * tile_size
	get_child(4).global_position = global_position
#		print(i)
	position += inputs[dir] * tile_size
#		var inst = get_child(4)
#		var temp_grid_pos = Grid.world_to_map(position)
#		if inputs[dir] == Vector2.RIGHT:
#			temp_grid_pos.x -= 2
#		if inputs[dir] == Vector2.DOWN:
#			temp_grid_pos.y -= 1

#		print(temp_grid_pos)
#		inst.position = Grid.map_to_world(temp_grid_pos)

	
	
# Change direction based on keypress or touche event whenever an event happens.
func _input(event):
	#keep track of last direction
	# Exit feature
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	# Touch screen and mouse click movement using radians
	if event is InputEventScreenTouch and event.pressed:
		target = event.position
		current_position = get_position()
		radians =  current_position.angle_to_point(target)
		if radians < PI/4 and radians >= -PI/4:
			set_direction =  'left'
		elif radians < -PI/4 and radians >= -3 * PI/4:
			set_direction =  'down'
		elif radians >= PI/4 and radians < 3 * PI/4:
			set_direction =  'up'
		else:
			set_direction =  'right'

	# Mouse W,A,S,D / Arrow key movement
	if Input.is_action_just_pressed("ui_right"):
		set_direction = 'right'
	if Input.is_action_just_pressed("ui_down"):
		set_direction = 'down'
	if Input.is_action_just_pressed("ui_left"):
		set_direction = 'left'
	if Input.is_action_just_pressed("ui_up"):
		set_direction = 'up'
	


func _process(delta):
	position.x = clamp(position.x, half_tile_size, screen_size.x - half_tile_size)
	position.y = clamp(position.y, half_tile_size, screen_size.y - half_tile_size)
	if(last_position == position):
		print("END GAME")
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	current_direction = 'right'
	
func _on_Timer_timeout():
	# Check that most recent set direction was a double back on snek
	if set_direction == 'right' and current_direction != 'left':
		current_direction = set_direction
	if set_direction == 'down' and current_direction != 'up':
		current_direction = set_direction
	if set_direction == 'left' and current_direction != 'right':
		current_direction = set_direction
	if set_direction == 'up' and current_direction != 'down':
		current_direction = set_direction
	move(current_direction)
	

# Attempting my own tail
func add_tail():
	var inst = tail.instance()
	var prev_tail = get_child(get_child_count() -1 ) 
#	print(prev_tail.name)
	if(prev_tail.name != "head"):
		inst.cur_dir = prev_tail.cur_dir
		for i in range(0,prev_tail.pos_array.size()):
			inst.pos_array.append(prev_tail.pos_array[i])
			inst.directions.append(prev_tail.directions[i])
		inst.position = prev_tail.position + prev_tail.cur_dir * gap
	else:
		inst.cur_dir = current_direction
		inst.position = prev_tail.position + current_direction * gap
	add_child(inst)


func _on_Collectible_area_entered(area):
	if area.get_parent().name.begins_with("Grid"):
		print("Add Tail")
		add_tail()
	print("Collide: ", area.get_parent().name)
