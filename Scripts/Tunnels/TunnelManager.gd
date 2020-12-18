class_name TunnelManager

extends Node2D

var nodes = []
var edges = Dictionary()


func _process(_delta):
	update()


func _draw():
	for node in nodes:		
		for adjacent in edges[node]:
			draw_line(node.position, adjacent.position, Color.white, 5.0, true)
			
		draw_circle(node.position, 10.0, Color.red)


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
	create_edge(a, b)
	bisect(a, b)


func create_edge(a, b):
	if edges.has(a) and edges.has(b):
		if !edges[a].has(b):
			edges[a].append(b)
			
		if !edges[b].has(a):
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


func check_bisect(a, b):
	for c in nodes:
		for d in edges[c]:
			var points = [a, b, c, d]
			var closest = cp_lines(a, b, c, d)
			
			var bisects = points.has(closest)
			
			if bisects:
				var mid = TunnelVertex.new()
				mid.position = closest
				add_node(mid)
				
				create_edge(mid, a)
				create_edge(mid, b)
				create_edge(mid, c)
				create_edge(mid, d)


func cp_lines(a, b, c, d):
	return Vector2()


func cp_line(p, a, b):
	return Vector2()


func bisect(a, b):
	for node in nodes:
		for adjacent in edges[node]:
			var x1 = a.position.x
			var y1 = a.position.y
			
			var x2 = b.position.x
			var y2 = b.position.y
			
			var x3 = node.position.x
			var y3 = node.position.y
			
			var x4 = adjacent.position.x
			var y4 = adjacent.position.y
			
			var tl1 = (x4 - x3) * (y1 - y3)
			var tr1 = (y4 - y3) * (x1 - x3)
			
			var tl2 = (x2 - x1) * (y1 - y3)
			var tr2 = (y2 - y1) * (x1 - x3)
			
			var bl = (y4 - y3) * (x2 - x1)
			var br = (x4 - x3) * (y2 - y1)

			var bot = bl - br

			if bot == 0:
				return
							
			var ua = (tl1 - tr1) / bot
			var ub = (tl2 - tr2) / bot
			
			
			if ua > 0 and ua < 1 and ub > 0 and ub < 1:
				var pos = a.position.linear_interpolate(b.position, ua)
				
				var mid = TunnelVertex.new()
				mid.position = pos
				add_node(mid)
				
				create_edge(mid, a)
				create_edge(mid, b)
				create_edge(mid, node)
				create_edge(mid, adjacent)
				
				remove_edge(node, adjacent)
