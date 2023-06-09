extends Node

signal category_data_ready


var categories = []

var current_shuffled_list : Array = []
var current_index = 0


func _ready():
	pass
	
func prepare_category_data():
	
	var category_data_collection = Firebase.Firestore.collection('category_data')
	category_data_collection.get("main")
	var room_doc = yield(category_data_collection, "get_document")
	categories = room_doc.doc_fields["cats"]
	
	randomize()
	shuffle_new_list()
	
	emit_signal("category_data_ready")
	
func shuffle_new_list():
	
	current_shuffled_list = categories.duplicate()
	current_shuffled_list.shuffle()
	current_index = 0

func get_12():
	
	if current_index + 11 >= current_shuffled_list.size():
		shuffle_new_list()
	
	var temp = current_shuffled_list.slice(current_index, current_index + 11)
	current_index += 12
	return temp.duplicate()
	
func get_1():
	
	if current_index >= current_shuffled_list.size():
		shuffle_new_list()
		
	current_index += 1
	return current_shuffled_list[current_index]
	





