extends Camera2D

var dragging: bool = false
@export_category("Drag")
@export var drag_threshold: float = 0
var drag_speed_multiplier: float = 1.0 / zoom.x
@export_category("Zoom")
@export var zoom_max: float = 2.0
@export var zoom_min: float = 0.25
@export var scroll_zoom_factor: float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	drag_speed_multiplier = 1.0/zoom.x

func _input(event):
	if event is InputEventMouseButton:
		
		match event.button_index:
			MOUSE_BUTTON_MIDDLE:
				if not dragging and event.pressed:
					dragging = true
				
				if dragging and not event.pressed:
					dragging = false
			MOUSE_BUTTON_WHEEL_DOWN:
				var next_zoom = clamp(zoom.x - scroll_zoom_factor, zoom_min, zoom_max)
				zoom = Vector2(next_zoom, next_zoom)
			MOUSE_BUTTON_WHEEL_UP:
				var next_zoom = clamp(zoom.x + scroll_zoom_factor, zoom_min, zoom_max)
				zoom = Vector2(next_zoom, next_zoom)
			
	if event is InputEventMouseMotion and dragging:
		var drag_distance: Vector2i = event.relative
		if drag_distance.length() >= drag_threshold:
			position -= drag_speed_multiplier * drag_distance
	
