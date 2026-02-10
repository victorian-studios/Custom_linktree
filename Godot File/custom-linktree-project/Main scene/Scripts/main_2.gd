extends Control

@export var vfx_leafs: PackedScene
@export var vfx_steam: PackedScene
@export var vfx_clicks: PackedScene

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

@export var current_effect = {}
@export var buttons_effects = []

func _ready():
	var size := get_viewport().get_visible_rect().size
	if size.y > size.x:
		OS.alert("socorro!!!")
	# if DisplayServer.screen_get_orientation() == DisplayServer.SCREEN_PORTRAIT:
	# 	OS.alert(str(DisplayServer.screen_get_orientation()))
	# else:
	# 	OS.alert("SOCORRO")
	# var is_mobile := OS.has_feature("web_android")
	
	# if is_mobile:
	# 	pass
	# 	# get_window().size = Vector2i(400, 1080)

	for button in $ControlLinks/Screens/GamesControl/ScrollGames/VBoxContainer.get_children():
		if !button.disabled:
			button.connect("mouse_entered", Callable(self, "_on_button_hovered").bind(button))
			button.connect("mouse_exited", Callable(self, "_on_button_exited").bind(button))
		
	for button in $ControlLinks/Screens/SocialMediasControl/ScrollSocialMedias/VBoxContainer.get_children():
		button.connect("mouse_entered", Callable(self, "_on_button_hovered").bind(button))
		button.connect("mouse_exited", Callable(self, "_on_button_exited").bind(button))


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

func add_particles(button_name, effects_dict):
	for effects in effects_dict[button_name]:
		var vfx
		vfx = effects["effect"].instantiate()
		effects["marker"].add_child(vfx)

func rmv_particles(button_name, effects_dict):
	for effects in effects_dict[button_name]:
		current_effect = {}
		# effects["effect"].queue_free()
		effects["marker"].get_children()[0].queue_free()

func _on_button_hovered(button):
	add_text_effects(button.get_node("Text"))
	if button.name in buttons_effects:

		match button.name:
			"SurvivorStory":
				current_effect = {button.name : [{"marker": $MarkerLeafs, "effect":vfx_leafs}]}
			"SteamClicks":
				current_effect = {button.name : [{"marker": $MarkerSteam, "effect":vfx_steam}, {"marker": $MarkerClicks, "effect":vfx_clicks}]}

		add_particles(button.name, current_effect)

func _on_button_exited(button):
	rmv_text_effects(button.get_node("Text"))

	if button.name in buttons_effects:
		rmv_particles(button.name, current_effect)
