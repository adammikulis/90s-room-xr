extends Marker3D
class_name Emitter

@export var emitted_body: PackedScene
@export var emit_force: float = 1.0
@export var auto_shoot: bool = false
@export var shots_per_second: float = 1.0
enum EmissionBasis {
	X,
	Y,
	Z,
	NEGATIVE_X,
	NEGATIVE_Y,
	NEGATIVE_Z
}
@export var emission_direction: EmissionBasis

var _timer: Timer

func _ready():
	_timer = Timer.new()
	add_child(_timer)
	_timer.timeout.connect(on_timer_timeout)
	
	# Initialize auto_shoot after timer is created
	set_auto_shoot(auto_shoot)

func set_auto_shoot(value: bool):
	auto_shoot = value
	if auto_shoot:
		start_auto_shoot()
	else:
		stop_auto_shoot()

func start_auto_shoot():
	if shots_per_second > 0:
		_timer.start(1.0 / shots_per_second)
	else:
		print("Warning: shots_per_second must be greater than 0")

func stop_auto_shoot():
	_timer.stop()

func on_timer_timeout():
	emit_rigid_body()

func emit_rigid_body():
	# Instance body
	var body = emitted_body.instantiate() as RigidBody3D
	body.global_transform = global_transform
	get_tree().root.add_child(body)
	# Apply force
	var force_direction = get_force_direction()
	body.apply_impulse(force_direction * emit_force)

func get_force_direction() -> Vector3:
	match emission_direction:
		EmissionBasis.X:
			return global_transform.basis.x
		EmissionBasis.Y:
			return global_transform.basis.y
		EmissionBasis.Z:
			return global_transform.basis.z
		EmissionBasis.NEGATIVE_X:
			return -global_transform.basis.x
		EmissionBasis.NEGATIVE_Y:
			return -global_transform.basis.y
		EmissionBasis.NEGATIVE_Z:
			return -global_transform.basis.z
		_:
			return global_transform.basis.z # Default to Z

func _set(property, value):
	if property == "auto_shoot":
		set_auto_shoot(value)
		return true
	return false
