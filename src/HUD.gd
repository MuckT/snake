extends CanvasLayer
var score = -1
signal start_game


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Collectible_area_entered(area):
	score += 1
	$ScoreLabel.text = str(score) 


func _on_StartButton_pressed():
	$StartButton.hide()
	$Label.hide()
	$NameLabel.hide()
	emit_signal("start_game")
