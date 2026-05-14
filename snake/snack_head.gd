extends CharacterBody2D


var SPEED :float= 500.0
const TIME :float= 0.1

var bodyCount = 0
var t :float= 0.0
const SNACK_BODY = preload("uid://caeyjq0lmccka")

func _ready() -> void:
	for i in range(10):
		add()
		await get_tree().create_timer(0.1).timeout

func _physics_process(delta: float) -> void:
	var directionAxis = Input.get_axis("up","down")
	var directionHorizon = Input.get_axis("left","right")
	var direction = Vector2(directionHorizon,directionAxis)
	if direction != Vector2.ZERO:
		velocity = Vector2(directionHorizon,directionAxis).normalized() * SPEED
	move_and_slide()

func _process(delta: float) -> void:
	pass

func add() -> void:
	bodyCount+=1
	var _new = SNACK_BODY.instantiate()
	
	if bodyCount == 1:
		_new.position = position
	else:
		_new.position = get_parent().get_node("snack_body" + str(bodyCount-1)).position
	_new.name = "snack_body" + str(bodyCount)
	print("add:"+_new.name)
	_new.head = self
	velocity = velocity * (SPEED - 20) / SPEED
	SPEED -= 20
	get_parent().add_child.call_deferred(_new)

func delete() -> void:
	if bodyCount==0:
		return 
	get_parent().get_node("snack_body" + str(bodyCount)).delete()
	velocity = velocity * (SPEED + 20) / SPEED
	SPEED += 20
	bodyCount-=1


func _on_button_button_down() -> void:
	add()


func _on_button_2_button_down() -> void:
	delete()


func _on_area_2d_area_entered(area: Area2D) -> void:
	var fruit = area.get_parent()
	if fruit.is_in_group("fruit"):
		fruit.delete()
		add()
