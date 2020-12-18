class_name Nest
extends Area2D

var egg_count

export var nest_color = Color.red


# Called when the node enters the scene tree for the first time.
func _ready():
#	pass # Replace with function body.
	$TileMap.modulate = nest_color*0.5
	reset_count()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func reset_count():
	egg_count = 0


func _on_Nest_body_entered(body):
	egg_count += 1
	if(body.has_method("color_egg")):
		body.color_egg(nest_color)


func _on_Nest_body_exited(body):
	if egg_count>0:
		egg_count-=1
	if(body.has_method("color_egg")):
		body.color_egg(Color.white)

func is_nest():
	print("this is nest")
