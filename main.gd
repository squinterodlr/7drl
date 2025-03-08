extends Node2D

@onready var tile_manager: TileManager = $TileManager
@onready var terrain_layer: TileMapLayer = $TileManager/TerrainLayer

var actor_list: Array[Actor] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	for actor in actor_list:
		if actor.can_take_turn:
			actor.take_turn()

func actor_can_move_to(actor: Actor, grid_position: Vector2i) -> bool:
	var target_tile: BaseTile = tile_manager.get_tile(grid_position.x, grid_position.y)
	return target_tile.get_is_passable()

func _on_actor_move_requested(actor: Actor, old_grid_position: Vector2i, new_grid_position: Vector2i) -> void:
	if actor_can_move_to(actor, new_grid_position):
		actor.global_position = terrain_layer.to_global(terrain_layer.map_to_local(new_grid_position))
	else:
		actor.grid_position = old_grid_position
		print("Impassable!")
