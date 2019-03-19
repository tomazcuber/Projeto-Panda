extends Node

enum CELL_TYPES { ACTOR, OBSTACLE, OBJECT }

onready var grid : TileMap = $Grid
onready var actor: Node2D = $Grid/Actor
onready var grid_children : Array = $Grid.get_children()
var grid_objects : Array 

func _ready():
	for node in grid_children:
		if node.type != CELL_TYPES.ACTOR:
			grid_objects.append(node)
			#print (node.name)


func _unhandled_input(event: InputEvent) -> void:
	#if not event is InputEventMouseButton:
	#	return 
	#if event.button_index != BUTTON_LEFT or not event.pressed:
	#	return
	
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			print("C ya l8r")
			get_tree().quit()
		if event.pressed and event.scancode == KEY_ENTER:
			actor.set_move_start(true)	