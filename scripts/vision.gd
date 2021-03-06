extends Light2D

onready var raycast = get_node('RayCast2D')
onready var global = get_node("/root/global")

var can_spot = false
var spotted = false

signal GUI_change

func _ready():
    pass

func _process(delta):
    if can_spot and not spotted:
        if raycast.is_colliding():
            if raycast.get_collider().name == 'Player':
                spotted = true
                global.spotted_player()
                color = Color(1.0,0,0,1)
                get_parent().alert = true
    
    
func _on_vision_range_area_entered( area ):
    if area.name == 'Player':
        can_spot = true
        get_parent().alert_timer.stop()
        get_parent().alert_timer.wait_time = 3
        emit_signal('GUI_change')

func _on_vision_range_area_exited( area ):
    if area.name == 'Player':
        can_spot = false
        spotted = false
        color = Color(0.2,0.8,1,1)
        get_parent().alert_timer.start()
