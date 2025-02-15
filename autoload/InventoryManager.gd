# InventoryManager.gd (Autoloader)
extends Node

var player_inventory: Inventory

# Player inventory'yi alıp döndüren fonksiyon
func get_player_inventory() -> Inventory:
	if not player_inventory:
		player_inventory = Inventory.new()
	return player_inventory
 
