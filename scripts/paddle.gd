extends Area2D

@export var is_player_one = false

@onready var cshape = $CollisionShape2D

var active = true
var up_input = "paddle_up"
var down_input = "paddle_down"

var MAX_VELOCITY = 10.0
var Velocity = 0.0
var Acceleration = 50.0
var slow_down_delta = 2.0

func _ready() -> void:
	if is_player_one == false:
		up_input += "_two"
		down_input += "_two"
	
func _physics_process(delta: float) -> void:
	if !active : return
	
	var move_dir = 0.0
	
	move_dir = Input.get_axis(up_input, down_input)
	
	Velocity += move_dir * Acceleration * delta
	if move_dir == 0.0:
		Velocity = move_toward(Velocity, 0.0, slow_down_delta)
		
	Velocity = clampf(Velocity, -MAX_VELOCITY, MAX_VELOCITY)
	
	
	global_position.y += Velocity
	
	# for the paddles to stay within the frame 
	global_position.y = clampf(global_position.y, 40, 670)


func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		body.bounce_from_paddle(global_position.y, cshape.shape.get_rect().size.y)
