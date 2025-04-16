extends Node2D

@onready var transition = $TerrainTransition 
@onready var terrain = $CurrentTerrain

func _ready() -> void: 
	transition.connect("full_coverage", _on_full_coverage)
	
	
func trigger_change(): 
	transition.begin_terrain_transition() 
	
func _on_full_coverage(): 
	var old = terrain
	
	var new = load("res://terrain_transition.tscn").instantiate()
	add_child(new)
	
	terrain = new 
	old.queue_free() 
