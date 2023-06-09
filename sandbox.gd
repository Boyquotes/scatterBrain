extends Node2D


func _ready():
	
#	print("hello")
	
	Firebase.Auth.login_anonymous()
	var collection = Firebase.Firestore.collection('rooms')
	
	var dict = {
		'host': 'dq',
		'letter': 'L'
	}
	var add_task = collection.add("", dict)
	
	var doc = yield(add_task, "add_document")
	print(doc)
	
#	print("...")
#
#	print(doc.doc_name)
#	print(doc.create_time)
#


##	var golf = null
##
##	if collection == null:
##		print("nothing here")
##	else:
##		print("something here")
#
#	collection.get('panda')
#	var document = yield(collection, "get_document")
#
#	print(document)
		
	
	
	
