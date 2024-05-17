extends Node2D

func _process(_delta):
	if position.x <= -800.0:
		position.x = 800
