extends Node2D
var game = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load("res://resources/backgrounds/game_bg.png")
	game = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
