extends Node2D
@onready var Bullet = preload("res://scenes/friendly/bullet.tscn")
@onready var nodee = $example
var w: bool = false
var s: bool = false
var a: bool = false
var d: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if w and position.y > 80/2:
		position.y -= 1000 * delta
	if s and position.y < 648 - 80/2: 
		position.y += 1000 * delta
	if a and position.x > 80/2: 
		position.x -= 1000 * delta
	if d and position.x < 1152 - 80/2:
		position.x += 1000 * delta
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("W_Key"):
		w = true
	if event.is_action_released("W_Key"):
		w = false
	if event.is_action_pressed("A_Key"):
		a = true
	if event.is_action_released("A_Key"):
		a = false
	if event.is_action_pressed("S_Key"):
		s = true
	if event.is_action_released("S_Key"):
		s = false
	if event.is_action_pressed("D_Key"):
		d = true
	if event.is_action_released("D_Key"):
		d = false
	if event.is_action_pressed("F_Key"):
			var bull = Bullet.instantiate()
			bull.set_x_y(position.x, position.y) 
			get_tree().current_scene.add_child(bull)
func _on_area_2d_area_entered(area: Area2D) -> void:
	nodee.texture = load("res://resources/sprites/friendly/heart_hit.png")
