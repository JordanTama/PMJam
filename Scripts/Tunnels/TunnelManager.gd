class_name TunnelManager

extends Node2D

var nodes = []
var edges = Dictionary()


func _ready():
	nodes = []
	edges = Dictionary()


func _process(_delta):
	for node in nodes:
		for adjacent in edges[node]:
			draw_line(node.position, adjacent.position, Color.white, 2, true)


func add_node(node):
	nodes.append(node)
	edges[node] = Array()


func remove_node(node):
	# Remove existing edges
	for key in edges:
			remove_edge(node, key)

	# Remove node
	if nodes.has(node):	
		nodes.erase(node)


func add_edge(a, b):
	if edges.has(a) and edges.has(b):
		edges[a].append(b)
		edges[b].append(a)


func remove_edge(a, b):
	if edges.has(a) and edges[a].has(b):
		edges[a].erase(b)
		
		if edges[a].size() <= 0:
			edges.erase(a)

	if edges.has(b) and edges[b].has(a):
		edges[b].erase(a)
		
		if edges[b].size() <= 0:
			edges.erase(b)


func bisect(_a, _b):
	pass
