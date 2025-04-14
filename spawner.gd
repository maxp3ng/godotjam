
extends Node2D

var scene := preload("res://enemy.tscn")

var spawners := []
var enemies := []
var spawn_tick := 1 #s
var spawn_duration := 10 #s
var timer := Timer.new() 

func _ready():
	var tgt := get_parent().get_node("PathMarker") 
	print("spawner loaded")
	for i in get_children():
		if i is Marker2D:
			print(i.global_position)
			spawners.append(i)
	
	timer.wait_time = spawn_tick
	timer.connect("timeout", _on_spawn_timer_timeout)
	add_child(timer)
	timer.start() 
	
	#$Timer.timeout.connect(_on_timer_timeout)
	#$Timer.start() 
	
	# TODO: this causes the whole game to last 30 secs
	# make a seperate timer just for spawning
	await get_tree().create_timer(spawn_duration).timeout
	#get_tree().quit()
	timer.stop() 
	# two seconds of idle before talking. 
	await get_tree().create_timer(2).timeout
	
	for i in enemies: 
		if i and i.is_inside_tree(): 
			i.move_sprite(tgt.global_position)
	await get_tree().create_timer(10).timeout 
	get_tree().quit() 
	


func jitter(r: float = 15) -> Vector2:
	var theta = randf()  * TAU
	var d = randf() * r
	return Vector2(cos(theta), sin(theta)) * d


func _on_spawn_timer_timeout(): 
	var r = 45 
	var enemies_per_spawner = 8 
	for i in spawners: 
		for j in range(enemies_per_spawner): 
			var enemy = scene.instantiate()
			enemy.position = i.global_position + jitter(r)
			get_tree().current_scene.add_child(enemy)
			enemies.append(enemy)
			
			
			
			
#func _on_timer_timeout() -> void:
#
	#if spawners.is_empty(): 
		#print("no spawners")
		#return 
		#
	#var enemies_per_spawner = 8 
	#
	#for i in spawners: 
		#for j in range(enemies_per_spawner):
			#var enemy = scene.instantiate() 
			#enemy.position = i.global_position + jitter(45)
			#get_tree().current_scene.add_child(enemy)
			#
	#var spawn = spawners[randi() % spawners.size()]
	#print(spawn.global_position)
	#var enemy = scene.instantiate() # at 0,0 
	#var r = 45
	#enemy.position = spawn.global_position + jitter(r)
	#get_tree().current_scene.add_child(enemy)
