extends "pawn.gd"

var entry_direction: Vector2 setget set_entry_direction, get_entry_direction
var target_direction: Vector2 setget set_target_direction, get_target_direction


func init(entry_direction: Vector2, target_direction: Vector2):
	self.set_entry_direction(entry_direction)
	self.set_target_direction(target_direction)

func set_entry_direction(new_direction: Vector2) -> void: 
		entry_direction = new_direction.normalized()

func get_entry_direction() -> Vector2:
	return entry_direction
	
func set_target_direction(new_direction: Vector2) -> void:
	target_direction = new_direction.normalized()

func get_target_direction() -> Vector2:
	return target_direction

func _ready():
	set_vectors_based_on_rotation()
	print("Piece: ", self.get_name(), "\nRotation:", self.get_rotation_degrees(), "\nEntry vector :", self.get_entry_direction(), "\nTarget vector: ", self.get_target_direction(), "\n")

func set_piece_rotation():
	match entry_direction:
		Vector2(1,0):
			match target_direction:
				Vector2(0,1): 
					.set_rotation_degrees(90)
				Vector2(0,-1):
					$Pivot/Pivot/Sprite.set_rotation_degrees(90)
					$Pivot/Sprite.set_flip_h(true)
		Vector2(-1,0):
			match target_direction:
				Vector2(0,1):
					$Pivot/Sprite.set_rotation_degrees(90)
					$Pivot/Sprite.set_flip_v(true)
				Vector2(0,-1):	
					$Pivot/Sprite.set_rotation_degrees(270)
		Vector2(0,1):
			match target_direction:
				Vector2(1,0):
					$Pivot/Sprite.set_flip_v(true)
				Vector2(-1,0):
					$Pivot/Sprite.set_rotation_degrees(180)
		Vector2(0,-1):
				match target_direction:	
					Vector2(1,0):
						continue 
					Vector2(-1,0):
						$Pivot/Sprite.set_flip_h(true)

func set_vectors_based_on_rotation():
		match int(self.get_rotation_degrees()):
			0:
				self.set_entry_direction(Vector2(0,-1))
				self.set_target_direction(Vector2(1,0))
			90:
				print("90 degree rotation")
				self.set_entry_direction(Vector2(1,0))
				self.set_target_direction(Vector2(0,1))
			180:
				self.set_entry_direction(Vector2(0,1))
				self.set_target_direction(Vector2(-1,0))
			270:
				self.set_entry_direction(Vector2(-1,0))
				self.set_target_direction(Vector2(0,-1))
		
		if $Pivot/Sprite.is_flipped_v() or self.get_scale().y < 0:
			self.set_entry_direction(get_entry_direction() * -1)
		if $Pivot/Sprite.is_flipped_h() or self.get_scale().x < 0:
			self.set_target_direction(get_target_direction() * -1)	
		
		
