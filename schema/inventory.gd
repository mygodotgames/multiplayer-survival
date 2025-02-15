class_name Inventory
extends Resource

signal inventory_updated

@export var items:Array[Item] = []
 
var total_slots: int = 20

 
		
func _init():
	items.resize(total_slots)
	items.fill(null)
 
func add_item(item: Item) -> bool:
	for i in items.size():
		if items[i] == null:
			items[i] = item
			print(items[i].name)
			emit_signal("inventory_updated")
			return true
	return false


func remove_item(index: int) -> bool:
	if index < 0 or index >= items.size():
		return false
	
	items[index] = null
	emit_signal("inventory_updated")
	return true
 
 
func get_items() -> Array:
	return items

func get_size() -> int:
	return total_slots
