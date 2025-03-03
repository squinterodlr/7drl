extends Node2D

@export var grid_position: Vector2i = Vector2i(0, 0)
@export var tile_map: TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	# move to position
	position = tile_map.to_global(tile_map.map_to_local(grid_position))
