extends Control

# -------------------------------------------------------------------------------------------------
@export var canvas_color := Color.BLACK

@onready var _canvas = $InfiniteCanvas
@onready var _ui_statusbar = $UIStatusBar
@onready var _ui_titlebar = $UITitlebar
@onready var _ui_toolbar = $UIToolbar

@onready var _file_dialog: FileDialog = $FileDialog

# -------------------------------------------------------------------------------------------------
func _ready():
	RenderingServer.set_default_clear_color(canvas_color)
	_file_dialog.current_dir = Config.DEFAULT_FILE_DIALOG_PATH
	
	# UI Signals
	_ui_toolbar.connect("clear_canvas", _on_clear_canvas)
	_ui_toolbar.connect("open_file", _on_load_file)
	_ui_toolbar.connect("save_file", _on_save_file)
	_ui_toolbar.connect("brush_color_changed", _on_brush_color_changed)
	_ui_toolbar.connect("brush_size_changed", _on_brush_size_changed)
	_ui_toolbar.connect("grid_enabled", _on_grid_enabled)

# -------------------------------------------------------------------------------------------------
func _physics_process(delta):
	_ui_statusbar.set_stroke_count(_canvas.info.stroke_count)
	_ui_statusbar.set_point_count(_canvas.info.point_count)
	_ui_statusbar.set_pressure(_canvas.info.current_pressure)
	_ui_statusbar.set_brush_position(_canvas.info.current_brush_position)
	_ui_statusbar.set_camera_zoom(_canvas.get_camera_zoom())
	_ui_statusbar.set_fps(Engine.get_frames_per_second())

# -------------------------------------------------------------------------------------------------
func _on_brush_color_changed(color: Color) -> void:
	_canvas.set_brush_color(color)

# -------------------------------------------------------------------------------------------------
func _on_brush_size_changed(size: int) -> void:
	_canvas.set_brush_size(size)

# -------------------------------------------------------------------------------------------------
func _on_grid_enabled(enabled: bool) -> void:
	_canvas.enable_grid(enabled)

# -------------------------------------------------------------------------------------------------
func _on_clear_canvas() -> void:
	_canvas.clear() 

# -------------------------------------------------------------------------------------------------
func _on_load_file(filepath: String) -> void:
	var result: Array = LorienIO.load_file(filepath)
	_canvas.clear()
	_canvas.add_strokes(result, Config.DRAW_DEBUG_POINTS)

# -------------------------------------------------------------------------------------------------
func _on_save_file(filepath: String) -> void:
	LorienIO.save_file(filepath, _canvas._brush_strokes)

# -------------------------------------------------------------------------------------------------
func _on_InfiniteCanvas_mouse_entered():
	_canvas.enable()

# -------------------------------------------------------------------------------------------------
func _on_InfiniteCanvas_mouse_exited():
	_canvas.disable()
