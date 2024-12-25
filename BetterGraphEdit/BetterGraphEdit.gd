@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("GraphEditPlus", "GraphEdit", preload("GraphEditPlus.gd"), preload("textures/icon_graph_edit_plus.png"))
	
func _exit_tree() -> void:
	remove_custom_type("GraphEditPlus")
