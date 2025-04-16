extends Node2D

class_name TerrainTransition 

signal transition_completed
signal full_coverage 

#@export var texture: Texture2D  
@export var v: float = 2 

var cloud: Sprite2D
var tween: Tween 
var in_change: bool = false 


func _ready() -> void: 
	cloud = Sprite2D.new() 
	cloud.texture = preload("res://sprites/snow-golem.png")
	
	cloud.modulate.a = 1 
	var viewport = get_viewport_rect().size
	
	cloud.scale = Vector2(2,2)
	cloud.position = Vector2(viewport.x + 500, viewport.y /2)
	cloud.z_index = 100 
	
	add_child(cloud)
	
func begin_terrain_transition(): 
	if in_change: 
		return 
		
	in_change = true 
	
	var viewport = get_viewport_rect().size 
	
	var origin = Vector2(viewport.x / 2, viewport.y / 2)
	var screen_pos = Vector2(viewport.x + 500, viewport.y /2)
	
	# make tween anims
	
	tween = create_tween() 
	tween.tween_property(cloud, "position", origin, v)
	tween.tween_callback(func(): emit_signal("full_coverage"))
	tween.tween_interval(0.5)
	tween.tween_property(cloud, "position", screen_pos, v)
	tween.tween_callback(func(): 
		emit_signal("transition_completed")
		in_change = false
	)
