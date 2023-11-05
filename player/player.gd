extends CharacterBody2D


signal game_over

const SPEED := 128.0
const TURN_SPEED := 2.5
const MAX_LENGTH := 32

var length: int = MAX_LENGTH
var dir: Vector2 = Vector2.RIGHT
var parts: Array[Vector2] = []

@onready var timer: Timer = $Timer
@onready var trail: Line2D = $Trail


func _ready() -> void:
	# Avoid the trail rotating when the player rotates.
	trail.top_level = true
	for i in MAX_LENGTH:
		parts.append(position)

	timer.start()


func _physics_process(delta: float) -> void:
	var rotation_dir := Input.get_axis("turn_left", "turn_right")
	rotation += TURN_SPEED * rotation_dir * delta

	velocity = Vector2.from_angle(rotation) * SPEED
	move_and_slide()

	_draw_trail()


func _draw_trail() -> void:
	length = roundi(timer.time_left / timer.wait_time * MAX_LENGTH)
	# Set front part to current position.
	parts[0] = position
	# Move parts, starting from the second, to the part in front of them.
	var new_parts := parts.duplicate()
	for i in range(1, parts.size()):
		new_parts[i] = parts[i - 1]
	parts = new_parts

	# Set trail points to only the parts that match the current length.
	var points := parts.duplicate()
	points.resize(length)
	trail.points = points


func _on_collectible_detector_area_entered(area: Area2D) -> void:
	timer.start()


func _on_timer_timeout() -> void:
	game_over.emit()
	queue_free()
