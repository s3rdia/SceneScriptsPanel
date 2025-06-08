@tool
extends EditorPlugin

###################################################################################################
# Variable declaration
###################################################################################################

var panel_instance
var panel_scene = preload("res://addons/scene_scripts_panel/scene_scripts_panel.tscn")

###################################################################################################
# Game loop
###################################################################################################

func _enter_tree():
	panel_instance = panel_scene.instantiate()
	panel_instance.name = "Scripts"
	panel_instance.editor_interface = get_editor_interface()
	
	connect("scene_changed", panel_instance._on_scene_change)
	
	add_control_to_dock(DOCK_SLOT_LEFT_BR, panel_instance)

func _exit_tree():
	remove_control_from_docks(panel_instance)
	panel_instance.queue_free()
