extends RigidBody2D

var velocity = Vector2(0, 0)
var speed = 200
var default_speed = 200
var difficulty_increase_increment : int = 25

# Freeze the ball where it is at by removing its velocity
func stop_movement():
	velocity = Vector2(0, 0)

# Reset the ball position to the center of the arena
func reset_position():
	position = Vector2(576, 351)

func begin_movement():
	# Pick a direction for the ball (left or right)
	var direction = randi() % 2 # 0 = left, 1 = right
	
	# Pick a direction for the ball (up or down)
	var up_down = randi() % 2 # 0 = up, 1 = down
	
	# Create the vector assigning the left/right and up/down selected
	if direction == 0: # Left
		velocity.x = -1
	else: # Right
		velocity.x = 1
	
	if up_down == 0: # Up
		velocity.y = randi_range(-1, -4)
	else: # Down
		velocity.y = randi_range(1, 4)
	
	# Normalize this vector so that it only includes direction and not
	# speed. Speed is determined by the "speed" variable.
	velocity = velocity.normalized()

# Increment the speed to have an incremental difficulty increase
func increase_speed():
	speed += difficulty_increase_increment

# Reset the speed of the ball back to default value
func reset_speed():
	speed = default_speed

func _physics_process(delta: float) -> void:
	# When the ball collides with a wall, we will invoke the "bounce()" method
	# to bounce the ball off the wall instead of it sticking and sliding on the
	# wall.
	var collision_info = move_and_collide(velocity * speed * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())

func _on_paddle_body_entered(body: Node2D) -> void:
	# Reverse the direciton of the ball on the X value
	velocity = Vector2(-velocity.x, velocity.y)
	
	# Adjust the ball Y velocity just slightly depending on where it is hit. This
	# is to prevent the ball position from becoming reptitive and producing a
	# pattern.
	if body.position.y < position.y: # Ball on lower side of paddle
		velocity.y -= 0.01
	elif body.position.y > position.y: # Ball on upper side of paddle
		velocity.y += 0.1

func _on_left_score_body_entered(body: Node2D) -> void:
	get_parent().score_right()

func _on_right_score_body_entered(body: Node2D) -> void:
	get_parent().score_left()
