extends CharacterBody2D


signal DamageDealt(damage)
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var sword_hitbox_left: CollisionShape2D = $SwordHitboxLeft
@onready var sword_hitbox_right: CollisionShape2D = $SwordHitboxRight
@onready var timer: Timer = $Timer

var rng = RandomNumberGenerator.new()
var speed = 150
var animation_lock = false
var damage: float = 10.0;


func _physics_process(delta):
	# Movement
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")
	
	if direction_x && !animation_lock:
		velocity.x = direction_x * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if direction_y && !animation_lock:
		velocity.y = direction_y * speed * delta
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	# Movement animation
	if direction_x == 0 && direction_y == 0:
		_change_animation("idle")
	else:
		_change_animation("run")
		if direction_x < 0:
			animated_sprite_2d.flip_h = true

		elif direction_x > 0:
			animated_sprite_2d.flip_h = false

	velocity = velocity.normalized() * speed
	move_and_slide()


	# Attack Animation
	if (Input.is_action_just_pressed("attack")):
		var attack_number = rng.randi_range(0, 1)

		if attack_number == 0:
			_change_animation("attack1")
			animation_lock = true
		elif attack_number == 1:
			_change_animation("attack2")
			animation_lock = true
		else:
			print(attack_number)

		timer.start(0.1)
		if timer.time_left >= 0.0:
			if animated_sprite_2d.flip_h:
				sword_hitbox_left.disabled = false
			else:
				sword_hitbox_right.disabled = false


func _change_animation(animation_name):
	if animation_lock == false:
		animated_sprite_2d.play(animation_name)
		sword_hitbox_left.disabled = true
		sword_hitbox_right.disabled = true


func _on_animation_finished():
	animation_lock = false


func deal_damage():
	emit_signal('Damage', damage)

