extends Node2D

#To do:

#Fix the start timer label whenever the second level begins
#18+ errors that only show up when you get all the dots, not when the time runs out
#Add A.I.
	#Add AI as an option in the control options and hook it up
	#Create the navigation-related nodes
	#Add the AI methods to the monster classes (and the hero class)
#Fix the looped levels so that they actually work - right now the only last_level that works is 2.

#(optional)Make it so that all four players are randomly spawned in the four corners of level 2 (and beyond)
#(optional) Create the boss level

var player1_score = 0
var player2_score = 0
var player3_score = 0
var player4_score = 0
var alive_player = 1
var squid_player = 2
var bat_player = 3
var spider_player = 4
var switching
var countdown_count
var level
var last_level = 2

func _ready():
	switching = true			#cheats the switch signal functionality to keep players from moving before "start" pressed
	color_monster($LivingBody/AnimatedSprite, "red")
	color_monster($SquidBody/AnimatedSprite, "blue")
	color_monster($BatBody/AnimatedSprite, "green")
	color_monster($SpiderBody/AnimatedSprite, "pink")
	$MenuMusic.play()
	$LivingBody.show()
	$SquidBody.show()
	$BatBody.show()
	$SpiderBody.show()
	$Environment.show()
	$Environment/Background.z_index = 3
	level = 1
	
	$Hud/P1_score.modulate = Color(.533, .176, .176)
	$Hud/P2_score.modulate = Color(1, 1, 1)
	$Hud/P3_score.modulate = Color(1, 1, 1)
	$Hud/P4_score.modulate = Color(1, 1, 1)

func _on_Squidbody_hit_living():
	if $PSwitchTimer.get_time_left() == 0 && switching == false:
		swap_colors($SquidBody/AnimatedSprite, squid_player)
		switch_players("Squid")
	
func _on_BatBody_hit_living():
	if $PSwitchTimer.get_time_left() == 0 && switching == false:
		swap_colors($BatBody/AnimatedSprite, bat_player)
		switch_players("Bat")
	
func _on_SpiderBody_hit_living():
	if $PSwitchTimer.get_time_left() == 0 && switching == false:
		swap_colors($SpiderBody/AnimatedSprite, spider_player)
		switch_players("Spider")
	
func switch_players(strEnemy):
	var temp
	if strEnemy == "Bat":
		swap_controls($BatBody)
		temp = bat_player
		bat_player = alive_player
		alive_player = temp
		
	if strEnemy == "Squid":
		swap_controls($SquidBody)
		temp = squid_player
		squid_player = alive_player
		alive_player = temp
		#Switch controls, activate switching timer, and switch positions to create illusion of switching bodies
			
	if strEnemy == "Spider":
		swap_controls($SpiderBody)
		temp = spider_player
		spider_player = alive_player
		alive_player = temp
	
	$LivingBody/BodySprite.play("switch")
	$LivingBody/AnimatedSprite.hide()

func swap_controls(child):
	var temp
	switching = true
	$PSwitchTimer.start()
	
	temp = child.controls
	child.controls = $LivingBody.controls
	$LivingBody.controls = temp
	
	#temp = child.position
	#child.position = $LivingBody.position
	#$LivingBody.position = temp
	
func swap_colors(childSprite, enemyPlayer):
	var new_mon_color
	var new_alive_color
		#If the player that was alive is 1, 2, 3, or 4
	match alive_player:
		1:
			new_mon_color = "red"
			$Hud/P1_score.modulate = Color(1, 1, 1)
		2:
			new_mon_color = "blue"
			$Hud/P2_score.modulate = Color(1, 1, 1)
		3:
			new_mon_color = "green"
			$Hud/P3_score.modulate = Color(1, 1, 1)
		4:
			new_mon_color = "pink"
			$Hud/P4_score.modulate = Color(1, 1, 1)
		_: print("Error: alive player not 1, 2, 3, or 4")
	color_monster(childSprite, new_mon_color)		#Then change the color of the monster to that of the corresponding player
		#If the monster that hit the livingBody was player 1, 2, 3, or 4
	match enemyPlayer:
		1:
			new_alive_color = "red"
			$Hud/P1_score.modulate = Color(.533, .176, .176)
		2:
			new_alive_color = "blue"
			$Hud/P2_score.modulate = Color(.176, .176, .533)
		3:
			new_alive_color = "green"
			$Hud/P3_score.modulate = Color(.2, .788, .25)
		4:
			new_alive_color = "pink"
			$Hud/P4_score.modulate = Color(.714, .15, .38)
		_: print("Error: enemy player not 1, 2, 3, or 4")
	color_monster($LivingBody/AnimatedSprite, new_alive_color)		#Then change the color of the livingBody to that of the corresponding player

func color_monster(child, color):
	if color == "red":
		child.modulate = Color(1.5, .5, .5)
	if color == "green":
		child.modulate = Color(1, 2, 1)
	if color == "blue":
		child.modulate = Color(.5, .5, 1.5)
	if color == "pink":
		child.modulate = Color(2, .8, 1.3)

func _on_PSwitchTimer_timeout():
	
	var random = RandomNumberGenerator.new() #For randomizing Alive spawn
	var temp
	
	$LivingBody/BodySprite.show()
	
	if switching:
		switching = false
		$LivingBody/BodySprite.play("default")
		$LivingBody/AnimatedSprite.show()
		
		random.randomize()
		temp = random.randi_range(0, 7)
		#Switch statement to clean up code for randomizing Alve Spawn after switch
		match temp:
			0: $LivingBody.position = $SpawnPoints/AliveSpawn1.position
			1: $LivingBody.position = $SpawnPoints/AliveSpawn2.position
			2: $LivingBody.position = $SpawnPoints/AliveSpawn3.position
			3: $LivingBody.position = $SpawnPoints/AliveSpawn4.position
			4: $LivingBody.position = $SpawnPoints/AliveSpawn5.position
			5: $LivingBody.position = $SpawnPoints/AliveSpawn6.position
			6: $LivingBody.position = $SpawnPoints/AliveSpawn7.position
			7: $LivingBody.position = $SpawnPoints/AliveSpawn8.position
			_: $LivingBody.position = $SpawnPoints/AliveSpawn1.position

func _on_Environment_nom_nom():
	
	#Based on which player is currently player the Hero, adjust the appropriate score
	match alive_player:
		1:
			player1_score += 1
			$Hud/P1_score.text = "Player One:\n" + str(player1_score)
		2:
			player2_score += 1
			$Hud/P2_score.text = "Player Two:\n" + str(player2_score)
		3:
			player3_score += 1
			$Hud/P3_score.text = "Player Three:\n" + str(player3_score)
		4:
			player4_score += 1
			$Hud/P4_score.text = "Player Four:\n" + str(player4_score)

func _on_Level2_nom_nom():
	_on_Environment_nom_nom()

func _on_Environment_end_game():
	level += 1
	new_level(level, $Environment)

func _on_Hud_end_game():
	print("hud end game: LEVEL " + str(level) + "!\n")
	if level == 1:
		_on_Environment_end_game()
	elif level >= last_level:
		print("last level - end game")
		last_level_end_game()
	else:
		_on_Level2_end_game()

func _on_Hud_start_game():
	$CountdownLabel.show()
	countdown_count = 3
	print(str(countdown_count))
	$MenuMusic.stop()
	$Pentagraphic.stop()
	$TombSong.stop()
	$StartTimer.start()
	if level == 1: $Environment/Background.z_index = -1
	else: $new_instance/Background.z_index = -1

func start_first_level():
	$Hud/LevelTimer.start()
	$Hud/LevelTimeLabel.show()
	switching = false
	$LivingBody.controls = $Hud.p1_controls
	$SquidBody.controls = $Hud.p2_controls
	$BatBody.controls = $Hud.p3_controls
	$SpiderBody.controls = $Hud.p4_controls
	$Pentagraphic.play()

func _on_StartTimer_timeout():
	countdown_count -= 1
	if countdown_count <= 0:
		$StartTimer.stop()
		if level == 1:
			start_first_level()
		elif level >= last_level:
			start_new_level($TombSong)
		else:
			start_new_level($Pentagraphic)
		$CountdownLabel.hide()
	else:
		$CountdownLabel.text = str(countdown_count)
	print(countdown_count)

func start_new_level(childSong):
	$Hud/LevelTimer.start()
	$Hud/LevelTimeLabel.show()
	switching = false
	childSong.play()
	
func _on_Level2_end_game():
	var format_string = "$level%s_instance"
	var old_level = format_string % str(level)
	level += 1
	print("old level is " + old_level)
#	new_level(level, $new_instance)
	last_level_end_game()

func new_level(new_level_number, old_level_child):
	print("Level " + str(level) + "! new_level()")
	
	var format_string = "level%s_instance"
	var new_name = format_string % str(new_level_number)
	
	#Replace old "Level2" Environment with new "Level2" Environment
	old_level_child.queue_free()
	print("$new_instance.queue_free()")
	var Level2 = load("res://Level2.tscn")
	var new_instance = Level2.instance()
	new_instance.set_name("new_instance")
	self.add_child(new_instance)
	print($new_instance.get_name())
	$new_instance.connect("end_game", self, "_on_Level2_end_game")
	$new_instance.connect("nom_nom", self, "_on_Level2_nom_nom")
	$new_instance.z_index = -1
	$new_instance/Background.z_index = -2
	$new_instance/Pentagrams.z_index = -1
	
	switching = true
	$LivingBody.position.x = 1216
	$LivingBody.position.y = 656
	$LivingBody.show()
	$SquidBody.position.x = 1216
	$SquidBody.position.y = 176
	$SquidBody.show()
	$BatBody.position.x = 64
	$BatBody.position.y = 176
	$BatBody.show()
	$SpiderBody.position.x = 64
	$SpiderBody.position.y = 656
	$SpiderBody.show()
	
	#starts visible countdown to the start of the next level
	_on_Hud_start_game()

func last_level_end_game():
	var winning_player
	var winning_score
	#$TombSong.stop()
	#$VictorySong.start()
	print("congratulations! level2_end_game")
	
	switching = true
	winning_score = max(player1_score, max(player2_score, max(player3_score, player4_score)))
	match winning_score:
		player1_score: winning_player = 1
		player2_score: winning_player = 2
		player3_score: winning_player = 3
		player4_score: winning_player = 4
	
	$Hud/MessageLabel.show()
	$Hud/MessageLabel.text = "Congratulations!"
	$Hud/MessageLabel.margin_left = 0
	$Hud/MessageLabel.margin_right = 1280
	$Hud/ExitButton.show()
	$Hud/ExitButton.margin_left = 576
	$Hud/ExitButton.margin_right = 733
	$Hud/ExitButton.margin_top = 488
	$Hud/ExitButton.margin_bottom = 552
	$Hud/LevelTimeLabel.hide()
	
	match winning_player:
		1: winning_player = "Player One"
		2: winning_player = "Player Two"
		3: winning_player = "Player Three"
		4: winning_player = "Player Four"
	
	$Hud/WinLabel.show()
	if player1_score != player2_score && player1_score != player3_score && player1_score != player4_score:
		$Hud/WinLabel.text = "You win, " + winning_player + "! Your high score was:\n" + str(winning_score)
	$new_instance/Background.z_index = 3
