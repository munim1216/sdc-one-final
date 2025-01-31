extends Node2D

const CENTER = 544
const LEFT_BOUND = 32
const RIGHT_BOUND = 1152 -32
# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = CENTER
var speed = 500
var direction = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance_from_center = abs(position.x - CENTER) / ((RIGHT_BOUND - LEFT_BOUND) / 2)
	# Adjust speed using an easing function (e.g., quadratic)
	var adjusted_speed = speed * (1 - .25 * (1 - distance_from_center)**2)
	position.x += adjusted_speed * direction * delta
	if position.x < LEFT_BOUND:
		position.x = LEFT_BOUND
		direction = 1  # Change direction to right
	elif position.x > RIGHT_BOUND:
		position.x = RIGHT_BOUND
		direction = -1  # Change direction to left
