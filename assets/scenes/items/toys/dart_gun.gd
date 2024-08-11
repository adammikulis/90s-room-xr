extends XRToolsPickable

@export var emitter : Emitter

func _ready():
	pass

func _on_dart_gun_picked_up(pickable):
	if emitter:
		emitter.auto_shoot = true
	else:
		push_error("Emitter node not found")


func _on_dart_gun_dropped(pickable):
	if emitter:
		emitter.auto_shoot = false
	else:
		push_error("RigidBodyEmitter node not found")


func _on_dart_gun_grabbed(pickable, by):
	if emitter:
		emitter.auto_shoot = true
	else:
		push_error("RigidBodyEmitter node not found")


func _on_dart_gun_released(pickable, by):
	if emitter:
		emitter.auto_shoot = false
	else:
		push_error("RigidBodyEmitter node not found")


func _on_dart_gun_action_pressed(pickable):
	emitter.emit_rigid_body()
