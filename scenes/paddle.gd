extends Area2D

@export var speed : int = 300
@export var ai_speed : int = 200
var default_ai_speed : int = 200
var difficulty_increase_speed : int = 20
@export var left_paddle : bool = true
@export var use_ai : bool = false

var min_paddle_position : int = 106
var max_paddle_position : int = 596
var paddle_starting_position_y : int = 314

# Apply the world boundaries to keep the paddle within the scene
func apply_bounds() -> void:
	position.y = clamp(position.y, min_paddle_position, max_paddle_position)

# Detect movement based on the player keyboard presses, skip movement if the
# mouse is pressed though, this allows the mouse to override keyboard movement
func player_move(delta: float) -> void:
	if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if Input.is_action_pressed("up"):
			position.y -= speed * delta
		elif Input.is_action_pressed("down"):
			position.y += speed * delta

# Detect mouse clicks and place the paddle where the mouse has clicked
func player_mouse_move(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and "position" in event:
		position.y = event.position.y

# AI will simply follow the ball position based on the AI speed. This AI is
# beatable because the speed is lower than the ball speed. So eventually the ball
# will outpace the AI.
func ai_move(delta: float) -> void:
	var ball : RigidBody2D = get_parent().get_node("Ball")
	
	if ball.position.y < position.y:
		position.y -= ai_speed * delta
	elif ball.position.y > position.y:
		position.y += ai_speed * delta

# Incrementally increase the AI difficulty
func increase_ai_difficulty() -> void:
	ai_speed += difficulty_increase_speed

# Reset the AI difficulty back to the default value
func reset_ai_difficulty() -> void:
	ai_speed = default_ai_speed

# Reset the paddle back to the center
func reset_position() -> void:
	position.y = paddle_starting_position_y

func _process(delta: float) -> void:
	if use_ai:
		ai_move(delta)
	else:
		player_move(delta)
	apply_bounds()

func _input(event: InputEvent) -> void:
	if not use_ai:
		player_mouse_move(event)
	apply_bounds()

func _on_ball_body_entered(body: Node) -> void:
	if body.is_in_group("Ball"):
		body.velocity.x *= -1
