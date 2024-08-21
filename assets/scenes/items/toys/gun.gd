class_name Gun
extends Emitter

enum ShootTypes {
	Automatic, 
	SemiAutomatic}

@export var shoot_type: ShootTypes

func _ready():
	super()
	action_pressed.connect(_on_action_pressed)
	action_released.connect(_on_action_released)
	dropped.connect(_on_dropped)
	released.connect(_on_released)

func _on_action_pressed(pickable):
	if shoot_type == ShootTypes.Automatic:
		set_auto_shoot(true)
	else:
		emit_body()

func _on_action_released(pickable):
	set_auto_shoot(false)

func _on_dropped(pickable):
	set_auto_shoot(false)

func _on_released(pickable):
	set_auto_shoot(false)
