extends Area2D

var egg_count


# Called when the node enters the scene tree for the first time.
func _ready():
#	pass # Replace with function body.
	reset_count()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reset_count():
	egg_count = 0


func _on_Nest_body_entered(body):
	egg_count += 1


func _on_Nest_body_exited(body):
	if egg_count>0:
		egg_count-=1
