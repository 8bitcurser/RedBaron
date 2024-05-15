extends Node

var dynamic_object_speed: int = 700

func _process(delta):
	for dynamic_object in get_tree().get_nodes_in_group('DynamicObject'):
		dynamic_object.position.x -= delta * dynamic_object_speed
	#
	#if position.x <= -800.0:
		#position.x = 800
