# BetterGraphEdit
This tool improves GraphEdit API for Godot Engine and makes it easier to use.

---------YOU CAN USE THIS AS A DOCUMENTATION---------



connections: Array[Dictionary] *Returns connections as GraphNodes and ports*

add_node(node_scene: PackedScene, pos: Vector2 = Vector2.ZERO)  *Creates a GraphNode on the given position and returns it.*
remove_node(graph_node: GraphNode): *Removes given GraphNode*
duplicate_nodes(nodes: Array[GraphNode]) *Duplicates given GraphNodes*

add_connection(from_node: GraphNode, from_port: int, to_node: GraphNode, to_port: int) *Connects two nodes.*
remove_connection(from_node: GraphNode, from_port: int, to_node: GraphNode, to_port: int) *Disconnects two nodes.*
add_connections(connection_array: Array[Dictionary]) *Connects multiple nodes*
remove_connections(connection_array: Array[Dictionary]) *Disconnects multiple nodes.*
make_index_relative_connections(nodes: Array[GraphNode], connections: Array[Dictionary]) *Makes index-relative connections with given GraphNodes and connections*

move_nodes(nodes: Array[GraphNode], value: Vector2) *Moves GraphNodes to the given value.*
move_nodes_by(nodes: Array[GraphNode], by: Vector2) *Moves GraphNodes by the given value.*
scale_nodes(nodes: Array[GraphNode], value: Vector2) *Scales GraphNodes to the given value.*
scale_nodes_by(nodes: Array[GraphNode], by: Vector2) *Scales GraphNodes by the given value.*

select_node(node: GraphNode) *Selects given node.*
select_nodes(nodes: Array[GraphNode]) *Selects given nodes.*
select_all_nodes() *Selects all nodes.*
deselect_node(node: GraphNode) *Selects given node.*
deselect_nodes(nodes: Array[GraphNode]) *Selects given nodes.*
deselect_all_nodes() *Selects all nodes.*

get_all_nodes() -> Array[GraphNode] *Returns all GraphNodes in it.*
get_connections_of(node: GraphNode) -> Array[Dictionary] *Returns all connections of specified GraphNode.*
get_outputs_of(node: GraphNode) -> Array[Dictionary] *Returns all output connections of specified GraphNode.*
get_inputs_of(node: GraphNode) -> Array[Dictionary] *Returns all input connections of specified GraphNode.*
get_port_connections(node: GraphNode, port: int) -> Array[Dictionary] *Returns all connections of specified GraphNode port.*
get_connections_between(nodeA: GraphNode, nodeB: GraphNode) -> Array[Dictionary] *Returns all connections of between two GraphNodes.*
get_connections_between_all(nodes: Array[GraphNode]) -> Array[Dictionary] *Returns all connections of between multiple GraphNodes.*
get_connections_to(nodeA: GraphNode, nodeB: GraphNode) -> Array[Dictionary] *Returns all connections from nodeA to nodeB.*
get_connections_from(nodeA: GraphNode, nodeB: GraphNode) -> Array[Dictionary] *Returns all connections to nodeA from nodeB.*

as_node(node_name: StringName) -> GraphNode *Returns StringName as GraphNode*
as_index_relative(nodes: Array[GraphNode]) -> Array[Dictionary] *Returns name-based connections between given nodes as index-related connections.*



---------YOU CAN USE THIS AS A DOCUMENTATION---------
