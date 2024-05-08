extends Node


@export var MAX_HEALTH = 10.0

var health: float


func _ready():
	health = MAX_HEALTH

func take_damage(damage: float):
	health -= damage
	
	if health <= 0:
		get_parent().queue_free()
