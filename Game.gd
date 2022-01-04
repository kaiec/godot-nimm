extends Node2D


var stack_scene: PackedScene = preload("res://Stack.tscn")

var selecting = false
var selected = []
onready var stacks = $Stacks

# Called when the node enters the scene tree for the first time.
func _ready():
	var xoffset = 0
	for i in [7, 5, 3, 1]:
		var stack = stack_scene.instance()
		stack.init_sticks(i)
		$Stacks.add_child(stack)
		stack.position.y = 100
		stack.position.x = 100 + xoffset 
		xoffset += 200
	for stick in get_active_sticks():
		stick.connect("mouse_entered", self, "_on_mouse_over_stick", [stick])
		stick.connect("input_event", self, "_on_stick_event", [stick])
		

func _on_mouse_over_stick(stick):
	if selecting and not stick.selected:
		stick.selected = true
		selected.append(stick)
		
func select_stick(stick):
	if stick and not stick.selected:
		stick.selected = true
		selected.append(stick)
		
func unselect():
	for selected_stick in selected:
		selected_stick.selected = false
	selected.clear()
		
func start_selecting(stick=null):
	# Prevent double starts
	if selecting:
		select_stick(stick)
		return
	unselect()
	selecting = true
	select_stick(stick)


func _on_stick_event(_viewport, event: InputEvent, _shape_idx, stick):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			start_selecting(stick)
		else:
			selecting = false

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			start_selecting()
		else:
			selecting = false

func get_active_sticks():
	var res = []
	for stack in stacks.get_children():
		for stick in stack.sticks.get_children():
			res.append(stick)
	return res


func _on_TakeButton_pressed():
	for stick in selected:
		stick.queue_free()
	selected.clear()
