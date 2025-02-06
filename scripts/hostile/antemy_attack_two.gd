extends Node2D

@onready var pincer_one = $antemy_attack_sprite_one

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pincer_one.rotate(deg_to_rad(10))
