extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size / 2
var tile_y = 20
var tile_x = 12

enum ENTITY_TYPE {PLAYER, OBSTACLE, COLLECTIBLE}

var grid_size = Vector2(tile_x,tile_y)
var grid = []

onready var Obstacle = preload("res://Obstacle.tscn")


func _ready():
	# 1. Create the grid Array
	for x in range (grid_size.x):
		grid.append([])
		for y in range (grid_size.y):
			grid.append([])
			
	# 2. **COME BACK TO THIS** Create obstacles 
	
	# Create Player
	$Player.start($Player/StartPosition.position)

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
