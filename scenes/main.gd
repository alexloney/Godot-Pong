extends Node

# Variables for tracking the left and right scores
var left_score = 0
var right_score = 0

# When the scene starts, begin a match
func _ready() -> void:
	start_match()

# Watch for the ESC key and exit the game if entered
func _input(event: InputEvent) -> void:
		if event.is_action_pressed("escape"):
			get_tree().quit()

# Start a match after a 1.5 second delay
func start_match():
	await get_tree().create_timer(1.5).timeout
	$Ball.begin_movement()
	$Ball.reset_speed()
	$LeftPaddle.reset_position()
	$LeftPaddle.reset_ai_difficulty()
	$RightPaddle.reset_position()
	$RightPaddle.reset_ai_difficulty()

# Add a point for the left side, then restart the game after a half second delay
func score_left():
	left_score += 1
	$Scores/LeftScore.text = str(left_score)
	$Ball.stop_movement()
	
	await get_tree().create_timer(0.5).timeout
	$Ball.reset_position()
	start_match()

# Add a point for the right side, then restart the game after a half second delay
func score_right():
	right_score += 1
	$Scores/RightScore.text = str(right_score)
	$Ball.stop_movement()
	
	await get_tree().create_timer(0.5).timeout
	$Ball.reset_position()
	start_match()


func _on_difficulty_timer_timeout() -> void:
	$Ball.increase_speed()
	$LeftPaddle.increase_ai_difficulty()
	$RightPaddle.increase_ai_difficulty()
