extends Node

# -------------------------------------------------------------------------------------------------
const POINT_ELEM_SIZE = 3
const MAX_PRESSURE_VALUE = 65535
# const COMPRESSION_METHOD = File.COMPRESSION_DEFLATE

# -------------------------------------------------------------------------------------------------
func save_file(file_path: String, line_2d_array: Array) -> void:
	var start_time := Time.get_ticks_msec()
	
	# open file
	# var file := File.new()
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	var err = FileAccess.open_compressed(file_path, FileAccess.WRITE, FileAccess.COMPRESSION_DEFLATE)
	if err != OK:
		printerr("Failed to open file for writing: %s" % file_path)
		return
	
	# write
	_write_to_binary_file(file, line_2d_array)
	file.close()
	
	print("File saved in %d ms" % (Time.get_ticks_msec() - start_time))
	
# -------------------------------------------------------------------------------------------------
func load_file(file_path: String) -> Array:
	var start_time := Time.get_ticks_msec()
		
	# open file
	var file = FileAccess.open(file_path, FileAccess.READ)
	var err = FileAccess.open_compressed(file_path, FileAccess.READ, FileAccess.COMPRESSION_DEFLATE)
	# var file := File.new()
	# var err = file.open_compressed(file_path, File.READ, COMPRESSION_METHOD)
	if err != OK:
		printerr("Failed to load file: %s" % file_path)
		return []
	
	# parse
	var result: Array = _read_from_binary_file(file)
	file.close()
	
	print("Loaded %s in %d ms" % [file_path, (Time.get_ticks_msec() - start_time)])
	return result

# -------------------------------------------------------------------------------------------------
func _write_to_binary_file(file: FileAccess, strokes: Array) -> void:
	for stroke in strokes:
		# color
		file.store_8(stroke.color.r8)
		file.store_8(stroke.color.g8)
		file.store_8(stroke.color.b8)
		
		# brush size
		file.store_8(int(stroke.size))
		
		# number of points
		file.store_16(stroke.points.size())
		
		# points
		var p_idx := 0
		for p in stroke.points:
			file.store_float(p.x)
			file.store_float(p.y)
			file.store_16(stroke.pressures[p_idx])
			p_idx += 1

# -------------------------------------------------------------------------------------------------
# TODO: this needs some error handling!
func _read_from_binary_file(file: FileAccess) -> Array:
	var result := []
	
	while true:
		var brush_stroke := BrushStroke.new()
		
		# color
		var r := file.get_8()
		var g := file.get_8()
		var b := file.get_8()
		brush_stroke.color = Color(r/255.0, g/255.0, b/255.0, 1.0)
		
		# brush size
		brush_stroke.size = file.get_8()
		
		# number of points
		var point_count := file.get_16()

		# points
		for i in point_count:
			var x := file.get_float()
			var y := file.get_float()
			var pressure := file.get_16()
			brush_stroke.points.append(Vector2(x, y))
			brush_stroke.pressures.append(pressure)
		result.append(brush_stroke)
		
		# are we done yet?
		if file.get_position() >= file.get_length()-1 || file.eof_reached():
			break
		
	return result
