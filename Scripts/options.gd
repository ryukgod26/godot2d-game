extends CanvasLayer

@onready var master_volume: HSlider = $TabContainer/Music/MasterVolume
@onready var music_volume: HSlider = $TabContainer/Music/MusicVolume
@onready var sfx_volume: HSlider = $TabContainer/Music/SFXVolume

var master_bus_index
var sfx_bus_index
var music_bus_index

var volume

# Called 
func _ready() -> void:
	master_bus_index = AudioServer.get_bus_index("Master")
	music_bus_index = AudioServer.get_bus_index("Music")
	sfx_bus_index = AudioServer.get_bus_index("SFX")
	
	master_volume.value = db_to_linear(AudioServer.get_bus_volume_db(master_bus_index))
	music_volume.value = db_to_linear(AudioServer.get_bus_volume_db(music_bus_index))
	sfx_volume.value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus_index))
	
	visible = false
	$ColorRect.material.set_shader_parameter("glass_intensity",0.0)
	$TabContainer/Video/GlassIntensity.value = $ColorRect.material.get_shader_parameter('glass_intensity')

func _on_back_pressed() -> void:
	visible = false

func _on_resolution_item_selected(index: int) -> void:
	match  index:
		0:
			DisplayServer.window_set_size(Vector2i(1600,900))
		1:
			DisplayServer.window_set_size(Vector2i(1080,720))
		2:
			DisplayServer.window_set_size(Vector2i(1920,1080))


func _on_window_type_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_mutebtn_toggled(toggled_on: bool) -> void:
	if toggled_on:
		volume = master_volume.value
		master_volume.value = 0
	else:
		if master_volume.value == 0:
			master_volume.value = volume


func _on_master_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus_index,linear_to_db(value))

func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus_index,linear_to_db(value))

func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus_index,linear_to_db(value))


func _on_glass_intensity_value_changed(value: float) -> void:
	$ColorRect.material.set_shader_parameter("glass_intensity",value)
