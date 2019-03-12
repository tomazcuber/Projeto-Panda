extends TileMap

enum CELL_TYPES { ACTOR, OBSTACLE, OBJECT }

#Maps Children Objects to Grid coordinates
func _ready():
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)

#Returns Cell on Grid based on type 
func get_cell_pawn(cell, type = ACTOR):
	for node in get_children():
		if node.type != type:
			continue 
		if world_to_map(node.position) == cell:
			return (node)

#Function requested by Actor type Cells to move to next Cell on the Grid based on its direction (horizontal, vertical or diagonal)
func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_tile_id = get_cellv(cell_target)
	match cell_target_tile_id:
		-1: #Cell is empty
			set_cellv(cell_target, pawn.type)
			set_cellv(cell_start, -1)
			return map_to_world(cell_target) + cell_size/2 #returns the position in World coordinates to where the Actor who requested the movement should go
		
		OBJECT, ACTOR: #Cell is an static Object or another Actor
			var pawn_name = get_cell_pawn(cell_target, cell_target_tile_id).name
			print("Cell %s contains %s", [cell_target, pawn_name])

	pass