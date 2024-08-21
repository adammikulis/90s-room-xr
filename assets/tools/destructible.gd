class_name Destructible
extends XRToolsPickable

@export var max_health: float = 100.0
var current_health: float = max_health


@export var groups_that_harm: Array[String] = []

@export var destruction_objects: Array[PackedScene] = []

func _ready():
	super()
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	for group in groups_that_harm:
		if body.is_in_group(group):
			apply_damage(0.5 * body.mass * body.linear_velocity.length_squared())
			break

func apply_damage(damage: float) -> void:
	current_health -= damage
	if current_health <= 0:
		destroy()

func destroy():
	for obj in destruction_objects:
		var instance = obj.instantiate()
		instance.global_transform = global_transform
		get_parent().add_child(instance)
	
	queue_free()
