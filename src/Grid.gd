extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var tile_y = 18
var tile_x = 12
onready var Collectible = get_node("Collectible")
onready var Player = get_node("Player")

enum ENTITY_TYPE {PLAYER, OBSTACLE, COLLECTIBLE}

var grid_size = Vector2(tile_x,tile_y)
var grid = []

#onready var Collectible = preload("res://Collectible.tscn")


func _ready():
	if OS.get_name()=="HTML5":
		OS.set_window_maximized(true)
	# 1. Create the grid Array
	for x in range (grid_size.x):
		grid.append([])
		for y in range (grid_size.y):
			grid.append([])
			
	# 2. **COME BACK TO THIS** Create obstacles 

	# Create Player
	$Player.start($Player/StartPosition.position)
	
#	TODO make a collectable instance
#	var position
#	var placed = false
#	while not placed:
#		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
#		if not grid[grid_pos.x][grid_pos.y]:
#			position = grid_pos
#			placed = true
#			
#	var new_collectible = Collectible.instance()
#	new_collectible.position = map_to_world(position) + half_tile_size
#	grid[position.x][position.y] = ENTITY_TYPE[2]
	
	

func is_cell_vacant(pos, direction):
	# Return true if the cell is vacant, else false
	var grid_pos = world_to_map(pos) + direction
	
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			if grid[grid_pos.x][grid_pos.y] == null:
				return true
	return false
	


func update_child_pos(child):
	# Move a child to a new position in the grid Array
	# Returns the new target world position of the child
	var grid_pos = world_to_map(child.get_pos())
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_grid_pos = grid_pos + child.direction
	grid[new_grid_pos.x][new_grid_pos.y] = child
	
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos


func new_game():
	$StartTimer.start()
	$Player/Timer.start()
	

func _on_Player_game_over():
	print("game over") # Replace with function body.
