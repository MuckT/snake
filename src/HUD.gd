extends CanvasLayer
var score = -1
signal start_game


func _on_Collectible_area_entered(area):
	if area.get_parent().name.begins_with("Grid"):
		score += 1
	$ScoreLabel.text = str(score) 


func _on_StartButton_pressed():
	$StartButton.hide()
	$Label.hide()
	$NameLabel.hide()
	emit_signal("start_game")
	print('start game button pressed')
