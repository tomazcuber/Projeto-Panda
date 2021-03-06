extends Node

enum CELL_TYPES { ACTOR, OBSTACLE, PIECE }

onready var grid : TileMap = $Grid
onready var actor: Node2D = $Grid/Actor
onready var grid_children : Array = $Grid.get_children()

var orthogonal_pieces: Dictionary = {
"piece_down_left" : preload("res://Pawn/PieceSingleDL.tscn"),
"piece_down_right" : preload("res://Pawn/PieceSingleDR.tscn"),
"piece_up_left" : preload("res://Pawn/PieceSingleUL.tscn"),
"piece_up_right" : preload("res://Pawn/PieceSingleUR.tscn"),
"piece_left_down" : preload("res://Pawn/PieceSingleLD.tscn"),
"piece_left_up" : preload("res://Pawn/PieceSingleLU.tscn"),
"piece_right_down" : preload("res://Pawn/PieceSingleRD.tscn"),
"piece_right_up" : preload("res://Pawn/PieceSingleRU.tscn")
} 
var grid_objects : Array 
var selected_piece 

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
		if event.pressed and event.scancode	== KEY_ENTER:
			actor.set_move_start(true)
					
		if event.pressed and event.scancode == KEY_1:
			selected_piece = orthogonal_pieces["piece_down_left"]
		if event.pressed and event.scancode == KEY_2:
			selected_piece = orthogonal_pieces["piece_down_right"]

	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		var grid_position = grid.world_to_map(event.position)
		if grid.get_cellv(grid_position) == -1:
			print("Click was on: ", event.position)
			print("Cell is on: " , grid_position)
			
			if selected_piece:
				var new_piece = selected_piece.instance()
				new_piece.init(Vector2(1,0),Vector2(0,1))
				new_piece.set_position(grid_position  * 64 + Vector2(32,32))
			
				grid.add_child(new_piece)
				grid.set_cellv(grid_position, CELL_TYPES.PIECE)


