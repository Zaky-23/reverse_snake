extends Area2D

@export var lifespan: float = 3.0

@onready var timer: Timer = $Timer

func _ready():
	timer.start(lifespan)

func _on_timer_timeout():
	queue_free()
