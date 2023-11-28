class_name DialogWindow
extends Window

# -------------------------------------------------------------------------------------------------
func _ready() -> void:
	assert(get_child_count() == 1)
	disable_3d = true
	visible = false
	wrap_controls = true
	exclusive = true
	transient = true
	
	var dialog := get_child(0) as BaseDialog
	size = dialog.get_minimum_size()
	initial_position = Window.WINDOW_INITIAL_POSITION_CENTER_SCREEN_WITH_MOUSE_FOCUS

	close_requested.connect(func() -> void:
		if dialog.on_close_requested(self):
			hide()
	)
	
	about_to_popup.connect(func() -> void:
		dialog.on_open(self)
	)
