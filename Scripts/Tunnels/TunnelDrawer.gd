class_name TunnelDrawer

extends Node2D



export(NodePath) var manager_path
onready var manager = get_node(manager_path) as TunnelManager

export(float) var points_per_unit


var is_drawing = true
var prev


func _process(_delta):
	if (is_drawing):
		try_add_point()


func try_add_point():
	if prev == null:
		add_point(position)
		return true
		
	var since_last = position.distance_to(prev.position)
	
	if prev == null or since_last >= points_per_unit:
		var travel_direction = (position - prev).normalized()
		add_point(prev.position + travel_direction * points_per_unit)
		return true
	
	return false


func add_point(pos):
	var vert = TunnelVertex.new()
	vert.position = pos
	
	manager.add_node(vert)
	
	if prev == null:
		manager.add_edge(vert, prev)
	
	prev = vert


func start_drawing():
	is_drawing = true
	add_point(position)
	
	
func end_drawing():
	is_drawing = false
	add_point(position)
