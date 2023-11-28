class_name NewPaletteDialog
extends BaseDialog

# -------------------------------------------------------------------------------------------------
signal new_palette_created(palette)

# -------------------------------------------------------------------------------------------------
@onready var _line_edit: LineEdit = $Container/LineEdit

var duplicate_current_palette := false
			
# -------------------------------------------------------------------------------------------------
func on_close_requested(window: DialogWindow) -> bool:
	_line_edit.clear()
	return true

# -------------------------------------------------------------------------------------------------
func on_open(window: DialogWindow) -> void:
	# Set title
	if duplicate_current_palette:
		get_parent().title = tr("NEW_PALETTE_DIALOG_DUPLICATE_TITLE")
	else:
		get_parent().title = tr("NEW_PALETTE_DIALOG_CREATE_TITLE")
	
	# Grab focus
	await get_tree().process_frame
	_line_edit.grab_focus()

# -------------------------------------------------------------------------------------------------
func _on_save_button_pressed() -> void:
	var palette_name := _line_edit.text
	if !palette_name.is_empty():
		var palette: Palette
		if duplicate_current_palette:
			palette = PaletteManager.duplicate_palette(PaletteManager.get_active_palette(), palette_name)
		else:
			palette = PaletteManager.create_custom_palette(palette_name)
		
		if palette != null:
			PaletteManager.save()
			emit_signal("new_palette_created", palette)
			duplicate_current_palette = false
			close()

# -------------------------------------------------------------------------------------------------
func _on_cancel_button_pressed() -> void:
	close()
