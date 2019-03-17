extends TileMap

enum CELL_TYPES { ACTOR, OBSTACLE, PIECE }

#Maps Children Objects to Grid coordinates
func _ready():
	for child in get_children():
		#if child.type != CELL_TYPES.ACTOR:
			set_cellv(world_to_map(child.position), child.type)


#Returns Cell on Grid based on Grid coordinates 
func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return (node)

#Function requested by Actor type Cells to move to next Cell on the Grid based on its direction (horizontal, vertical or diagonal)
func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		-1: #Cell is empty
			return update_pawn_position(pawn, cell_start, cell_target)
		
		CELL_TYPES.PIECE:
			var piece = get_cell_pawn(cell_target)
			pawn.set_look_direction(piece.get_target_direction())
#func is_next_cell_free():
	


func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, -1)
	return map_to_world(cell_target) + cell_size / 2 #returns the position in World coordinates to where the Actor who requested the movement should go