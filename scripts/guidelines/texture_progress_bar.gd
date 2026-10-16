extends TextureProgressBar

@onready var ant = get_parent().get_parent()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ant.took_damage.connect(update) 
	update()


func update():
	value = (100 - ant.damage)
