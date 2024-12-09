extends Control

var posttitle
var posttext
var postdesc
var button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	posttitle = $title
	postdesc = $description
	posttext = $text
	button = $Button


func _on_button_pressed() -> void:
	var file = FileAccess.open("posts-template.html", FileAccess.READ)
	var content = file.get_as_text()
	
	
	content = content.replace("{{title}}",posttitle.text)
	content = content.replace("{{description}}",postdesc.text)
	content = content.replace("{{article}}",posttext.text)
	
	var time = Time.get_date_dict_from_system()
	
	var datefolder = "%04d-%02d-%02d" % [time.year, time.month, time.day]
	var postFolderToSave = "posts/%s" % [datefolder]
	var postFileName = posttitle.text.replace(" ","-")
	DirAccess.make_dir_absolute(postFolderToSave)
	
	var postfile = FileAccess.open("%s/%s.html" % [postFolderToSave, postFileName], FileAccess.WRITE)
	postfile.store_string(content)	
	
	button.text = "Done!"
	button.disabled = true

func turnButtonOn():
	button.text = "Submit"
	button.disabled = false

func _on_text_text_changed() -> void:
	turnButtonOn()


func _on_description_text_changed() -> void:
	turnButtonOn()


func _on_title_text_changed() -> void:
	turnButtonOn()