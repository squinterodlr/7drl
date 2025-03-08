class_name BaseTile

@export var tile_resource: Resource
var actor_here: Actor = null

'''
@export var tileset: TileSet = null
var tile_size: Vector2i
@export var tileset_atlas_id: int = -1
@export var tileatlas_coords: Vector2i = Vector2i(-1,-1)
@export var terrain_set: int = -1
'''

func get_is_passable() -> bool:
	return tile_resource.is_passable
func get_tileset() -> TileSet:
	return tile_resource.tileset
func get_atlas_id() -> int:
	return tile_resource.tileset_atlas_id
func get_atlas_coords() -> Vector2i:
	return tile_resource.tileatlas_coords
func get_terrain_set_id() -> int:
	return tile_resource.terrain_set
