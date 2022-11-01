extends Node2D
class_name Card

enum Colours {GREEN, YELLOW, PURPLE, RED}
enum Types {NUMBER, SKIP, REVERSE, DRAW, WILD}
signal card_selected(card: Card)

@export var colour: Colours
@export var type: Types
@export_range(0,9,1) var number: int
@export var is_hidden: bool:
	set(value):
		is_hidden = value
		set_face()

@onready var face = $Face

func _ready():
	set_face()

func set_face():
	if face:
		if self.is_hidden:
			face.texture = load("res://assets/color_back.png")
		elif self.type == Types.WILD:
			face.texture = load("res://assets/color_wild.png")
		elif self.type == Types.NUMBER:
			face.texture = load("res://assets/color_" + str(Colours.keys()[self.colour]).to_lower() + "_" + str(self.number) + ".png")
		else:
			face.texture = load("res://assets/color_" + str(Colours.keys()[self.colour]).to_lower() + "_" + str(Types.keys()[self.type]).to_lower() + ".png")

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("play_card"):
		card_selected.emit(self)

func _on_area_2d_mouse_entered():
	face.position.y -= 15

func _on_area_2d_mouse_exited():
	face.position.y += 15
