extends Area2D


const MAX_HEALTH: float = 10.0
var health: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = MAX_HEALTH
	

func take_damage(damage: float):
	health -= damage
	
	if health <= 0:
		get_parent().queue_free()


func _on_area_entered(characterBody2d: CharacterBody2D) -> void:
	take_damage(5)
