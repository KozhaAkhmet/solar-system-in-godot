extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sensitivity = 0.1
var zoom_sensitivity = 1
var scroll_value = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.get_action_strength("ui_mouse_right"):
		global_position += (get_global_mouse_position() - global_position)*delta

#     if Input.is_action("ui_scroll_up"):
#         scroll_value += 1
#         zoom = Vector2(scroll_value,scroll_value)
#         print(scroll_value)
#     elif Input.is_action("ui_scroll_down"):
#         scroll_value -= 1
#         print(scroll_value)
#         zoom = Vector2(scroll_value,scroll_value)

func _input(event):
	if event.is_action("ui_scroll_up"):
		scroll_value -= zoom_sensitivity
		zoom = Vector2(scroll_value,scroll_value)
	elif event.is_action("ui_scroll_down"):
		scroll_value += zoom_sensitivity
		zoom = Vector2(scroll_value,scroll_value)
	if(scroll_value < 0):
		scroll_value = 0.1
		zoom = Vector2(scroll_value,scroll_value)
