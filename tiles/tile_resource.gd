class_name TileResource extends Resource

@export_category("Properties")
@export var name: String = ""
@export var is_passable: bool = true
@export_category("Tileset")
@export var tileset: TileSet = null
var tile_size: Vector2i
@export var tileset_atlas_id: int = -1
@export var tileatlas_coords: Vector2i = Vector2i(-1,-1)
@export var terrain_set: int = -1
