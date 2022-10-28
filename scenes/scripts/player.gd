extends Node2D
class_name Player

signal player_played_card(player: Player, card: Card)

@onready var hand = $Hand


func update_card_positions():

	var max_width: float = 200
	var max_space: float = 20
	var num_cards: float = hand.get_child_count()
	var space: float = 0
	var left_anchor: float = 0
	
	if num_cards > 1:
		space = max_width / (num_cards - 1.0) if max_width / (num_cards - 1.0) < max_space else max_space
		left_anchor = -((space * (num_cards - 1.0))/2.0)
	
	for card in hand.get_children():
		card.position = Vector2(left_anchor + space * card.get_index(), 0)


func play_card(card: Card):
	
	player_played_card.emit(self, card)
	


func draw_card(card: Card):
	
	card.get_parent().remove_child(card)
	card.is_hidden = false
	self.hand.add_child(card)


func _on_hand_child_entered_tree(node):
	
	update_card_positions()
	node.connect('tree_exited', update_card_positions)
	node.connect('card_played', play_card)
