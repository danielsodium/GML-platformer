// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function screen_shake(_mag, _frames) {
	with(oCamera) {
		if (_mag > shake_remain) {
			shake_magnitude = _mag;
			shake_remain = _mag;
			shake_length = _frames;
		}
	}
}