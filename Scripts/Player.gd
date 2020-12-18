class_name Player
extends KinematicBody2D

signal throw(location,direction)

export var player_number = 1

export(NodePath) var drawer_path
onready var drawer = get_node(drawer_path) as TunnelDrawer

var move_right_action := "move_right"
var move_left_action := "move_left"
var move_down_action := "move_down"
var move_up_action := "move_up"
var dig_action := "dig"
var throw_action := "throw"

export var acceleration = 500
export var max_speed = 80
export var friction = 500
var is_digging = false
var is_underground = false
var is_holding_egg = false

var velocity = Vector2.ZERO
var throw_dir = Vector2.RIGHT

func _ready():
	move_right_action += str(player_number)
	move_left_action += str(player_number)
	move_up_action += str(player_number)
	move_down_action += str(player_number)
	dig_action += str(player_number)
	throw_action += str(player_number)
	print(throw_action)

func _process(delta):
	if Input.is_action_just_pressed(throw_action):
		throw_egg()

func _physics_process(delta):
	if is_digging == false:
		
		throw_dir = Vector2.ZERO
		
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength(move_right_action) - Input.get_action_strength(move_left_action)
		input_vector.y = Input.get_action_strength(move_down_action) - Input.get_action_strength(move_up_action)
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
			
			throw_dir.x = sign(velocity.x)*1.0
		
		if velocity.y!=0:
			throw_dir.y = sign(velocity.y)*1.0
			
		if velocity.length() == 0:
			$AnimatedSprite.animation = "idle"
			
			throw_dir = Vector2.RIGHT

		if Input.is_action_just_pressed(dig_action):
			$DigTimer.start()
			is_digging = true
			velocity = Vector2.ZERO
			$AnimatedSprite.animation = "dig"
			$AnimatedSprite.play()
			drawer.start_drawing();
	
			
func _on_DigTimer_timeout():
	is_digging = false

func throw_egg():
	if is_holding_egg and !is_digging and !is_underground:
		throw_dir = throw_dir.normalized()
		emit_signal("throw",position,throw_dir)
		is_holding_egg = false
		
func hold_egg():
	is_holding_egg = true
	
func has_egg():
	return is_holding_egg
