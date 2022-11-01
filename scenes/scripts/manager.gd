extends Node2D

@onready var deck = $Deck
@onready var discard = $Discard
@onready var players = $Players

func _ready():
	for player in players.get_children():
		player.connect('played_card', play_card)
		for x in 7:
			var card = deck.get_child(randi() % deck.get_child_count())
			player.draw_card(card)

func _process(delta):
	pass

func play_card(player: Player, card: Card):
	card.get_parent().remove_child(card)
	card.position = Vector2.ZERO
	discard.add_child(card)
