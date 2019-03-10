extends Node2D

enum CELL_TYPES { ACTOR, OBSTACLE, OBJECT} 
#Only way to export an enum to the editor:
export(CELL_TYPES) var type = CELL_TYPES.ACTOR
