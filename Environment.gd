extends Node2D

signal nom_nom
signal end_game
var total_nom_noms = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Iterates through an array of every child node of this Environment node
	for N in get_children():
		if N is Area2D:
			N.connect("body_entered", self, "_on_NomNom_body_entered", [N])
			total_nom_noms += 1

func _on_NomNom_body_entered(body, nomnom):
	if body.get_name() == "LivingBody":
		emit_signal("nom_nom")
		total_nom_noms -= 1
	if total_nom_noms <= 0:
		emit_signal("end_game")
		