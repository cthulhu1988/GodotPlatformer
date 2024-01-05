extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 50.0
const JUMP_VELOCITY = -60.0
var chase = false

var player

func _physics_process(delta):
	velocity.y += gravity * delta
	if(chase == true):
		if(get_node("AnimatedSprite2D").animation != "Death"):
			get_node("AnimatedSprite2D").play("Jump")
			player = get_node("../../Player/Player")
			var direction = (player.position - self.position).normalized() 
			if(direction.x > 0):
				get_node("AnimatedSprite2D").flip_h = true
				velocity.x = direction.x * SPEED
			else:
				get_node("AnimatedSprite2D").flip_h = false
				velocity.x = direction.x * SPEED
	else:
		if(get_node("AnimatedSprite2D").animation != "Death"):
			velocity.x = 0
			get_node("AnimatedSprite2D").play("Idle")
	move_and_slide()



func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		print("entered player")

			


func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
		print("exit player")


func _on_player_death_body_entered(body):
	if body.name == "Player":
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()
		


func _on_animated_sprite_2d_animation_finished():
	pass # Replace with function body.
