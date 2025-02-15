extends Node3D

var PLAYER = preload("res://elements/player/player.tscn")
var peer = ENetMultiplayerPeer.new()


#func _ready() -> void:
	#start_server()
#
#func start_server() -> void:
	#if not peer:
		#print("Error: ENetMultiplayerPeer instance is null!")
		#return
	#
	#var error = peer.create_server(9999)
	#if error != OK:
		#print("Server creation failed: ", error)
		#return
	#
	#multiplayer.multiplayer_peer = peer
	#multiplayer.peer_connected.connect(
		#func(pid):
			#print("Peer " + str(pid) + " has joined!")
			#add_player(pid)
	#)
	#add_player(multiplayer.get_unique_id())
	#print("Server started!")
	#$UI.visible = false
	#
 

#------ BUTTON ILE MULTIPLAYER CLIENTLI ------  
 
		
func _on_host_button_pressed() -> void:
	peer.create_server(1337)
	multiplayer.multiplayer_peer = peer
	
	# Spawner'ı yapılandır
	$MultiplayerSpawner.spawn_function = custom_spawn
	
	multiplayer.peer_connected.connect(
		func(pid):
			print("Peer " + str(pid) + " has joined!")
			$MultiplayerSpawner.spawn(pid)  # Spawn fonksiyonu ile oluştur
	)
	
	# Host kendisi için oyuncu ekle
	$MultiplayerSpawner.spawn(multiplayer.get_unique_id())
	
	$UI/Label.text = "Server"
	$UI.visible = false

func _on_client_button_pressed() -> void:
	peer.create_client("localhost", 1337)
	multiplayer.multiplayer_peer = peer
	
	# Spawn fonksiyonunu istemci tarafında da tanımla
	$MultiplayerSpawner.spawn_function = custom_spawn
	
	$UI/Label.text = "Client"
	$UI.visible = false

func custom_spawn(data: Variant) -> Node:
	var player_scene = preload("res://elements/player/player.tscn")
	var player = player_scene.instantiate()
	player.name = str(data)
	
	# Oyuncuya yetki ataması yap
	player.set_multiplayer_authority(data)
	
	return player
