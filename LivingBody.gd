extends KinematicBody2D

var screen_size
export var speed = 310
var controls = ["ui_up", "ui_left", "ui_down", "ui_right"]
var direction

func _ready():
	screen_size = get_viewport_rect().size
	$BodySprite.play("default")
	direction = "none"

func _physics_process(delta):
	
	#Handle movement direction
	var velocity = Vector2()  # The player paddle's movement vector.
	
	if Input.is_action_pressed(controls[2]):
		if (!get_parent().switching):
			direction = "down"
			$BodySprite.play("down")
		
	elif Input.is_action_pressed(controls[0]):
		if (!get_parent().switching):
			direction = "up"
			$BodySprite.play("up")
	
	elif Input.is_action_pressed(controls[3]):
		if (!get_parent().switching):
			direction = "right"
			$BodySprite.play("right")
		
	elif Input.is_action_pressed(controls[1]):
		if (!get_parent().switching):
			direction = "left"
			$BodySprite.play("left")
	
	var collision = move_and_slide(velocity*delta)
	
	velocity += direction_movement(direction)
	velocity = velocity.normalized() * speed
	
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
	return localVelocity
