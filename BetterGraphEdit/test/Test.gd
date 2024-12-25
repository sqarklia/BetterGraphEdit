extends GraphEditPlus

@export var duplicateOffset: Vector2 = Vector2(10, 10)
var selected_nodes: Array[GraphNode] = []

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_text_select_all"):
		select_all_nodes()

func _on_delete_nodes_request(nodes: Array[StringName]) -> void:
	for n in nodes:
		var node := as_node(n)
		if selected_nodes.has(node):
			selected_nodes.erase(node)
		remove_node(node)
func _on_duplicate_nodes_request() -> void:
	var duplicated_nodes = duplicate_nodes(selected_nodes)
	deselect_all_nodes()
	select_nodes(duplicated_nodes)
	move_nodes_by(duplicated_nodes, duplicateOffset)

func _on_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	remove_connection(as_node(from_node), from_port, as_node(to_node), to_port)
func _on_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	add_connection(as_node(from_node), from_port, as_node(to_node), to_port)

func _on_node_selected(node: Node) -> void:
	if node is GraphNode:
		selected_nodes.append(node)
func _on_node_deselected(node: Node) -> void:
	if node is GraphNode:
		selected_nodes.erase(node)
