@icon("res://addons/grapheditplus/textures/icon_graph_edit_plus.png")
@tool
extends GraphEdit ##GraphEdit node with better API.
class_name GraphEditPlus

var connections: Array[Dictionary]: ##Returns connections as GraphNodes and ports
	get: 
		var ret: Array[Dictionary] = [] 
		for n in get_connection_list():
			ret.append({
			"from_node": as_node(n["from_node"]),
			"from_port": n["from_port"],
			"to_node": as_node(n["to_node"]),
			"to_port": n["to_port"]
			})
		return ret
	set(value): pass

# Add/Remove Functions #
func add_node(node_scene: PackedScene, pos: Vector2 = Vector2.ZERO): ##Creates a GraphNode on the given position and returns it.
	var new_node = node_scene.instantiate()
	add_child(new_node)
	new_node.position_offset = pos
	return new_node
func remove_node(graph_node: GraphNode): ##Removes given GraphNode.
	var node_connections = get_connections_of(graph_node)
	remove_connections(node_connections)
	remove_child(graph_node)
	graph_node.queue_free()
func duplicate_nodes(nodes: Array[GraphNode]): ##Duplicates given GraphNodes.
	var duplicated_nodes: Array[GraphNode] = []
	for n in nodes:
		var n_node: GraphNode = n.duplicate()
		add_child(n_node)
		duplicated_nodes.append(n_node)
	var index_relative_connections = as_index_relative(nodes)
	make_index_relative_connections(duplicated_nodes, index_relative_connections)
	
	return duplicated_nodes

# Connection functions #
func add_connection(from_node: GraphNode, from_port: int, to_node: GraphNode, to_port: int): ##Connects two nodes.
	connect_node(from_node.name, from_port, to_node.name, to_port)
func remove_connection(from_node: GraphNode, from_port: int, to_node: GraphNode, to_port: int): ##Disconnects two nodes.
	disconnect_node(from_node.name, from_port, to_node.name, to_port)
func add_connections(connection_array: Array[Dictionary]): ##Connects multiple nodes.
	for n in connection_array:
		add_connection(n["from_node"], n["from_port"], n["to_node"], n["to_port"])
func remove_connections(connection_array: Array[Dictionary]): ##Disconnects multiple nodes.
	for n in connection_array:
		remove_connection(n["from_node"], n["from_port"], n["to_node"], n["to_port"])
func make_index_relative_connections(nodes: Array[GraphNode], connections: Array[Dictionary]): ##Makes index-relative connections with given GraphNodes and connections
	for n in connections:
		add_connection(nodes[n["from_index"]], n["from_port"], nodes[n["to_index"]], n["to_port"])

# Transform functions #
func move_nodes(nodes: Array[GraphNode], value: Vector2): ##Moves GraphNodes to the given value.
	for n in nodes:
		n.position_offset = value
func move_nodes_by(nodes: Array[GraphNode], by: Vector2): ##Moves GraphNodes by the given value.
	for n in nodes:
		n.position_offset = n.position_offset + by
func scale_nodes(nodes: Array[GraphNode], value: Vector2): ##Scales GraphNodes to the given value.
	for n in nodes:
		n.set_size(value, false)
func scale_nodes_by(nodes: Array[GraphNode], by: Vector2): ##Scales GraphNodes by the given value.
	for n in nodes:
		n.set_size(n.size + by, false)

# Select functions #
func select_node(node: GraphNode): ##Selects given node.
	node.selected = true
func select_nodes(nodes: Array[GraphNode]): ##Selects given nodes.
	for n in nodes:
		n.selected = true
func select_all_nodes(): ##Selects all nodes.
	for n in get_all_nodes():
		n.selected = true

func deselect_node(node: GraphNode): ##Selects given node.
	node.selected = false
func deselect_nodes(nodes: Array[GraphNode]): ##Selects given nodes.
	for n in nodes:
		n.selected = false
func deselect_all_nodes(): ##Selects all nodes.
	for n in get_all_nodes():
		n.selected = false

# Get functions #
func get_all_nodes() -> Array[GraphNode]: ##Returns all GraphNodes in it.
	var r_array: Array[GraphNode] = []
	for n in get_children():
		if n is GraphNode: r_array.append(n)
	return r_array

func get_connections_of(node: GraphNode) -> Array[Dictionary]: ##Returns all connections of specified GraphNode.
	var node_connections: Array[Dictionary] = []
	for n in connections:
		if n["from_node"] == node or n["to_node"] == node:
			node_connections.append(n)
	return node_connections
func get_outputs_of(node: GraphNode) -> Array[Dictionary]: ##Returns all output connections of specified GraphNode.
	var node_connections: Array[Dictionary] = []
	for n in connections:
		if n["from_node"] == node:
			node_connections.append(n)
	return node_connections
func get_inputs_of(node: GraphNode) -> Array[Dictionary]: ##Returns all input connections of specified GraphNode.
	var node_connections: Array[Dictionary] = []
	for n in connections:
		if n["to_node"] == node:
			node_connections.append(n)
	return node_connections

func get_port_connections(node: GraphNode, port: int) -> Array[Dictionary]: ##Returns all connections of specified GraphNode port.
	var port_connections: Array[Dictionary] = []
	for n in connections:
		if n["from_node"] == node and n["from_port"] == port or n["to_node"] == node and n["to_port"] == port:
			port_connections.append(n)
	return port_connections
			
func get_connections_between(nodeA: GraphNode, nodeB: GraphNode) -> Array[Dictionary]: ##Returns all connections of between two GraphNodes.
	var between_connections: Array[Dictionary] = []
	for n in connections:
		if n["from_node"] == nodeA and n["to_node"] == nodeB or n["from_node"] == nodeB and n["to_node"] == nodeA :
			between_connections.append(n)
	return between_connections
func get_connections_between_all(nodes: Array[GraphNode]) -> Array[Dictionary]: ##Returns all connections of between multiple GraphNodes.
	var between_connections: Array[Dictionary] = []
	for n in connections:
		if nodes.has(n["from_node"]) and nodes.has(n["to_node"]):
			between_connections.append(n)
	return between_connections
func get_connections_to(nodeA: GraphNode, nodeB: GraphNode) -> Array[Dictionary]: ##Returns all connections from nodeA to nodeB.
	var between_connections: Array[Dictionary] = []
	for n in connections:
		if n["from_node"] == nodeA and n["to_node"] == nodeB:
			between_connections.append(n)
	return between_connections
func get_connections_from(nodeA: GraphNode, nodeB: GraphNode) -> Array[Dictionary]: ##Returns all connections to nodeA from nodeB.
	var between_connections: Array[Dictionary] = []
	for n in connections:
		if n["from_node"] == nodeB and n["to_node"] == nodeA:
			between_connections.append(n)
	return between_connections

# Convert functions #
func as_node(node_name: StringName) -> GraphNode: ##Returns StringName as GraphNode
	return get_node(NodePath(node_name))
func as_index_relative(nodes: Array[GraphNode]) -> Array[Dictionary]: ##Returns name-based connections between given nodes as index-related connections.
	var index_relative_connections: Array[Dictionary] = []
	for n in get_connections_between_all(nodes):
		index_relative_connections.append({
			"from_index": nodes.find(n["from_node"]),
			"from_port": n["from_port"],
			"to_index": nodes.find(n["to_node"]),
			"to_port": n["to_port"]
			})
	return index_relative_connections
