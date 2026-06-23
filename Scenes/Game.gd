extends Node2D

const DICE = preload("uid://cnnq8824yg5bk")
const MARGIN: float = 80.0
const STOPPABLE_GROUP: String = "stoppable"

@onready var dice_timer = $DiceTimer


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	



# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_dice()


func spawn_dice()-> void:
	var new_dice: Dice = DICE.instantiate()
	var vpr: Rect2 = get_viewport_rect()
	var new_x: float = randf_range(vpr.position.x + MARGIN, vpr.end.x - MARGIN)
	
	new_dice.position = Vector2(new_x, -MARGIN)
	new_dice.game_over.connect(_on_dice_game_over)
	add_child(new_dice)


func pause_all() -> void:
	dice_timer.stop()
	var to_stop: Array[Node] = get_tree().get_nodes_in_group(STOPPABLE_GROUP)
	for item in to_stop:
		item.set_physics_process(false)


func _on_dice_game_over():
	pause_all()
	print ("GAME OVER")


func _on_dice_timer_timeout():
	spawn_dice()
