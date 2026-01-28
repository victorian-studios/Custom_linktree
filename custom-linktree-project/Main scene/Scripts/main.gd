extends Node2D

#redes sociais
@export var link_youtube = "https://www.youtube.com/@VictorianStudioOfficial"
@export var link_discord = "https://www.youtube.com/@VictorianStudioOfficial"
@export var link_instagram = "https://www.youtube.com/@VictorianStudioOfficial"
@export var link_bluesky = "https://www.youtube.com/@VictorianStudioOfficial"
@export var link_twitter = "https://www.youtube.com/@VictorianStudioOfficial"

#jogos
@export var link_survivor_story = "https://www.youtube.com/@VictorianStudioOfficial"
@export var link_steamclicks = "https://www.youtube.com/@VictorianStudioOfficial"
@export var link_wonderjack = "https://www.youtube.com/@VictorianStudioOfficial"

func _ready():
	for button in $Control/Buttons_1.get_children():
		button.connect("mouse_entered", Callable(self, "_on_button_hovered").bind(button))
		button.connect("mouse_exited", Callable(self, "_on_button_exited").bind(button))

func _on_youtube_pressed():
	OS.shell_open(link_youtube)

func _on_discord_pressed():
	OS.shell_open(link_discord)

func _on_instagram_pressed():
	OS.shell_open(link_instagram)

func _on_bluesky_pressed():
	OS.shell_open(link_bluesky)

func _on_x_pressed():
	OS.shell_open(link_twitter)

func add_text_effects(button_text):
	var amplitude = str(50.0)
	var frequency = str(10.0)
	button_text.text = "[wave amp="+amplitude+" freq="+frequency+"]"+button_text.text+"[/wave]"
	# player_life_label.text = "[wave amp="+amplitude+" freq="+frequency+"]"+str(int(player_life.value)) +"/"+ str(int(player_life.max_value))+"[/wave]"
	# player_life_label.text = "[wave]"+str(int(player_life.value))+" / "+str(int(player_life.max_value))+"[/wave]"

func rmv_text_effects(button_text):
	var regex := RegEx.new()
	regex.compile("\\[.*?\\]")
	button_text.text = regex.sub(button_text.text, "", true)

func _on_button_hovered(button):
	add_text_effects(button.get_node("Text"))

func _on_button_exited(button):
	rmv_text_effects(button.get_node("Text"))