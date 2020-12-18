extends Resource


var points = []


func _add(position):
	points.append(position)
	
	
func _clear():
	points.clear()
