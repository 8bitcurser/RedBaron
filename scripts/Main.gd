extends Node

@export var obstacle: PackedScene
@export var coin: PackedScene
var dynamic_object_speed: int = 700
var health_decrease_speed: int = 3
var health: float = 100.0
var score_val: float = 0
var spawned_object_position_x: int = 1600
var last_obstacle_position: int = 0
var last_score_modifier: int = 0
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
	else:
		get_tree().paused = true

	score_val += delta
	var formatted_score: String = str("%.2f" % score_val)
	score.text = str(formatted_score)
	var score_int = int(score_val)
	if score_val > 2 and (score_int % 10 == 0) and score_int != last_score_modifier:
		last_score_modifier = score_int
		spawner.wait_time = spawner.wait_time - 0.07 



func _on_spawner_timeout():
	var random: int = randi() % 2
	var random_offset: int = randi_range(0, 300)
	var obs_instance: Area2D = obstacle.instantiate()
	add_child(obs_instance)
	obs_instance.position.x = spawned_object_position_x + random_offset
	if random == 1:
		obs_instance.position.y = 800
		obs_instance.rotation = -135
		last_obstacle_position = 1
	else:
		obs_instance.position.y = 230
		last_obstacle_position = 0
		 # Replace with function body
	obs_instance.body_entered.connect(_on_obstacle_coll.bind(obs_instance))

func _on_coinspawner_timeout():
	var random_y_pos: int = randi_range(191, 800)
	var random_x_pos: int = 1600

	var coin_ins: Area2D = coin.instantiate()
	if last_obstacle_position == 1:
		coin_ins.position.y = randi_range(90, 480)
	else:
		coin_ins.position.y = randi_range(480, 800)
	coin_ins.position.x = random_x_pos
	coin_ins.body_entered.connect(_on_coin_coll.bind(coin_ins))
	add_child(coin_ins) 


func _on_coin_coll(body: Node2D, coin_ins: Node2D) -> void:
	if body.is_in_group('Player'):
		health += 4
		coin_ins.queue_free()
		if health > 100:
			health = 100

func _on_obstacle_coll(body: Node2D, obs_ins: Node2D) -> void:
	if body.is_in_group('Player'):
		health -= 10

