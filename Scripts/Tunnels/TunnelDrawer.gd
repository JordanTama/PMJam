class_name TunnelDrawer

extends Node2D


export(NodePath) var manager_path
onready var manager = get_node(manager_path) as TunnelManager

export(float) var point_spread = 50


var is_drawing = false
var prev


func _ready():
	start_drawing()


func _process(_delta):
	if (is_drawing):
		try_add_point()


func try_add_point():
	if prev == null:
		return false
		
	var since_last = global_position.distance_to(prev.position)
	
	if since_last >= point_spread:
		var travel_direction = (global_position - prev.position).normalized()
		add_point(prev.position + travel_direction * point_spread)
		return true
	
	return false


func add_point(pos):
	var vert = TunnelVertex.new()
	vert.position = pos
	
	manager.add_node(vert)
	
	if prev != null:
		manager.add_edge(vert, prev)
	
	prev = vert


func start_drawing():
	is_drawing = true
	add_point(global_position)


func end_drawing():
	is_drawing = false
	add_point(global_position)
