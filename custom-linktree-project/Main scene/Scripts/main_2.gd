extends Control

#redes sociais
@export var link_youtube = "https://www.youtube.com/@VictorianStudioOfficial"
@export var link_discord = "https://discord.gg/rjkPdmD7"
@export var link_instagram = "https://www.instagram.com/victorianstudioofficial/"
@export var link_bluesky = "https://bsky.app/profile/victorianstudio.bsky.social"
@export var link_twitter = "https://x.com/VictorianStd"
@export var link_itchio = "https://victorianstudio.itch.io/"
#jogos
@export var link_survivor_story = "https://store.steampowered.com/app/3186200/Survivor_Story_The_Apocalypse/"
@export var link_steamclicks = "https://store.steampowered.com/app/3805000/Steam__Clicks/"
@export var link_wonderjack = "https://victorianstudio.itch.io/wonderjack"

@export var current_screen_number: int = 0

func _ready():
	$ControlLinks/Screens/GamesControl.visible = true
	$ControlLinks/Screens/SocialMediasControl.visible = false

	$ControlLinks/Left.disabled = true
	$ControlLinks/Right.disabled = false

	for button in $ControlLinks/Screens/GamesControl/ScrollGames/VBoxContainer.get_children():
		button.connect("mouse_entered", Callable(self, "_on_button_hovered").bind(button))
		button.connect("mouse_exited", Callable(self, "_on_button_exited").bind(button))
	
	for button in $ControlLinks/Screens/SocialMediasControl/ScrollSocialMedias/VBoxContainer.get_children():
		button.connect("mouse_entered", Callable(self, "_on_button_hovered").bind(button))
		button.connect("mouse_exited", Callable(self, "_on_button_exited").bind(button))

func switch_screen(sum_number):
	
	($ControlLinks/Screens.get_children())[current_screen_number].visible = false
	($ControlLinks/Screens.get_children())[current_screen_number + sum_number].visible = true
	current_screen_number += sum_number

	if current_screen_number + 1 == $ControlLinks/Screens.get_children().size():
		$ControlLinks/Right.disabled = true
	else:
		$ControlLinks/Right.disabled = false
	if current_screen_number == 0:
		$ControlLinks/Left.disabled = true
	else:
		$ControlLinks/Left.disabled = false
	

func _on_right_pressed():
	switch_screen(1)

	# $ControlLinks/Right.disabled = button_is_enabled
	# $ControlLinks/Left.disabled = !(button_is_enabled)

	# $ControlLinks/GamesControl.visible = !(control_is_visible)
	# $ControlLinks/SocialMediasControl.visible = control_is_visible

func _on_left_pressed():
	switch_screen(-1)
# 	$ControlLinks/Left.disabled = button_is_enabled
# 	$ControlLinks/Right.disabled = !(button_is_enabled)

# 	$ControlLinks/GamesControl.visible = control_is_visible
# 	$ControlLinks/SocialMediasControl.visible = !(control_is_visible)





func _on_survivor_story_pressed():
	OS.shell_open(link_survivor_story)

func _on_steam_clicks_pressed():
	OS.shell_open(link_steamclicks)

func _on_wonderjack_pressed():
	OS.shell_open(link_wonderjack)

func _on_discord_pressed():
	OS.shell_open(link_discord)

func _on_youtube_pressed():
	OS.shell_open(link_youtube)

func _on_instagram_pressed():
	OS.shell_open(link_instagram)

func _on_bluesky_pressed():
	OS.shell_open(link_bluesky)

func _on_twiter_pressed():
	OS.shell_open(link_twitter)

func _on_itchio_pressed():
	OS.shell_open(link_itchio)

func add_text_effects(button_text):
	var amplitude = str(20.0)
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
