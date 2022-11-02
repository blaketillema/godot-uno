extends Control

const port = 8080
const address = "localhost"

var multiplayer_peer = ENetMultiplayerPeer.new()

func _on_host_pressed():
	multiplayer_peer.create_server(port)
	multiplayer.multiplayer_peer = multiplayer_peer
	
	multiplayer.peer_connected.connect(
		func(id: int):
			if multiplayer.get_peers().size() == 1:
				rpc('start_game')
	)

func _on_join_pressed():
	multiplayer_peer.create_client(address, port)
	multiplayer.multiplayer_peer = multiplayer_peer
	
	multiplayer.connected_to_server.connect(
		func():
			print(str(multiplayer_peer.get_unique_id()) + ": Player Connected")
	)

@rpc(call_local)
func start_game():
	print("Starting game")
	get_tree().change_scene_to_file("res://scenes/manager.tscn")
