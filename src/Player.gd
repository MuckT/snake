extends Area2D

#signal hit
var tile_size = 40
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

# Called when the node enters the scene tree for the first time.
func _ready():
#	hide()
	screen_size = get_viewport_rect().size
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	set_direction = 'right'

func move(dir):
	position += inputs[dir] * tile_size
	
# Change direction based on keypress or touche event whenever an event happens.
func _input(event):
	# Exit feature
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	# Touch screen and mouse click movement using radians
	if event is InputEventScreenTouch and event.pressed:
		target = event.position
		current_position = get_position()
		radians =  current_position.angle_to_point(target)
		print(radians)
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
	position.x = clamp(position.x, 20, screen_size.x - 20)
	position.y = clamp(position.y, 20, screen_size.y - 20)
	
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
