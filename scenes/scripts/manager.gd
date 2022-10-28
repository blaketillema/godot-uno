extends Node2D

@onready var deck = $Deck
@onready var discard = $Discard
@onready var players = $Players

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for player in players.get_children():
		player.connect('player_played_card', play_card)
		for x in 7:
			var card = deck.get_child(randi() % deck.get_child_count())
			player.draw_card(card)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func play_card(player: Player, card: Card):
	card.get_parent().remove_child(card)
	card.position = Vector2.ZERO
	discard.add_child(card)
