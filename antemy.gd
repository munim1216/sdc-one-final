extends Node2D
@onready var side_move_bullet = preload("res://scenes/hostile/evil_bullet.tscn")
@onready var arrow = preload("res://scenes/guidelines/guide_arrow.tscn")
const CENTER = 544
const LEFT_BOUND = 32
const RIGHT_BOUND = 1152 -32
var time = 0
var spawn_delay = 1
var max_enemy_spawn = 8
var damage = 0
# Called when the node enters the scene tree for the first time.

func spwan_attack_one(timer):
	var bullet = side_move_bullet.instantiate()
	var director = arrow.instantiate()
	var loaction = Vector2(10, randi_range(0,648))
	bullet.set_x_y(loaction.x, loaction.y)
	director.set_x_y(loaction.x,loaction.y)
	bullet.rotate(3.14/2)
	get_tree().current_scene.add_child(director)
	# wait x seconds aquired from https://forum.godotengine.org/t/in-gdscript-is-there-codes-looks-like-pythons-time-sleep/1047/3
	await get_tree().create_timer(timer).timeout
	get_tree().current_scene.add_child(bullet)
	print("spawn bullet")
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
	if time >= spawn_delay:
		for i in range(randi_range(1,max_enemy_spawn)):
			spwan_attack_one(time)
		time -= spawn_delay
	if damage == 100:
		await get_tree().create_timer(.5).timeout
		print("Victory")
		queue_free()
func _on_area_2d_area_entered(_area: Area2D) -> void:
	damage += 10
	print("damage", damage)
