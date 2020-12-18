extends KinematicBody2D

export var acceleration = 500
export var max_speed = 80
export var friction = 500
var is_digging = false
var is_underground = false

var velocity = Vector2.ZERO

func _physics_process(delta):
	if is_digging == false:
		
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			
		velocity = move_and_slide(velocity)
			
		if velocity.x != 0:
			$AnimatedSprite.animation = "walk"
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = velocity.x < 0
			
		if velocity.length() == 0:
			$AnimatedSprite.animation = "idle"

		if Input.is_action_just_pressed("ui_accept"):
			$DigTimer.start()
			is_digging = true
			velocity = Vector2.ZERO
			$AnimatedSprite.animation = "dig"
			$AnimatedSprite.play()
		
	
			
func _on_DigTimer_timeout():
	is_digging = false
