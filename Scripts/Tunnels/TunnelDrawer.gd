extends Node2D


export var manager : Resource = preload("res://Scripts/Tunnels/TunnelManager.gd")
export(float) var points_per_unit


var is_drawing = true
var tunnel = Tunnel.new()


func _process(delta):
	if (is_drawing):
		try_add_point()
		
	print(tunnel.size())


func try_add_point():
	if (tunnel.size() <= 0):
		 return false
		
	var since_last = position.distance_to(tunnel[-1])
	
	if (since_last >= points_per_unit):
		var travel_direction = (position - tunnel[-1]).normalized()
		tunnel._add(tunnel[-1] + travel_direction * points_per_unit)
		return true
	
	return false


func _begin_drawing():
	tunnel._clear()
	tunnel._add(position)
	
	is_drawing = true
	
	
func _end_drawing():
	tunnel._add(position)
	manager._add(tunnel)
	
	is_drawing = false
