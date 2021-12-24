function find_gamepad(){
	for (var i = 0; i < 10; i++) {
		if (gamepad_is_connected(i)) {
			return i;
		}
	}
	return -1;
}