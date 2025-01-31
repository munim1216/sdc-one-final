extends Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 1000 * delta
	if position.y > 750:
		queue_free()
func set_x_y(x: int, y: int):
	position.x = x
	position.y = y
