extends Area2D

var tile_size = 40
var tile_x = 12
var tile_y = 18


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
#	$Grid.grid[position.x][position.y] = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func new_collectible():
	randomize()
	var new_position = Vector2(randi() % 440, randi() % 690)
	position = new_position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	print(position)
	show()
#	$CollisionShape2D.set_deferred("disabled",false)


func _on_Collectible_area_entered(area):
	#hide the collectible and then place it somewhere else
	hide()
#	$CollisionShape2D.set_deferred("disabled",true)
	new_collectible()
