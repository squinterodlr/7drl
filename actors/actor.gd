class_name Actor extends Node2D

@export_category("World properties")
@export var grid_position: Vector2i = Vector2i(0, 0)
@export var tile_map: TileMapLayer

@export_category("Actor attributes")
@export var health: int = 10
@export var armor: int = 0
@export var melee: int = 1
@export var speed: int = 2


@onready var direction_sprite: AnimatedSprite2D = $DirectionSprite
@onready var sprite: Sprite2D = $ActorSprite
@export var sprite_facing_right = false

var can_take_turn: bool = true
enum Heading {EAST, NORTHEAST, NORTH, NORTHWEST, WEST, SOUTHWEST, SOUTH, SOUTHEAST}
var heading = Heading.EAST

signal move_requested(actor: Actor, old_grid_position: Vector2i, new_grid_position: Vector2i)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	update_rotation()

func update_rotation() -> void:
	# rotate direction_sprites
	match heading:
		Heading.EAST: #DR
			direction_sprite.animation = "right"
			direction_sprite.flip_h = false
			direction_sprite.flip_v = false
			sprite.flip_h = not sprite_facing_right
		Heading.NORTHEAST: #R
			direction_sprite.animation = "up_right"
			direction_sprite.flip_h = false
			direction_sprite.flip_v = false
			sprite.flip_h = not sprite_facing_right
		Heading.NORTH: #UR
			direction_sprite.animation = "up"
			direction_sprite.flip_h = false
			direction_sprite.flip_v = false
		Heading.NORTHWEST: #U
			direction_sprite.animation = "up_right"
			direction_sprite.flip_h = true
			direction_sprite.flip_v = false
			sprite.flip_h = sprite_facing_right
		Heading.WEST: #UL
			direction_sprite.animation = "right"
			direction_sprite.flip_h = true
			direction_sprite.flip_v = false
			sprite.flip_h = sprite_facing_right
		Heading.SOUTHWEST: #L
			direction_sprite.animation = "up_right"
			direction_sprite.flip_h = true
			direction_sprite.flip_v = true
			sprite.flip_h = sprite_facing_right
		Heading.SOUTH: #DL
			direction_sprite.animation = "up"
			direction_sprite.flip_h = false
			direction_sprite.flip_v = true
		Heading.SOUTHEAST: #D
			direction_sprite.animation = "up_right"
			direction_sprite.flip_h = false
			direction_sprite.flip_v = true
			sprite.flip_h = not sprite_facing_right

func move(backward: bool=false) -> void:
	
	var flip = 1
	if backward:
		flip = -1
	var old_grid_position = grid_position
	match heading:
		Heading.EAST:
			grid_position += flip * Vector2i(1, 0)
		Heading.NORTHEAST:
			grid_position += flip * Vector2i(1, -1)
		Heading.NORTH:
			grid_position += flip * Vector2i(0, -1)
		Heading.NORTHWEST:
			grid_position += flip * Vector2i(-1, -1)
		Heading.WEST:
			grid_position += flip * Vector2i(-1, 0)
		Heading.SOUTHWEST:
			grid_position += flip * Vector2i(-1, 1)
		Heading.SOUTH:
			grid_position += flip * Vector2i(0, 1)
		Heading.SOUTHEAST:
			grid_position += flip * Vector2i(1, 1)
	
	move_requested.emit(self, old_grid_position, grid_position)

	
