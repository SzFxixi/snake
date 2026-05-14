extends CharacterBody2D

@export var SPEED = 200

func _ready() -> void:
	add_to_group("enemy")
	velocity = Vector2(0,200)

func _process(delta: float) -> void:
	velocity += Vector2(0,1) * delta * SPEED
	move_and_slide()

func delete() -> void:
	queue_free()
