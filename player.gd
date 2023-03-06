extends Area2D

#define a collision
signal hit

@export var speed = 400
var screen_size 

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#player is hidden when game starts
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#basic movement
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	#if moving, play animation
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed #prevents fast diagonal speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		velocity.x += 1

	#limit the play space to the screen size.  consider offset?
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	#flip animation for left/right?	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = 'walk'
		$AnimatedSprite2D.flip_v = false
		#assigning and checking status in one step.  
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	elif velocity.y !=0:
		$AnimatedSprite2D.animation = 'up'
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body):
	hide() #player disappears after being hit
	hit.emit()
	#can't change physics properties on a physics callback
	#I think this prevents repeated signals of "hit" - not fully sure
	#deferred tells it to wait until it's safe to disappear the hitbox
	$CollisionShape2D.set_deferred('disabled', true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
