extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var stick_scene : PackedScene = load("res://Stick.tscn")

onready var sticks = $Sticks

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init_sticks(number):
	for i in range(number):
		var stick = stick_scene.instance()
		$Sticks.add_child(stick)
		stick.position.y += 40 * i
		print(stick.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
