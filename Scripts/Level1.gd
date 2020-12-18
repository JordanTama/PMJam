extends Node

export(PackedScene) var egg_scene

export var egg_spawn_offset = 64.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_throw(pos, dir):
	var egg = egg_scene.instance()
	add_child(egg)
	egg.position = pos + dir*egg_spawn_offset
	egg.apply_impulse(egg.position,dir*350.0)
	
	
	
