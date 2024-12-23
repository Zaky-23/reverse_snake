extends Node2D

enum Direction {
	UP = 0,
	LEFT = 1,
	DOWN = 2,
	RIGHT = 3,
}

@export var move_speed: int = 50

@onready var area: Area2D = $CharacterBody2D
@onready var sprite: Sprite2D = $Sprite2D

var current_direction: Direction
var movement_vector: Vector2i

func _ready():
	current_direction = Direction.UP
	movement_vector = Vector2i.UP

func _input(event):
	if event.is_action_pressed("ui_up") and current_direction != Direction.DOWN:
		movement_vector = Vector2i.UP
		current_direction = Direction.UP
	if event.is_action_pressed("ui_left") and current_direction != Direction.RIGHT:
		movement_vector = Vector2i.LEFT
		current_direction = Direction.LEFT
	if event.is_action_pressed("ui_down") and current_direction != Direction.UP:
		movement_vector = Vector2i.DOWN
		current_direction = Direction.DOWN
	if event.is_action_pressed("ui_right") and current_direction != Direction.LEFT:
		movement_vector = Vector2i.RIGHT
		current_direction = Direction.RIGHT

func _process(delta):
	match current_direction:
		Direction.UP:
			sprite.frame = 0
		Direction.LEFT:
			sprite.frame = 1
		Direction.DOWN:
			sprite.frame = 2
		Direction.RIGHT:
			sprite.frame = 3

func _physics_process(delta):
	translate(movement_vector * move_speed * delta)
