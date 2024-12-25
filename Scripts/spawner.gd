extends Node2D

@export var max_food_at_moment: int = 5
@export var food_spawn_timer: float = 2.0
@export var tile_size: int = 8
@export var food: Array[PackedScene]

@onready var top_left: Marker2D = $TopLeft
@onready var top_right: Marker2D = $TopRight
@onready var bottom_left: Marker2D = $BottomLeft
@onready var bottom_right: Marker2D = $BottomRight
@onready var timer: Timer = $Timer
@onready var children: Node = $Children
@onready var overdrive_timer: Timer = $OverdriveTimer

var width: float
var height: float
var can_spawn: bool
var overdrive: bool

func _ready():
	width = top_right.position.x - top_left.position.x
	height = bottom_right.position.y - top_right.position.y 
	can_spawn = true
	overdrive = false
	overdrive_timer.wait_time = 1.0
	overdrive_timer.one_shot = true
	timer.start(food_spawn_timer)

func _process(delta):
	can_spawn = children.get_child_count() < max_food_at_moment
	if overdrive:
		spawn_food_overdrive()

func _on_timer_timeout():
		spawn_food()

func spawn_food():
	if not can_spawn:
		return
	var x = randf_range(top_left.position.x, top_right.position.x)
	var y = randf_range(top_left.position.y, bottom_left.position.y)
	var new_food = food.pick_random().instantiate()
	children.add_child(new_food)
	new_food.position = Vector2(x, y).snappedf(tile_size)

func spawn_food_overdrive():
	var x = randf_range(top_left.position.x, top_right.position.x)
	var y = randf_range(top_left.position.y, bottom_left.position.y)
	var new_food = food.pick_random().instantiate()
	children.add_child(new_food)
	new_food.position = Vector2(x, y).snappedf(tile_size)


func _on_overdrive_timer_timeout():
	overdrive = false
