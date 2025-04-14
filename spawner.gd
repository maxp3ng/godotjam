
extends Node2D

var scene := preload("res://enemy.tscn")

var spawners := []

func _ready():
	print("spawner loaded")
	for i in get_children():
		if i is Marker2D:
			print(i.global_position)
			spawners.append(i)


	$Timer.timeout.connect(_on_timer_timeout)
	$Timer.start() 
	
	# TODO: this causes the whole game to last 30 secs
	# make a seperate timer just for spawning
	await get_tree().create_timer(30).timeout
	get_tree().quit()


func jitter(r: float = 15) -> Vector2:
	var theta = randf()  * TAU
	var d = randf() * r
	return Vector2(cos(theta), sin(theta)) * d

func _on_timer_timeout() -> void:

	if spawners.is_empty(): 
		print("no spawners")

	var spawn = spawners[randi() % spawners.size()]
	print(spawn.global_position)
	var enemy = scene.instantiate() # at 0,0 
	var r = 45
	enemy.position = spawn.global_position + jitter(r)
	get_tree().current_scene.add_child(enemy)
