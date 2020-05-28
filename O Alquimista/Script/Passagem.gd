extends Area2D

export (String, FILE, "*.tscn") var cena

func _on_Passagem_body_entered(body):
	print ("ta rolando")
	get_tree().change_scene(cena)
