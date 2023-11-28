class_name UnsavedChangesDialog
extends BaseDialog

# -------------------------------------------------------------------------------------------------
signal cancel
signal save_changes(project_ids)
signal discard_changes(project_ids)

# -------------------------------------------------------------------------------------------------
var project_ids: Array

# -------------------------------------------------------------------------------------------------
func _ready() -> void:
	%SaveButton.pressed.connect(_on_save)
	%DiscardButton.pressed.connect(_on_discard)
	%CancelButton.pressed.connect(_on_cancel)

# -------------------------------------------------------------------------------------------------
func on_close_requested(window: DialogWindow) -> bool:
	_on_cancel()
	return true

# -------------------------------------------------------------------------------------------------
func set_text(text: String) -> void:
	$Label.text = text

# -------------------------------------------------------------------------------------------------
func _on_cancel(): 
	close()
	emit_signal("cancel")

# -------------------------------------------------------------------------------------------------
func _on_save(): 
	close()
	emit_signal("save_changes", project_ids)

# -------------------------------------------------------------------------------------------------	
func _on_discard(): 
	close()
	emit_signal("discard_changes", project_ids)
