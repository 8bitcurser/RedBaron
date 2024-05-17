extends Node

@export var obstacle: PackedScene
var dynamic_object_speed: int = 700
var health_decrease_speed: int = 3
var health: float = 100.0
var score_val: float = 0
var spawned_object_position_x: int = 1600
@onready var healthbar = $UI/healthbar
@onready var score = $UI/healthbar/score
@onready var spawner = $Spawner
@onready var player = $Player

func _process(delta):
	for dynamic_object in get_tree().get_nodes_in_group('DynamicObject'):
		dynamic_object.position.x -= delta * dynamic_object_speed
	
	if health > 0:
		health -= delta * health_decrease_speed
		healthbar.value = health

	score_val += delta
	var formatted_score: String = str("%.2f" % score_val)
	score.text = str(formatted_score)
	if score_val > 100 and int(score_val) % 100 == 0:
		spawner.wait_time -= 0.05



func _on_spawner_timeout():
	var random: int = randi() % 2
	
	var obs_instance: Area2D = obstacle.instantiate()
	add_child(obs_instance)
	obs_instance.position.x = spawned_object_position_x
	if random == 1:
		obs_instance.position.y = 800
		obs_instance.rotation = -135
	else:
		obs_instance.position.y = 230
		 # Replace with function body.
