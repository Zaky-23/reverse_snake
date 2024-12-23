extends ProgressBar

@onready var damage_bar: ProgressBar = $DamageBar
@onready var timer: Timer = $Timer

var health: int:
	get:
		return health

func _ready():
	pass
	
func init_health(initial_value: int, max_value: int):
	health = initial_value
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func set_health(new_health: int):
	var old_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0:
		queue_free()
	
	if health < old_health:
		timer.start()
	else:
		damage_bar.value = health


func _on_timer_timeout():
	damage_bar.value = health
