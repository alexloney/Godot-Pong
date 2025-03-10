extends RigidBody2D

var velocity = Vector2(0, 0)
var speed = 200
var default_speed = 200
var difficulty_increase_increment : int = 25

func stop_movement():
	velocity = Vector2(0, 0)

func reset_position():
	position = Vector2(576, 351)

func begin_movement():
	var direction = randi() % 2 # 0 = left, 1 = right
	var up_down = randi() % 2 # 0 = up, 1 = down
	
	if direction == 0: # Left
		velocity.x = -1
	else: # Right
		velocity.x = 1
	
	if up_down == 0: # Up
		velocity.y = randi_range(-1, -4)
	else: # Down
		velocity.y = randi_range(1, 4)
	
	velocity = velocity.normalized()

func increase_speed():
	speed += difficulty_increase_increment

func reset_speed():
	speed = default_speed

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * speed * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())

func _on_paddle_body_entered(body: Node2D) -> void:
	# velocity = Vector2(-velocity.x, velocity.y * randf_range(-0.5, 0.5)).normalized()
	velocity = Vector2(-velocity.x, velocity.y)


func _on_left_score_body_entered(body: Node2D) -> void:
	get_parent().score_right()


func _on_right_score_body_entered(body: Node2D) -> void:
	get_parent().score_left()
