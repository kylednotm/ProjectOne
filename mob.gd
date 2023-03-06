extends RigidBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	#get all of the mob types
	var mob_types = $AnimatedSprite2D.get_sprite_frames().get_animation_names()
	#randomly select one of the mob types
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifer_s2_screen_exited():
	queue_free()

