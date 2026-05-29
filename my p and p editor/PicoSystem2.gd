extends Control
@onready var display = $Display
@onready var code_editor = $CodeEditor
var vram = PackedByteArray(); var sprites = PackedByteArray(); var map_data = PackedByteArray()
var colors: Array[Color] = []; var screen_img = Image.create(128, 128, false, Image.FORMAT_RGB8)
var vm_node = null; var cam_x = 0; var player_code_text = ""
enum Mode { TITLE, MAP, CODE, GAME }
var current_mode = Mode.TITLE; var brush_col = 7
var grid_needs_update = true
@onready var audio = $AudioStreamPlayer

func _ready():
	vram.resize(16384); sprites.resize(16384); map_data.resize(2048)
	var pal = ["000000","1D2B53","7E2553","008751","AB5236","5F574F","C2C3C7","FFF1E8","FF004D","FFA300","FFEC27","00E436","29ADFF","83769C","FF77A8","FFCCAA"]
	for c in pal: colors.append(Color(c))
	display.texture = ImageTexture.create_from_image(screen_img)
	load_cart() # Авто-загрузка при старте

func _process(_delta):
	if current_mode == Mode.GAME and is_instance_valid(vm_node):
		if vm_node.has_method("_game_loop"): vm_node._game_loop()
	elif current_mode == Mode.TITLE: _title_editor()
	elif current_mode == Mode.MAP: _map_editor()
	_render_to_screen()

func _render_to_screen():
	# Создаем массив цветов один раз, это в 100 раз быстрее ручного перебора
	var raw_data = PackedByteArray()
	raw_data.resize(16384 * 3) # RGB данные
	for i in range(16384):
		var col = colors[vram[i]]
		raw_data[i*3] = int(col.r * 255)
		raw_data[i*3+1] = int(col.g * 255)
		raw_data[i*3+2] = int(col.b * 255)
	
	var img = Image.create_from_data(128, 128, false, Image.FORMAT_RGB8, raw_data)
	display.texture.set_image(img)

func pset(x,y,c):
	var ix=int(x)-cam_x; var iy=int(y)
	if ix>=0 and ix<128 and iy>=0 and iy<128: vram[iy*128+ix]=int(c)%16

func rect(x, y, w, h, c):
	for j in range(int(h)):
		for i in range(int(w)):
			pset(x + i, y + j, c)

func rectb(x, y, w, h, c):
	for i in range(int(w)):
		pset(x + i, y, c)
		pset(x + i, y + h - 1, c)
	for j in range(int(h)):
		pset(x, y + j, c)
		pset(x + w - 1, y + j, c)

func cls(c=0): vram.fill(c)
func camera(x,y): cam_x = int(x)
func mget(tx,ty): 
	var idx = int(ty)*128+int(tx)
	return map_data[idx] if idx>=0 and idx<2048 else 0

func map_draw():
	# Вычисляем, какие тайлы попадают в экран
	var start_x = clampi(cam_x / 8, 0, 127)
	var end_x = clampi((cam_x + 128) / 8 + 1, 0, 127)
	
	for ty in range(16):
		for tx in range(start_x, end_x):
			var t = map_data[ty * 128 + tx]
			if t > 0:
				sspr((t % 16) * 8, (int(t / 16)) * 8, tx * 8, ty * 8, 8, 8)

func sspr(sx,sy,x,y,w,h,f=false):
	for j in range(h):
		for i in range(w):
			var col = sprites[(sy+j)*128+(sx+(w-1-i if f else i))]
			if col != 0: pset(x+i, y+j, col)

func btn(i):
	var ks=[KEY_LEFT,KEY_RIGHT,KEY_UP,KEY_DOWN,KEY_Z,KEY_X,KEY_C,KEY_A]
	return Input.is_key_pressed(ks[i])

func _compile():
	vm_node = null; player_code_text = code_editor.text
	var script = GDScript.new(); var c = "extends RefCounted\nvar _e\n"
	c += "func pset(x,y,c): _e.pset(x,y,c)\nfunc cls(c=0): _e.cls(c)\n"
	c += "func sspr(sx,sy,x,y,w,h,f=false): _e.sspr(sx,sy,x,y,w,h,f)\n"
	c += "func rect(x,y,w,h,c): _e.rect(x,y,w,h,c)\n"
	c += "func rectb(x,y,w,h,c): _e.rectb(x,y,w,h,c)\n"
	c += "func sfx(f,d): _e.sfx(f,d)\n"
	c += "func btn(i): return _e.btn(i)\nfunc mget(x,y): return _e.mget(x,y)\n"
	c += "func map_draw(): _e.map_draw()\nfunc camera(x,y): _e.camera(x,y)\n"
	c += player_code_text
	var forbidden_words = ["OS.", "FileAccess", "DirAccess", "ClassDB", "ProjectSettings"]
	for word in forbidden_words:
		if player_code_text.contains(word):
			print("ACCESS DENIED: Forbidden command!")
			return # Выход из компиляции
	script.source_code = c
	if script.reload() == OK:
		vm_node = script.new(); vm_node.set("_e", self); current_mode = Mode.GAME; code_editor.visible = false

func _input(e):
	if e is InputEventKey and e.pressed:
		if e.keycode == KEY_F1: current_mode = Mode.CODE; code_editor.text = player_code_text; code_editor.visible = true
		if e.keycode == KEY_F2: current_mode = Mode.TITLE; code_editor.visible = false
		if e.keycode == KEY_F3: current_mode = Mode.MAP; code_editor.visible = false
		if e.keycode == KEY_F4: _compile()
		if e.keycode == KEY_S: save_cart()
		if e.keycode >= KEY_0 and e.keycode <= KEY_9: brush_col = e.keycode - KEY_0
		# Клавиши редактора (НЕ должны работать в игре F4)
		if current_mode != Mode.GAME:
			if e.keycode == KEY_S: save_cart()
			# Твоя проблемная кнопка Q:
			if e.keycode == KEY_Q: 
				OS.shell_open(ProjectSettings.globalize_path("user://"))



func sfx(f, d):
	var s = 22050.0
	var fr = int(d * s)
	var da = PackedByteArray()
	da.resize(fr)
	for i in range(fr):
		da[i] = 160 if fmod(i * f / s, 1.0) < 0.5 else 100
	var st = AudioStreamWAV.new()
	st.data = da
	st.format = AudioStreamWAV.FORMAT_8_BITS
	st.mix_rate = int(s)
	audio.stream = st
	audio.play()

func _title_editor():
	var m = display.get_local_mouse_position()/(display.size/128.0)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if m.x >= 0 and m.x < 128 and m.y >= 0 and m.y < 128: 
			sprites[int(m.y) * 128 + int(m.x)] = brush_col
	
	cam_x = 0
	# Копируем рисунки с проверкой на прозрачность
	for i in range(16384): 
		vram[i] = sprites[i] if sprites[i] != 0 else 1
	
	# 1. ЗОНА ТАЙЛОВ (Нижняя половина)
	# range(0, 128) не включает 128, так что ошибки не будет
	for i in range(0, 128, 8):
		for j in range(64, 128):
			if vram[j * 128 + i] == 1: pset(i, j, 5)
	for j in range(64, 128, 8):
		for i in range(128):
			if vram[j * 128 + i] == 1: pset(i, j, 5)

	# 2. ЗОНА АНИМАЦИИ (Верхняя половина)
	for i in range(0, 128, 32):
		for j in range(0, 64):
			if vram[j * 128 + i] == 1: pset(i, j, 10)
	for j in range(0, 64, 32):
		for i in range(128):
			if vram[j * 128 + i] == 1: pset(i, j, 10)

	# 3. ГЛАВНЫЙ РАЗДЕЛИТЕЛЬ
	for i in range(128):
		pset(i, 64, 8)

	# КУРСОР
	var cur_size = 32 if m.y < 64 else 8
	var cx = int(clamp(m.x / cur_size, 0, 127 / cur_size)) * cur_size
	var cy = int(clamp(m.y / cur_size, 0, 127 / cur_size)) * cur_size
	rectb(cx, cy, cur_size, cur_size, 7)
			
	# ИНДИКАТОР ЦВЕТА
	rect(120, 120, 8, 8, brush_col)

func _map_editor():
	if Input.is_key_pressed(KEY_E): 
		brush_col = clampi(brush_col + 16, 0, 255)
	if Input.is_key_pressed(KEY_R): 
		brush_col = clampi(brush_col - 16, 0, 255)
	var m = get_local_mouse_position() 
	var mx = int(m.x / (size.x / 128.0))
	var my = int(m.y / (size.y / 128.0))
	
	# Плавная прокрутка на стрелках
	if Input.is_key_pressed(KEY_RIGHT): cam_x = clampi(cam_x + 2, 0, 128*8 - 128)
	if Input.is_key_pressed(KEY_LEFT): cam_x = clampi(cam_x - 2, 0, 128*8 - 128)
	
	# Выбор тайлов 1-9 (спрайты из первой строки F2)
	for i in range(1, 10):
		if Input.is_key_pressed(48 + i): brush_col = i

	# РИСОВАНИЕ
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var tx = (mx + cam_x) / 8
		var ty = my / 8
		if tx >= 0 and tx < 128 and ty >= 0 and ty < 16:
			map_data[ty * 128 + tx] = brush_col
			
	# СТИРАНИЕ (Правая кнопка мыши)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var tx = (mx + cam_x) / 8; var ty = my / 8
		if tx >= 0 and tx < 128 and ty >= 0 and ty < 16: map_data[ty * 128 + tx] = 0
			
	cls(1) # Фон редактора
	map_draw() # Рисуем карту
	
	# СЕТКА (рисуем её поверх карты, чтобы видеть клетки)
	for i in range(0, 128, 8):
		for j in range(0, 128, 8): pset(i, j, 5) 

	# ПРЕВЬЮ ВЫБРАННОГО ТАЙЛА (в левом верхнем углу)
	rect(0, 0, 12, 12, 0)
	sspr((brush_col % 16) * 8, (brush_col / 16) * 8, 2, 2, 8, 8)

func save_cart():
	var d = {"map":Array(map_data),"sprites":Array(sprites),"code":code_editor.text}
	var f = FileAccess.open("user://knight.sav", FileAccess.WRITE)
	f.store_var(d)

func load_cart():
	if FileAccess.file_exists("user://knight.sav"):
		var f = FileAccess.open("user://knight.sav", FileAccess.READ)
		var d = f.get_var()
		map_data = PackedByteArray(d["map"]); sprites = PackedByteArray(d["sprites"]); player_code_text = d["code"]
		code_editor.text = player_code_text
