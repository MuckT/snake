extends Area2D

#signal hit
var tile_size = 40
var inputs = {"right": Vector2.RIGHT, "left": Vector2.LEFT, "up": Vector2.UP, "down": Vector2.DOWN}

export var speed = 40  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

# Add this variable to hold the clicked position.
var target = Vector2()
var current_position = Vector2()
var current_direction = Vector2()
var raw_direction = Vector2()
var radians = float()



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	hide()
	screen_size = get_viewport_rect().size
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	
#func _unhandled_input(event):
#	for dir in inputs.keys():
#		if event.is_action_pressed(dir):
#			move(dir)

func move(dir):
	position += inputs[dir] * tile_size
	
# Change the target whenever a touch event happens.
func _input(event):
	# Touch screen and mouse click movement using radians
	if event is InputEventScreenTouch and event.pressed:
		target = event.position
		current_position = get_position()
		print()
		print("Direction")
		radians =  current_position.angle_to_point(target)
		print(radians)
	
		if radians < PI/4 and radians >= -PI/4:
			print('left')
			move('left')
		elif radians < -PI/4 and radians >= -3 * PI/4:
			print('down')
			move('down')
		elif radians >= PI/4 and radians < 3 * PI/4:
			print('up')
			move('up')
		else:
			print('right')
			move('right')
	
	# Mouse W,A,S,D - Arrow key movement
	if Input.is_action_just_pressed("ui_right"):
		move("right")
		print(event)
	if Input.is_action_just_pressed("ui_down"):
		move("down")
		print(event)
	if Input.is_action_just_pressed("ui_left"):
		move("left")
		print(event)
	if Input.is_action_just_pressed("ui_up"):
		move("up")
		print(event)
		
		
func _process(delta):
	position.x = clamp(position.x, 20, screen_size.x - 20)
	position.y = clamp(position.y, 20, screen_size.y - 20)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
#	if event.pressed == 'down':
#		print('Move Down')
#	for dir in inputs.keys():
#		if event.is_action_pressed(dir):
#			move(dir)
#	if event is InputEventScreenTouch and event.pressed:
#		target = event.position
#		current_position = get_position()
#		print()
#		print("Direction")
#		degrees =  current_position.angle_to(target)
#		print(degrees)
#		raw_direction = polar2cartesian(float(current_position.distance_to(target)), float(current_position.angle_to(target)))
##		degrees = raw_direction.de
#		print("Polar2cartesian:")
#		print(raw_direction)
#		if degrees <= 180 and degrees > 90:
#			print('right')
#			print(degrees)
#		if degrees > 180 and degrees <= 270:
#			print('down')
#			print(degrees)
#		if degrees <= 90:
#			print('up')
#			print(degrees)
#		if degrees > 270:
#			print('left')
#			print(degrees)

		
#		print(float(current_position.angle_to(target)))
#		if float(current_position.angle_to(target)) >= 0:
#			print("Something")
#		print("Target:")
#		print(target)
#		print("Current:")
#		print(current_position)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var velocity = Vector2() # The player's movement vector.
##	# Move towards the target and stop when close.
##	if position.distance_to(target) > 10:
##		velocity = target - position
##	if velocity.length() > 0:
##		velocity = velocity.normalized() * speed
#	position += velocity * delta
#	position.x = clamp(position.x, 20, screen_size.x - 20)
#	position.y = clamp(position.y, 20, screen_size.y - 20)
#
#func get_direction(target, current_position):
#	print(str(current_position))
#	print(str(target))
	
#		$AnimatedSprite.play()
#		$Trail.emitting = true
#	else:
#		$AnimatedSprite.stop()
#		$Trail.emitting = false
	# We still need to clamp the player's position here because on devices that don't
	# match your game's aspect ratio, Godot will try to maintain it as much as possible
	# by creating black borders, if necessary.
	# Without clamp(), the player would be able to move under those borders.
#	position += velocity * delta
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 0, screen_size.y)
#	if velocity.x != 0:
#		$AnimatedSprite.animation = "walk"
#		$AnimatedSprite.flip_v = false
#		# See the note below about boolean assignment
#		$AnimatedSprite.flip_h = velocity.x < 0
#	elif velocity.y != 0:
#		$AnimatedSprite.animation = "up"
#		$AnimatedSprite.flip_v = velocity.y > 0
#	if velocity.x < 0:
#		$AnimatedSprite.flip_h = true
#	else:
#		$AnimatedSprite.flip_h = false


#func _on_Player_body_entered( body ):
#	hide()
#	emit_signal("hit")
#	$CollisionShape2D.set_deferred("disabled", true)
#
#extends KinematicBody2D
#
##signal hit
#
#export var speed = 400  # How fast the player will move (pixels/sec).
#var screen_size  # Size of the game window.
#
## Add this variable to hold the clicked position.
#var target = Vector2()
#var velocity = Vector2()
#
#var world_target_pos = Vector2()
#var target_direction = Vector2()
#var is_moving = true
#
#var type
#var grid
#
#
## Declare member variables here. Examples:
## var a = 2
## var b = "text"
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	hide()
#	screen_size = get_viewport_rect().size
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var velocity = Vector2() # The player's movement vector.
#	# Move towards the target and stop when close.
#	if position.distance_to(target) > 10:
#		velocity = target - position
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed
##		$AnimatedSprite.play()
##		$Trail.emitting = true
##	else:
##		$AnimatedSprite.stop()
##		$Trail.emitting = false
#	# We still need to clamp the player's position here because on devices that don't
#	# match your game's aspect ratio, Godot will try to maintain it as much as possible
#	# by creating black borders, if necessary.
#	# Without clamp(), the player would be able to move under those borders.
#	position += velocity * delta
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 0, screen_size.y)
#	var direction = Vector2()
#
#func start(pos):
#	position = pos
#	show()
#	$CollisionShape2D.disabled = false

#const MAX_SPEED = 400
#
#var speed = 0
#var velocity = Vector2()
#
#var world_target_pos = Vector2()
#var target_direction = Vector2()
#var is_moving = true
#
#var type
#var grid
#
#
#func _ready():
##	grid = get_parent()
##	type = grid.PLAYER
#	set_process(true)
#
#
#func _process(delta):
#	direction = Vector2()
#	speed = 250
#
#	if Input.is_action_pressed("move_up"):
#		direction.y = -1
#	elif Input.is_action_pressed("move_down"):
#		direction.y = 1
#
#	if Input.is_action_pressed("move_left"):
#		direction.x = -1
#	elif Input.is_action_pressed("move_right"):
#		direction.x = 1
#
#	if not is_moving and direction != Vector2():
#		# if player is not moving and has no direction
#		# then set the target direction
#		target_direction = direction.normalized()
#
#		if grid.is_cell_vacant(position, direction):
#			world_target_pos = grid.update_child_pos(position, direction, type)
#			is_moving = true
#
#	elif is_moving:
#		speed = MAX_SPEED
#		velocity = speed * target_direction * delta
#
#		var distance_to_target = position.distance_to(world_target_pos)
#		var move_distance = velocity.length()
#
#		# Set the last movement distance to the distance to the target
#		# this will make the player stop exaclty on the target
#		if distance_to_target < move_distance:
#			velocity = target_direction * distance_to_target
#			is_moving = false
#
#		move_and_collide(velocity)

#extends KinematicBody2D
#
#var speed = 250
#var velocity = Vector2()
#
#func get_input():
#	# Detect up/down/left/right keystate and only move when pressed.
#	velocity = Vector2()
#	if Input.is_action_pressed('ui_right'):
#		velocity.x += 1
#	if Input.is_action_pressed('ui_left'):
#		velocity.x -= 1
#	if Input.is_action_pressed('ui_down'):
#		velocity.y += 1
#	if Input.is_action_pressed('ui_up'):
#		velocity.y -= 1
#	velocity = velocity.normalized() * speed
#
#func _physics_process(delta):
#	get_input()
#	move_and_collide(velocity * delta)
#extends KinematicBody2D
#
#var direction = Vector2()
#
#const TOP = Vector2(0, -1)
#const RIGHT = Vector2(1, 0)
#const DOWN = Vector2(0, 1)
#const LEFT = Vector2(-1, 0)
#
#var speed = 250
#const MAX_SPEED = 400
#
#var velocity = Vector2()
#
#func _ready():
#	set_physics_process(true)
#
#func get_input():
#	# Detect up/down/left/right keystate and only move when pressed.
#	velocity = Vector2()
#	if Input.is_action_pressed('ui_right'):
#		direction = TOP
#		velocity.x += 1
#	if Input.is_action_pressed('ui_left'):
#		direction = DOWN
#		velocity.x -= 1
#	if Input.is_action_pressed('ui_down'):
#		direction = LEFT
#		velocity.y += 1
#	if Input.is_action_pressed('ui_up'):
#		direction = RIGHT
#		velocity.y -= 1
#	velocity = velocity.normalized() * speed
#
#func _physics_process(delta):
#	get_input()
#	move_and_collide(velocity * delta)

#func _physics_process(delta):
#	direction = Vector2()
#	var is_moving = true
#	speed = MAX_SPEED
#
#	if Input.is_action_pressed("move_up"):
#		direction = TOP
#	elif Input.is_action_pressed("move_down"):
#		direction = DOWN
#	elif Input.is_action_pressed("move_left"):
#		direction = LEFT
#	elif Input.is_action_pressed("move_right"):
#		direction = RIGHT
#
#	velocity = speed * direction.normalized()
#	move_and_collide(velocity * delta)
