extends XRToolsPickable

@onready var contact_area = get_node("%Area3D")
@onready var particles = get_node("%CPUParticles3D")
@onready var can_mesh = get_node("%CanMesh3D")


@export var selected_can_color: CanColors = CanColors.Coke
@export var n_liquid_ounces : float = 12
@export var liquid_density : float = 1.03
@export var carbonation_factor : float = 1

var is_open : bool = false
var blast_force : float = 10.0
var liquid_decrease_rate : float = 0.1
var shake_increase_rate : float = 0.1


enum CanColors {Coke, Pepsi, Surge}
var can_color_dict = {
	CanColors.Coke: Color("#FE001A"),
	CanColors.Pepsi: Color("#0E0E96"),
	CanColors.Surge: Color("#B2D234")
}


func _ready() -> void:
	update_mass()
	apply_can_color()

func _process(delta: float) -> void:
	if is_open and carbonation_factor > 0:
		blast_soda(delta)

func apply_can_color():
	var material = can_mesh.mesh.surface_get_material(1)
	material = material.duplicate()
	can_mesh.set_surface_override_material(1, material)
	material.albedo_color = can_color_dict[selected_can_color]

func open_can() -> void:
	if not is_open:
		is_open = true
		particles.emitting = true

func shake_can() -> void:
	carbonation_factor += shake_increase_rate
	carbonation_factor = min(carbonation_factor, 5.0)  # Cap at 5x normal carbonation

func blast_soda(delta: float) -> void:
	var blast_strength = carbonation_factor * blast_force
	var blast_direction = transform.basis.y
	var blast_position = particles.global_transform.origin
	
	apply_impulse(blast_direction * blast_strength, blast_position)
	
	n_liquid_ounces -= liquid_decrease_rate * carbonation_factor * delta
	n_liquid_ounces = max(n_liquid_ounces, 0)
	
	carbonation_factor -= delta
	carbonation_factor = max(carbonation_factor, 0)
	
	update_mass()
	
	if n_liquid_ounces <= 0 or carbonation_factor <= 0:
		particles.emitting = false

func update_mass() -> void:
	var mass_in_kg = n_liquid_ounces * 0.0295735 * liquid_density  # Convert ounces to kg
	mass = mass_in_kg
