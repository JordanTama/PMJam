class_name Egg
extends RigidBody2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Egg_body_entered(body):
	if body is Player:
		if(!body.is_holding_egg):
			queue_free()
			body.hold_egg()
	
func color_egg(color):
	$Sprite.modulate = color
