extends Node2D


@onready var player: CharacterBody2D = $Player
@onready var press_r_label: Label = $PressRLabel


func _ready() -> void:
	player.game_over.connect(_on_game_over)


func _on_game_over() -> void:
	press_r_label.show()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
