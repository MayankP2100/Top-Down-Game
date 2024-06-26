extends Area2D


@onready var player: CharacterBody2D = $'../Player'
@onready var hit_sound: AudioStreamPlayer2D = $'HitSound'
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const MAX_HEALTH: float = 30.0
var health: float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = MAX_HEALTH
	player.connect('DamageDealt', Callable(self, 'take_damage'))
	

func take_damage(damage: float):
	health -= damage
	print(health)
	if health <= 0:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	hit_sound.play()
	animation_player.play("flash")


func _on_hit_sound_finished() -> void:
	take_damage(10.0)
