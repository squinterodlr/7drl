class_name TileManager extends Node

@export_category("Map properties")
@export var map_size: Vector2i = Vector2i(32, 32)
@export_category("Tileset properties")
@export var tile_size: Vector2i
@export_category("Tile resources")
@export var tile_resources: Dictionary[String, TileResource]
@onready var terrain_layer: TileMapLayer = $TerrainLayer

var tile_array: Array = [] 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_map()
	update_tilemap(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func get_tile(i: int, j: int) -> BaseTile:
	var idx: int = map_size.y * j + i
	return tile_array[idx]

func set_tile(i: int, j: int, tile: BaseTile) -> void:
	var idx: int = map_size.y * j + i
	if idx > tile_array.size():
		push_error("Trying to set a tile in an index larger than the tile array.")
	tile_array.push_back(tile)

func generate_map() -> void:
	
	var margin: Vector2i = Vector2i(2, 2)
	
	for i in range(map_size.x):
		for j in range(map_size.y):
			var tile = BaseTile.new()
			if i < margin.x or i > map_size.x - 1 - margin.x:
				tile.tile_resource = tile_resources["void"]
			elif j < margin.y or j > map_size.y - 1 - margin.y:
				tile.tile_resource = tile_resources["void"]
			elif i == margin.x or i == map_size.x - 1 - margin.x:
				tile.tile_resource = tile_resources["wall"]
			elif j == margin.y or j == map_size.y - 1 - margin.y:
				tile.tile_resource = tile_resources["wall"]
			else:
				tile.tile_resource = tile_resources["floor"]
			tile_array.push_back(tile)
			
func update_tilemap(clear:bool = false) -> void:
	
	if clear:
		terrain_layer.clear()
	for i in range(map_size.x):
		for j in range(map_size.y):
			
			var tile = get_tile(i, j)
			var terrain_set_id: int = tile.get_terrain_set_id()
			if terrain_set_id >= 0:
				terrain_layer.set_cells_terrain_connect([Vector2i(i, j)], terrain_set_id, 0)
			else:
				terrain_layer.set_cell(Vector2i(i, j), tile.get_atlas_id(), tile.get_atlas_coords())
				
