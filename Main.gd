extends Node3D

@onready var environment : Environment = get_node("%WorldEnvironment").environment

var xr_interface : XRInterface

func _ready():
    xr_interface = XRServer.find_interface("OpenXR")
    if xr_interface and xr_interface.is_initialized():
        print("OpenXR initialized successfully")

        DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

        get_viewport().use_xr = true

        var modes = xr_interface.get_supported_environment_blend_modes()
        if XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND in modes:
            xr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND
        
        get_viewport().transparent_bg = true
        environment.background_mode = Environment.BG_CLEAR_COLOR
        environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
    
    else:
        print("OpenXR not initialized successfully, please check if your headset is connected")