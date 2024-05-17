extends RigidBody2D

var impulse_force: int = 350

func _physics_process(_delta):
	if Input.is_action_pressed("click"):
		apply_central_impulse(Vector2.UP * impulse_force)

	var yvel : int = get_linear_velocity().y
		
	if yvel > 850:
		global_rotation_degrees = 45
	elif yvel < 0:
		global_rotation_degrees = -30
	else:
		global_rotation_degrees = 0

	
