@tool
extends ItemList

###################################################################################################
# Variable declaration
###################################################################################################

var editor_interface:EditorInterface

###################################################################################################
# Game loop
###################################################################################################

func _ready():
	item_selected.connect(_on_item_activated)
	_on_scene_change(self)

###################################################################################################
# Functions
###################################################################################################

func find_scripts_in_node(node:Node, scripts:Array):
	var script = node.get_script()
	
	if script and script.resource_path:
		scripts.append(script)
	
	for child in node.get_children():
		find_scripts_in_node(child, scripts)


func add_unique_item(script:String):
	for i in get_item_count():
		if get_item_text(i) == script:
			return
			
	add_item(script)
	
###################################################################################################
# Signals
###################################################################################################

func _on_scene_change(scene:Node):
	clear()
	
	var scene_root = get_tree().edited_scene_root
	if not scene_root:
		return
	
	var scripts = []
	find_scripts_in_node(scene_root, scripts)
	
	for script in scripts:
		if script and script.resource_path:
			add_unique_item(script.resource_path.get_file())
			set_item_metadata(item_count - 1, script.resource_path)
			

func _on_item_activated(index:int):
	var script_path = get_item_metadata(index)
	
	if script_path:
		var script = load(script_path)
		EditorInterface.edit_script(script)
