extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
var timer = 0
var movemet_type = randi_range(1,4)
func _process(delta: float) -> void:
	timer += delta
	if movemet_type == 1:
		get_node("Slash2DSprite").flip_h = true
		position.y += 500 * delta
		position.x += 500 * delta
	elif movemet_type == 2:
		position.y -= 500 * delta
		position.x += 500 * delta
	elif movemet_type ==3:
		position.y += 500 * delta
		position.x -= 500 * delta
	elif movemet_type == 4:
		get_node("Slash2DSprite").flip_h = true
		position.y -= 500 * delta
		position.x -= 500 * delta
	if timer >= 1:
		timer = 0
		queue_free()
		movemet_type = randi_range(1,4)
func set_x_slash_y(x: int, y: int):
	position.x = x
	position.y = y
