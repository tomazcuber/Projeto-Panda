extends "pawn.gd"

onready var Grid = get_parent()
var look_direction setget set_look_direction, get_look_direction
var move_start : bool = false
func _ready():
	set_look_direction(Vector2(1,0))

func _process(delta):
	#var input_direction : Vector2 = get_input_direction()
	#if not input_direction:
	#	return
	#set_look_direction(input_direction)
	#print(input_direction)
	
	
	if (Input.is_action_just_pressed("ui_accept")):
		move_start = true
	
	if move_start: 
		move_while_free()

	

func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

func set_look_direction(direction: Vector2):
	look_direction = direction
	$Pivot/Sprite.rotation = look_direction.angle()		

func get_look_direction():
	return look_direction 

func move_to(target_position):
	set_process(false)
	$AnimationPlayer.play("walk")

	var move_direction = (target_position - position).normalized()
	$Tween.interpolate_property($Pivot, "position", - move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	position = target_position

	$Tween.start()

	yield($AnimationPlayer, "animation_finished")

	set_process(true)

func bump():
	set_process(false)
	$AnimationPlayer.play("bump")
	yield($AnimationPlayer, "animation_finished")
	set_process(true)

func move_while_free(): 
	var target_position = Grid.request_move(self, get_look_direction())
	
	if target_position:
		set_process(false)
		$AnimationPlayer.play("walk")
	
		var move_direction = (target_position - position).normalized()
		$Tween.interpolate_property($Pivot, "position", - move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
		position = target_position
	
		$Tween.start()
	
		yield($AnimationPlayer, "animation_finished")
	
		set_process(true)