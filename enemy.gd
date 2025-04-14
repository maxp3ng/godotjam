extends Node2D

func _ready():
	var op = position
	var shake = Vector2(randf_range(-20,20), randf_range(-15, 15))
	position += shake
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", op, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


	modulate.a = 0
	tween.tween_property(self, "modulate:a", 1, 0.2)
	scale = Vector2(0.6,0.6)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	
	var idle_anim = $AnimatedSprite2D
	if idle_anim: 
		idle_anim.play("idle")
