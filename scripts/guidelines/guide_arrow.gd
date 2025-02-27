extends Node2D

var time = 0
var delay = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if time >= delay:
		queue_free()
func set_x_y(x: int, y: int):
	position.x = x
	position.y = y
