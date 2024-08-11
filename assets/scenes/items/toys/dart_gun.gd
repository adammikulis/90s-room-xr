extends Node

@export var rigid_body_emitter : RigidBodyEmitter

func _ready():
	pass

func _on_dart_gun_picked_up(pickable):
	if rigid_body_emitter:
		rigid_body_emitter.auto_shoot = true
	else:
		push_error("RigidBodyEmitter node not found")


func _on_dart_gun_dropped(pickable):
	if rigid_body_emitter:
		rigid_body_emitter.auto_shoot = false
	else:
		push_error("RigidBodyEmitter node not found")


func _on_dart_gun_grabbed(pickable, by):
	if rigid_body_emitter:
		rigid_body_emitter.auto_shoot = true
	else:
		push_error("RigidBodyEmitter node not found")


func _on_dart_gun_released(pickable, by):
	if rigid_body_emitter:
		rigid_body_emitter.auto_shoot = false
	else:
		push_error("RigidBodyEmitter node not found")


func _on_dart_gun_action_pressed(pickable):
	rigid_body_emitter.emit_rigid_body()
