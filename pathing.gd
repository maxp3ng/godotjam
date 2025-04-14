#extends Node
#
#@export var target_pos1: Vector2
#@export var v: float = 100 
#
#func _ready(): 
	#var walk_anim = $AnimatedSprite2D
	#if walk_anim:
		#walk_anim.play("walk")
		#
#func _physics_process(delta): 
	#var d = (target_pos1 - global_position).normalized()
	#global_position += d * v * delta 
