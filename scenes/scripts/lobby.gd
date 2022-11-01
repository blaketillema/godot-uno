extends Control

const port = 8080
const address = "localhost"

var multiplayer_peer = ENetMultiplayerPeer.new()

func _on_host_pressed():
	multiplayer_peer.create_server(port)
	multiplayer.multiplayer_peer = multiplayer_peer
	
	multiplayer_peer.peer_connected.connect(
		func(peer_id):
			print("Player connected")
			rpc('start_game')
	)

func _on_join_pressed():
	multiplayer_peer.create_client(address, port)
	multiplayer.multiplayer_peer = multiplayer_peer
	
	multiplayer_peer.connection_succeeded.connect(
		func():
			print("Connected successfully")
			rpc('start_game')
	)

@rpc(call_local)
func start_game():
	print("starting game")
	get_tree().change_scene_to_file("res://scenes/manager.tscn")
