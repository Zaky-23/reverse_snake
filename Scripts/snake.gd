extends Node2D

enum Direction {
	UP = 0,
	LEFT = 1,
	DOWN = 2,
	RIGHT = 3,
}

@export var move_speed: int = 50
@export var tile_size: int = 1
@export var move_cooldown: float = 0.3
@export var segment: PackedScene
@export var health: int = 10

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar: ProgressBar = $HealthBar

@onready var screen_rect = get_viewport_rect().size

var current_direction: Direction
var movement_vector: Vector2
var time_since_move = 0

func _ready():
	current_direction = Direction.UP
	movement_vector = Vector2i.UP
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	health_bar.init_health(10, 10)

func _input(event):
	if event.is_action_pressed("ui_up") and current_direction != Direction.DOWN:
		movement_vector = Vector2.UP
		current_direction = Direction.UP
	if event.is_action_pressed("ui_left") and current_direction != Direction.RIGHT:
		movement_vector = Vector2.LEFT
		current_direction = Direction.LEFT
	if event.is_action_pressed("ui_down") and current_direction != Direction.UP:
		movement_vector = Vector2.DOWN
		current_direction = Direction.DOWN
	if event.is_action_pressed("ui_right") and current_direction != Direction.LEFT:
		movement_vector = Vector2.RIGHT
		current_direction = Direction.RIGHT
	if event.is_action_pressed("ui_accept"):
		pass

func screen_wrap():
	if position.x > screen_rect.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_rect.x
	if position.y > screen_rect.y:
		position.y = 0
	if position.y < 0:
		position.y = screen_rect.y

func _process(delta):
	screen_wrap()
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
	if time_since_move > move_cooldown:
		position += movement_vector * tile_size * move_speed
		position = position.snappedf(tile_size)
		time_since_move = 0
	else:
		time_since_move += delta


func _on_body_area_entered(area):
	if area.is_in_group("food"):
		area.queue_free()
		health -= 1
		health_bar.set_health(health)
		if health <= 0:
			queue_free()
			return
	
	if area.is_in_group("fast_food"):
		move_speed *= 1.25
	
	if area.is_in_group("weird_food"):
		pass
