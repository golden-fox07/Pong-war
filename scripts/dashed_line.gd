extends Node2D

@export var line_color: Color = Color.WHITE
@export var line_width: float = 8.0
@export var dash_length: float = 20.0
@export var dash_spacing: float = 15.0

func _draw():
	var start = Vector2(size().x / 2, 0)
	var end = Vector2(size().x / 2, size().y)
	draw_dashed_line(start, end, line_color, line_width, dash_length, false)

func size() -> Vector2:
	return get_viewport_rect().size
