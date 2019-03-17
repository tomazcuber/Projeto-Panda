extends "pawn.gd"

export var entry_direction: Vector2 setget set_entry_direction, get_entry_direction
export var target_direction: Vector2 setget set_target_direction, get_target_direction

func set_entry_direction(new_direction: Vector2) -> void: 
		entry_direction = new_direction.normalized()

func get_entry_direction() -> Vector2:
	return entry_direction
	
func set_target_direction(new_direction: Vector2) -> void:
	target_direction = new_direction.normalized()

func get_target_direction() -> Vector2:
	return target_direction

func _ready():
	set_piece_rotation()

func set_piece_rotation():
	match entry_direction:
		Vector2(1,0):
			match target_direction:
				Vector2(0,1): 
					$Sprite.set_rotation_degrees(90)
				Vector2(0,-1):
					$Sprite.set_rotation_degrees(90)
					$Sprite.set_flip_h(true)
		Vector2(-1,0):
			match target_direction:
				Vector2(0,1):
					$Sprite.set_rotation_degrees(90)
					$Sprite.set_flip_v(true)
				Vector2(0,-1):	
					$Sprite.set_rotation_degrees(270)
		Vector2(0,1):
			match target_direction:
				Vector2(1,0):
					$Sprite.set_flip_v(true)
				Vector2(-1,0):
					$Sprite.set_rotation_degrees(180)
		Vector2(0,-1):
				match target_direction:	
					Vector2(1,0):
						continue 
					Vector2(-1,0):
						$Sprite.set_flip_h(true)