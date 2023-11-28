class_name AboutDialog
extends BaseDialog

# -------------------------------------------------------------------------------------------------
@onready var _version_label: Label = $VBoxContainer/HBoxContainer/MarginContainer/VBoxContainer/VersionLabel

# -------------------------------------------------------------------------------------------------
func _ready():
	_version_label.text = "Lorien v%s" % Config.VERSION_STRING
	size.y = size.y + 5

# -------------------------------------------------------------------------------------------------
func on_close_requested(window: DialogWindow) -> bool:
	return true

# -------------------------------------------------------------------------------------------------
func _on_GithubLinkButton_pressed():
	OS.shell_open("https://github.com/mbrlabs/Lorien")

# -------------------------------------------------------------------------------------------------
func _on_LicenseButton_pressed():
	OS.shell_open("https://github.com/mbrlabs/Lorien/blob/main/LICENSE")

# -------------------------------------------------------------------------------------------------
func _on_GodotButton_pressed():
	OS.shell_open("https://godotengine.org/")

# -------------------------------------------------------------------------------------------------
func _on_RemixIconsButton_pressed():
	OS.shell_open("https://remixicon.com/")

# -------------------------------------------------------------------------------------------------
func _on_KennyButton_pressed():
	OS.shell_open("https://www.kenney.nl/assets/platformer-art-deluxe")
