extends Area2D

var tile_size = 40
var tile_x = 12
var tile_y = 18
var Grid


# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
#	$Grid.grid[position.x][position.y] = 2
	Grid = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func new_collectible():
	randomize()
	var new_position = Vector2(randi() % 440, randi() % 690)
	position = new_position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
#	print(position)
	show()
	var pos = Grid.world_to_map(position)
#	print(pos)


func _on_Collectible_area_entered(area):
	hide()
	new_collectible()
#	print("Area id from collectable: ", area)
#	print("Area name from collectable: ", area.get_parent().name)
#	TODO place again collectible if on snake
#	if area.get_parent().name.begins_with("Grid"):
#		#hide the collectible and then place it somewhere else
#		score -= 1

