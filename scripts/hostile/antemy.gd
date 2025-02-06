extends Node2D
@onready var side_move_bullet = preload("res://scenes/hostile/evil_bullet.tscn")
@onready var arrow = preload("res://scenes/guidelines/guide_arrow.tscn")
const CENTER = 544
const LEFT_BOUND = 32
const RIGHT_BOUND = 1152 -32
var time = 0
# Called when the node enters the scene tree for the first time.

func spwan_attack_one():
	var bullet = side_move_bullet.instantiate()
	var director = arrow.instantiate()
	var loaction = Vector2(10, randi_range(0,750))
	bullet.set_x_y(loaction.x, loaction.y)
	director.set_x_y(loaction.x,loaction.y)
	get_tree().current_scene.add_child(director)
	get_tree().current_scene.add_child(bullet)
	print("spawn")
	
func _ready():
	position.x = CENTER
var speed = 500
var direction = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
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
	if time >= 1:
		for i in range(randi_range(1,3)):
			spwan_attack_one()
		time -= 1

