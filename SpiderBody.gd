extends KinematicBody2D

var screen_size
export var speed = 260
var controls = ["l1_up", "l1_left", "l1_down", "l1_right"]
var direction
signal hit_living

func _ready():
	screen_size = get_viewport_rect().size
	direction = "none"
	$AnimatedSprite.play("default")

func _physics_process(delta):
	
	#Handle movement direction
	var velocity = Vector2()  # The player paddle's movement vector.
	
	if Input.is_action_pressed(controls[2]):
		direction = "down"
		$AnimatedSprite.play("down")
		
	elif Input.is_action_pressed(controls[0]):
		direction = "up"
		$AnimatedSprite.play("up")
	
	elif Input.is_action_pressed(controls[3]):
		direction = "right"
		$AnimatedSprite.play("right")
		
	elif Input.is_action_pressed(controls[1]):
		direction = "left"
		$AnimatedSprite.play("left")
	
	var collision = move_and_slide(velocity*delta)
	for i in range(0, get_slide_count()):
		collision = get_slide_collision(i)
		if (collision.collider.name) == "LivingBody":
			emit_signal("hit_living")
	
	velocity += direction_movement(direction)
	velocity = velocity.normalized() * speed
	if velocity == Vector2(0, 0):
		$AnimatedSprite.play("default")
	
	#Handle physical movement
	position += velocity * delta

func direction_movement(way_to_go):
	#function to remotely handle changing the velocity to allow one-click movement
	var localVelocity = Vector2()
	if (!get_parent().switching):
		if way_to_go == "down":
			localVelocity.y += 1
		if way_to_go == "up":
			localVelocity.y -= 1
		if way_to_go == "right":
			localVelocity.x += 1
		if way_to_go == "left":
			localVelocity.x -= 1
	else:
		direction = "none"
		$AnimatedSprite.play("default")
	return localVelocity