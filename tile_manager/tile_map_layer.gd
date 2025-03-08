extends TileMapLayer

@onready var tile_manager = get_parent()
var tile_set_source_id: int = tile_set.get_source_id(3)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Tile set source id:", tile_set_source_id)
	fill_tilemap()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	

func fill_tilemap() -> void:
	for j in range(tile_manager.map_size.y):
		for i in range(tile_manager.map_size.x):
			set_cell(Vector2i(i, j), tile_set_source_id, Vector2i(0, 0), 1)
			
