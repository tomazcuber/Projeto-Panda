extends "pawn.gd"

onready var Grid = get_parent()

func _ready():
	update_look_direction(Vector2(1,0))

func _process(delta):
	var input_direction = get_input_direction()

	if not input_direction:
		return
	update_look_direction(input_direction)	
	
	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		var move_direction = (target_position - position).normalized()
		position = target_position 


func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

func update_look_direction(direction):
	$Pivot/Sprite.rotation = direction.angle()		