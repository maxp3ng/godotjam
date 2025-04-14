extends Node2D

var target_pos1: Vector2
var v: float = 100 
var move := false 
var rng = RandomNumberGenerator.new()
var sep_r := 2
var sep_s := 10

func _ready():
	
	add_to_group("enemies")
	rng.randomize()
	
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
		
func move_sprite(tgt: Vector2): 
	target_pos1 = tgt
	move = true 
	var walk_anim = $AnimatedSprite2D
	if walk_anim: 
		walk_anim.play("walk")
		
func _physics_process(delta): 
	if move: 
		var d = target_pos1 - global_position
		if d.length() > 5: 
			
			var d0 = d.normalized() 
			var offset = Vector2(rng.randf_range(-0.1,0.1), rng.randf_range(-0.1, 0.1))
			var df = (d0 + offset).normalized()
			#global_position += df * v * delta
			#print(d)
			#global_position += d.normalized() * v * delta
			var sep = Vector2.ZERO 
			var n_neighboors = 0 
			for i in get_tree().get_nodes_in_group("enemies"): 
				if i == self: 
					continue 
				var diff = global_position - i.global_position
				var dist = diff.length() 
				
				if dist > 0 and dist < sep_r: 
					sep += diff.normalized() * ((sep_r - dist) / sep_r)
					n_neighboors += 1 
				if n_neighboors > 0: 
					sep /= n_neighboors
					sep = sep.normalized() * (sep_s / v)
				
				var new_dir =  (d0 + sep).normalized() 
				global_position += new_dir * v * delta
		else: 
			move = false
			var idle_anim = $AnimatedSprite2D
			if idle_anim: 
				idle_anim.play("idle")
		
