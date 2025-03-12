extends Node2D
@onready var Bullet = preload("res://scenes/friendly/bullet.tscn")
@onready var nodee = $AnimatedSprite2D
var w: bool = false
var s: bool = false
var a: bool = false
var d: bool = false
var can_shoot: bool = true
const current_down_run = ["Run_down_2_damage","Run_down_1_damage","Run_down_full_health"]
const current_down_stand = ["Stand_down_2_damage","Stand_down_1_damage","Stand_down_full_health"]
const current_up_run = ["Run_up_damage_2","Run_up_damage_1", "Run_up_full_health"]
const current_up_stand = ["Stand_up_damage_2", "Stand_up_damage_1","Stand_up_full_health"]
const current_left_stand = ["Stand_left_damage_2","Stand_left_damage_1","Stand_left_full_health"]
const current_left_run = ["Run_left_damage_2","Run_left_damage_1","Run_left_full_health"]
const current_right_run = ["Run_right_damage_2","Run_right_damage_1","Run_right_full_health"]
const current_right_stand = ["Stand_right_damage_2","Stand_right_damage_1","Stand_right_full_health"]
const movement_speed = 700
var lives = 3
var index = 2
var is_alive = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nodee.play("Stand_down_full_health") 
	is_alive = true# Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lives > 0:
		if w and position.y > 40 and (not (a or d)):
			position.y -= movement_speed * delta
			nodee.play(current_up_run[index])
		if s and position.y < 648 - 40 and (not (a or d)): 
			nodee.play(current_down_run[index])
			position.y += movement_speed * delta
		if a and position.x > 40 and (not (w or s)): 
			position.x -= movement_speed * delta
			nodee.play(current_left_run[index])
		if d and position.x < 1152 - 40 and (not (w or s)):
			position.x += movement_speed * delta
			nodee.play(current_right_run[index])
		if w and d and position.x < 1152 - 40 and position.y > 40 and (not(s or a)):
			position.y -= (movement_speed * delta)/sqrt(2)
			position.x += (movement_speed * delta)/sqrt(2)
			nodee.play(current_right_run[index])
		if s and d and position.y < 648 - 40 and position.x < 1152 - 4 and (not(w or a)):
			position.y += (movement_speed * delta)/sqrt(2)
			position.x += (movement_speed * delta)/sqrt(2)
			nodee.play(current_right_run[index])
		if s and a and position.y < 648 - 40 and position.x > 40 and (not(w or d)):
			position.y += (movement_speed * delta)/sqrt(2)
			position.x -= (movement_speed * delta)/sqrt(2)
			nodee.play(current_left_run[index])
		if w and a and position.y > 40 and position.x > 40 and (not(s or d)):
			position.y -= (movement_speed * delta)/sqrt(2)
			position.x -= (movement_speed * delta)/sqrt(2)
			nodee.play(current_left_run[index])
	else:
		is_alive = false
		print("Dead")
		nodee.play("death_animation")
		await get_tree().create_timer(3).timeout
		queue_free()
func _input(event: InputEvent) -> void:
	if lives > 0:
		if event.is_action_pressed("W_Key") or event.is_action_pressed("Up_Key"):
			w = true
		if event.is_action_released("W_Key") or event.is_action_released("Up_Key"):
			w = false
			nodee.play(current_up_stand[index])
		if event.is_action_pressed("A_Key") or event.is_action_pressed("Left_Key"):
			a = true
		if event.is_action_released("A_Key") or event.is_action_released("Left_Key"):
			a = false
			nodee.play(current_left_stand[index])
		if event.is_action_pressed("S_Key") or event.is_action_pressed("Down_Key"):
			s = true
		if event.is_action_released("S_Key") or event.is_action_released("Down_Key"):
			s = false
			nodee.play(current_down_stand[index])
		if event.is_action_pressed("D_Key") or event.is_action_pressed("Right_Key"):
			d = true
		if event.is_action_released("D_Key") or event.is_action_released("Right_Key"):
			d = false
			nodee.play(current_right_stand[index])
		if event.is_action_pressed("Space_Key") and can_shoot:
				var bull = Bullet.instantiate()
				bull.set_x_y(position.x, (position.y)) 
				get_tree().current_scene.add_child(bull)
				print("shoot")
				can_shoot = false
				await get_tree().create_timer(.5).timeout
				can_shoot = true
	if event.is_action_pressed("H_Key"):
		lives = 3
		index = 2
		nodee.play(current_down_stand[index])
	if event.is_action_pressed("ESC_Key"):
		get_tree().quit()
func _on_area_2d_area_entered(_area: Area2D) -> void:
	lives -= 1
	print("Hit!!",lives)
	index -= 1
	#found from https://forum.godotengine.org/t/letting-a-sprite-animation-finish/26618/2
	var current_animation = nodee.animation
	if index > -1:
		if (current_animation in current_down_stand):
			nodee.play(current_down_stand[index])
		elif (current_animation in current_down_run):
			nodee.play(current_down_run[index])
		elif (current_animation in current_left_stand):
			nodee.play(current_left_stand[index])
		elif (current_animation in current_left_run):
			nodee.play(current_left_run[index])
		elif (current_animation in current_right_run):
			nodee.play(current_right_run[index])
		elif (current_animation in current_right_stand):
			nodee.play(current_right_stand[index])
		elif (current_animation in current_up_run):
			nodee.play(current_up_run[index])
		elif (current_animation in current_up_stand):
			nodee.play(current_up_stand[index])

func am_dead():
	return is_alive
