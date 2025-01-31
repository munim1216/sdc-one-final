extends Node2D
@onready var Bullet = preload("res://scenes/hostile/evil_bullet.tscn")
@onready var Slash = preload("res://scenes/hostile/slash.tscn")
var dt = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dt += delta
	var rare = randi_range(1,2)
	if rare == 1:
		if dt > 0.15:
			dt -= 0.15
			var bull = Bullet.instantiate()
			bull.set_x_y(randi_range(0, 1500), 10) 
			get_tree().current_scene.add_child(bull)
	elif rare == 2:
		if dt > 0.15:
			dt -= 0.15
			var cut = Slash.instantiate()
			cut.set_x_y(randi_range(10,1490), randi_range(10,740))
			get_tree().current_scene.add_child(cut)
