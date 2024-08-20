extends XRToolsPickable

@export var despawn_time : float = 5.0
var _timer: Timer

func _ready():
    if despawn_time != -1:
        _timer = Timer.new()
        _timer.wait_time = despawn_time
        add_child(_timer)
        _timer.timeout.connect(_on_timer_timeout)
        _timer.start()

func _on_timer_timeout():
    queue_free()