extends Area2D

@export var lifespan: float = 3.0

@onready var lifespan_timer: Timer = $LifeSpan
@onready var buffer_timer: Timer = $Buffer

func _ready():
	lifespan_timer.wait_time = lifespan
	$Sprite2D.hide()
	$WarningSprite.show()
	monitorable = false
	buffer_timer.start()

func _on_buffer_timeout():
	$Sprite2D.show()
	$WarningSprite.hide()
	monitorable = true
	lifespan_timer.start()


func _on_lifespan_timeout():
	queue_free()
