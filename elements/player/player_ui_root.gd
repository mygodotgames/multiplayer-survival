extends CanvasLayer
@onready var inventory_modal: InventoryModal = $InventoryModal
 
func _input(event):
	if is_multiplayer_authority() and event.is_action_pressed("inventory"):
		toggle_inventory()
		
func toggle_inventory():
	inventory_modal.visible = !inventory_modal.visible

 
