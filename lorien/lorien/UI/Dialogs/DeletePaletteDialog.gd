class_name DeletePaletteDialog
extends BaseDialog

# -------------------------------------------------------------------------------------------------
signal palette_deleted

# -------------------------------------------------------------------------------------------------
@onready var _text: Label = $Container/Label

# -------------------------------------------------------------------------------------------------
func on_open(window: DialogWindow) -> void:
	var palette := PaletteManager.get_active_palette()
	_text.text = tr("DELETE_PALETTE_DIALOG_TEXT") + " " + palette.name

# -------------------------------------------------------------------------------------------------
func _on_cancel_button_pressed() -> void:
	close()

# -------------------------------------------------------------------------------------------------
func _on_delete_button_pressed() -> void:
	var palette := PaletteManager.get_active_palette()
	if !palette.builtin:
		PaletteManager.remove_palette(palette)
		PaletteManager.save()
		close()
		emit_signal("palette_deleted")
