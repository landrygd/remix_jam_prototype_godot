extends Area2D


const MARGIN := Vector2(-100, -100)

# Random position
var top_left_limit: Vector2 = MARGIN
var bottom_right_limit: Vector2


func _ready() -> void:
	bottom_right_limit = get_viewport_rect().size - MARGIN
	_on_spawn()


func _move_to_random_position() -> void:
	var x := randf_range(top_left_limit.x, bottom_right_limit.x)
	var y := randf_range(top_left_limit.y, bottom_right_limit.y)
	position = Vector2(x, y)


func _on_area_entered(area: Area2D) -> void:
	_on_spawn()

func _on_spawn() -> void:
	_set_random_frame()
	_move_to_random_position()

func _set_random_frame() -> void:
	var frame := randi() % 3
	$AnimatedSprite2D.animation = "default"
	$AnimatedSprite2D.frame = frame
