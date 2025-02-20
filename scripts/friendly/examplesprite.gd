extends Node2D
@onready var Bullet = preload("res://scenes/friendly/bullet.tscn")
@onready var nodee = $example
var w: bool = false
var s: bool = false
var a: bool = false
var d: bool = false
const movement_speed = 700
var lives = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if w and position.y > 40 and (not (a or d)):
		position.y -= movement_speed * delta
	if s and position.y < 648 - 40 and (not (a or d)): 
		position.y += movement_speed * delta
	if a and position.x > 40 and (not (w or s)): 
		position.x -= movement_speed * delta
	if d and position.x < 1152 - 40 and (not (w or s)):
		position.x += movement_speed * delta
	if w and d and position.x < 1152 - 40 and position.y > 40 and (not(s or a)):
		position.y -= (movement_speed * delta)/sqrt(2)
		position.x += (movement_speed * delta)/sqrt(2)
	if s and d and position.y < 648 - 40 and position.x < 1152 - 4 and (not(w or a)):
		position.y += (movement_speed * delta)/sqrt(2)
		position.x += (movement_speed * delta)/sqrt(2)
	if s and a and position.y < 648 - 40 and position.x > 40 and (not(w or d)):
		position.y += (movement_speed * delta)/sqrt(2)
		position.x -= (movement_speed * delta)/sqrt(2)
	if w and a and position.y > 40 and position.x > 40 and (not(s or d)):
		position.y -= (movement_speed * delta)/sqrt(2)
		position.x -= (movement_speed * delta)/sqrt(2)
	if lives <=0:
		nodee.texture = load("res://resources/sprites/friendly/heart_hit.png")
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
			bull.set_x_y(position.x, (position.y)) 
			get_tree().current_scene.add_child(bull)
			print("shoot")
	if event.is_action_pressed("H_Key"):
		nodee.texture = load("res://resources/sprites/friendly/heart.png")
		lives = 3
	if event.is_action_pressed("ESC_Key"):
		get_tree().quit()
func _on_area_2d_area_entered(_area: Area2D) -> void:
	lives -= 1
	if lives > 0:
		for i in range(2):
			nodee.texture = load("res://resources/sprites/friendly/heart_hit.png")
			await get_tree().create_timer(.2).timeout
			nodee.texture = load("res://resources/sprites/friendly/heart.png")
			await get_tree().create_timer(.2).timeout
	print("Hit!!",lives)
	
