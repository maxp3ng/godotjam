extends Node2D 
var n_sprites: int = 10 
var sprite: Sprite2D
var spawned: Array = [] 
var data: Array = [] 
var duration: float = 15
var s: float = 0 
var in_anim: bool = true 
var omega: float 

var rng = RandomNumberGenerator.new()

func _ready() -> void: 
	sprite = $Sprite2D
	sprite.hide() 	
	spawn() 
	
	s = Time.get_ticks_msec() / 1000 
	
func spawn() -> void: 
	var d: int
	for i in range(n_sprites): 
		var inst = sprite.duplicate() 
		inst.show() 
		inst.position = sprite.position 
		
		add_child(inst)
		spawned.append(inst)
		
		
		var r = rng.randf_range(20, 50)
		var p = rng.randf() * TAU 
		if (randi() % 2 == 0): 
			d = 1
		else: 
			d = -1
			
		var omega = ((2 * PI) / duration) * rng.randf_range(5, 6.1)
		#var omega = (2 * PI) / duration

		data.append({
			"node": inst, 
			"start": inst.position, 
			"r": r,  
			"p": p,
			"d": d, 
			"omega": omega,
		})
		
func _process(delta) -> void: 
	if not in_anim: 
		return 
	
	var t = Time.get_ticks_msec() / 1000 
	var elapsed = t - s 
	
	if elapsed >= duration: 
		in_anim = false
		for i in data: 
			i["node"].position = i["start"]
		return 
		
	for j in data: 
		var theta = j["p"] + j["omega"] * elapsed * j["d"]
		var offset = Vector2(cos(theta), sin(theta)) * j["r"]
		j["node"].position = j["start"] + offset 
		
		
	

	
	
	
	
