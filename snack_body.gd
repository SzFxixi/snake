extends CharacterBody2D


const SPEED :float= 300.0
const TIME :float= 0.25

var head : CharacterBody2D
var t :float= 0.0
var next : CharacterBody2D


func _ready() -> void:
	if name == "snack_body1":
		next = get_parent().get_node("snack_head")
	for i in range(2,get_parent().get_child_count()):
		if str(i) in name:
			next = get_parent().get_node("snack_body"+str(i-1))

func _physics_process(delta: float) -> void:
	t+=delta
	if t>TIME:
		t=0
		move()

func _process(delta: float) -> void:
	pass

func move():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"position",next.position,TIME)
	
func delete():
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property(self,"scale",Vector2(0.1,0.1),0.5)
	tween.tween_property(self,"modulate",Color(1,1,1,0),0.5)
	
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	if enemy.is_in_group("enemy"):
		enemy.delete()
		head.delete()
