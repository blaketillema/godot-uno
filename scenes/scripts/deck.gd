extends Node2D

@onready var card = preload("res://scenes/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	create_deck()


func create_deck():
	
	print('creating deck')
	
	for colour in Card.Colours.values():
		for type in Card.Types.values():
			if type == Card.Types.NUMBER:
				self.add_child(create_card(colour, type, 0))
				for number in 18:
					self.add_child(create_card(colour, type, (number % 9) + 1))
			else:
				for i in 2:
					self.add_child(create_card(colour, type, 0))


func create_card(colour, type, number):
	
	var new_card: Card = card.instantiate()
	
	new_card.colour = colour
	new_card.type = type
	new_card.number = number
	new_card.is_hidden = true
	
	new_card.position = Vector2.ZERO
	
	return new_card
	
