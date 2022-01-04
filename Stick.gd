extends Area2D


export var selected: bool = false setget set_selected, get_selected


func get_selected():
	return selected
	
func set_selected(value):
	print("Set to %s" % value)
	selected = value
	if selected:
		$Icon.modulate = Color(1,0,0)
	else:
		$Icon.modulate = Color(1,1,1)
		
