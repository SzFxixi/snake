extends Node2D

const FRUIT = preload("uid://cwbwyaqoc6spk")
const ENEMY = preload("uid://bv1gs3ltpl28p")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_3_button_down() -> void:
	var new = FRUIT.instantiate()
	add_child(new)
	new.position = Vector2(randi_range(0,1080),randi_range(0,648))

func _on_button_4_button_down() -> void:
	var new = ENEMY.instantiate()
	add_child(new)
	new.position = Vector2(randi_range(0,1080),0)
