extends Node

@export var mob_scene: PackedScene
var score
var high_score
var total_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#new_game()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	total_time += 1
	$hud.update_total_time(total_time/60)

func _on_player_hit():
	game_over()

func game_over():
	$scoretimer.stop()
	$mobtimer.stop()
	$music.stop()
	$deathsound.play()
	$hud.show_game_over()
	
	high_score = int($hud/highscorelabel.text)
	if score > high_score:
		$hud.update_high_score(score)
	
func new_game():
	score = 0
	$Player.start($startposition.position)
	$music.play()
	$starttimer.start()
	$hud.update_score(score)
	$hud.show_message('get ready...')
	get_tree().call_group('mobs', 'queue_free')

func _on_scoretimer_timeout():
	score += 1
	$hud.update_score(score)
	high_score = int($hud/highscorelabel.text)
	if score > high_score:
		$hud.update_high_score(score)

func _on_starttimer_timeout():
	$mobtimer.start()
	$scoretimer.start()
	$hud.update_score(score)

func _on_mobtimer_timeout():
	#create new instance of mob
	var mob = mob_scene.instantiate()
	#choose a random location from mobspawnlocation
	var mob_spawn_location = get_node('mobpath/mobspawnlocation')
	mob_spawn_location.progress_ratio = randi()
	#set direction perpendicular to path
	var direction = mob_spawn_location.rotation + PI / 2
	#set mob pos to random
	mob.position = mob_spawn_location.position
	#semi random direction
	direction += randf_range(-PI / 4, PI  / 4)
	mob.rotation = direction
	#mob velocity
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	#spawn the mob
	add_child(mob)


