class_name Egg
extends RigidBody2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Egg_body_entered(body):
	if body is Player:
		queue_free()
	if body is Nest:
		$Sprite.modulate = Color.red
	else:
		$Sprite.modulate = Color.white	
