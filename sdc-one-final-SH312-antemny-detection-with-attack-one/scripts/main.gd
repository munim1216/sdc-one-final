extends Node2D
@onready var Bullet = preload("res://scenes/hostile/evil_bullet.tscn")
@onready var Slash = preload("res://scenes/hostile/slash.tscn")
var dt = 0
var game = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load("res://resources/backgrounds/game_bg.png")
	game = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	dt += delta
	var rare = randi_range(1,2)
	var node =get_node_or_null("examplesprite")
	var not_dead = true
	if node != null:
		not_dead = node.am_dead()
	var antemy = get_node_or_null("Antemy")
	if (node == null or !not_dead) and game:
		game = false
		$Antemy.queue_free()
		await get_tree().create_timer(3).timeout
		$TextureRect.texture = load("res://resources/backgrounds/lose_bg.png")
	if antemy == null and game:
		$TextureRect.texture = load("res://resources/backgrounds/Win_bg.png")
		game = false
		$examplesprite.queue_free()
	if rare == 0:
		if dt > 0.15:
			dt -= 0.15
			var bull = Bullet.instantiate()
			bull.set_x_y(randi_range(0, 1500), 10) 
			get_tree().current_scene.add_child(bull)
	elif rare == 0:
		if dt > 0.15:
			dt -= 0.15
			var cut = Slash.instantiate()
			cut.set_x_y(randi_range(10,1490), randi_range(10,740))
			get_tree().current_scene.add_child(cut)
