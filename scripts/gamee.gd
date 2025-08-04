extends Node2D

@onready var ball = $Ball
@onready var paddle_one = $Paddle_One
@onready var paddle_two = $Paddle_Two

@onready var detector_left = $Detector_Left
@onready var detector_right = $Detector_Right
@onready var start_delay = $Start_Delay

@onready var ui = $CanvasLayer/UI

var game_area_size = Vector2(1280, 720)

var score = Vector2i.ZERO
@export var final_score = 10
 
func _ready() -> void:
	detector_left.ball_out.connect(on_detrctor_ball_out)
	detector_right.ball_out.connect(on_detrctor_ball_out)
	
	randomize()
	reset_game()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("ball_control"):
		ball.debuge_mode = !ball.debuge_mode
		paddle_one.active = !ball.debuge_mode
		if !ball.debuge_mode:
			ball.move_dir = Vector2(-1, 0)

func reset_game():
	score = Vector2i.ZERO
	ui.reset_score()
	reset_round()

func reset_round():
	var reset_pos = game_area_size / 2.0
	ball.reset(reset_pos)
	start_delay.start()
	await start_delay.timeout
	ball.active = true 

func on_detrctor_ball_out(is_left):
	if is_left:
		score.y += 1 #right score
	else:
		score.x += 1 #left score
		
	ui.set_new_score(score)
	if score.x >= final_score || score.y >= final_score:
		reset_game()
	else:
		reset_round()
