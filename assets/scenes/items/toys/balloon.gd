extends XRToolsPickable

@export var _health: float = 100.0
@export var _pop_threshold: float = 10.0
@export var _damage_multiplier: float = 5.0

@onready var audio_stream_player : AudioStreamPlayer3D = get_node("%AudioStreamPlayer3D")

func _ready():
	initialize_signals()

func initialize_signals():
	body_entered.connect(on_body_entered)

func on_body_entered(body: Node):
	if body.is_in_group("ammo"):
		pop_balloon()

func _physics_process(delta: float):
	if _health <= 0:
		pop_balloon()

func apply_damage(force: float):
	var damage = convert_force_to_damage(force)
	_health -= damage
	print("Collision force: %f, Damage: %f, Remaining health: %f" % [force, damage, _health])
	if force >= _pop_threshold:
		pop_balloon()
	else:
		# Optionally, you could add some visual feedback here
		# like slightly deflating the balloon or changing its color
		pass

func convert_force_to_damage(force: float) -> float:
	return force * _damage_multiplier

func pop_balloon():
	audio_stream_player.play()
	print("Balloon popped!")
	queue_free()  # Remove the balloon from the scene


func _on_audio_stream_player_3d_finished():
	queue_free()
