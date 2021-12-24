
keyLeft = keyboard_check(ord("A")) || keyboard_check(vk_left);
keyRight = keyboard_check(ord("D")) || keyboard_check(vk_right);
keyJump = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
keyJumpHeld = keyboard_check(vk_space) || keyboard_check(ord("W")) || keyboard_check(vk_up);
keyDown = keyboard_check(ord("S")) || keyboard_check(vk_control) || keyboard_check(vk_down);


if (keyLeft || keyRight || keyJump) {
	controller = 0;
}

// gamepad
if (global.gamepad != -1) {

	// if stick beyond deadzone
	if (abs(gamepad_axis_value(global.gamepad,gp_axislh)) > 0.2) {
		keyLeft = abs(min(gamepad_axis_value(global.gamepad, gp_axislh), 0));
		keyRight = max(gamepad_axis_value(global.gamepad, gp_axislh), 0);
		controller = 1;
	}
	if (abs(gamepad_axis_value(global.gamepad,gp_axislv)) > 0.2) {
		keyDown = abs(min(gamepad_axis_value(global.gamepad, gp_axislv), 0));
		controller = 1;
	}
	if (gamepad_button_check_pressed(global.gamepad,gp_face3)) {
		keyJump = 1;
		controller = 1;
	}

	if (gamepad_button_check(global.gamepad,gp_face3)) {
		keyJumpHeld = 1;
		controller = 1;
	}
}


// Movement

var move = keyRight - keyLeft;
hsp = move * walksp;
vsp += grv;

// is center touching the floor at the start of frame
var grounded = (in_floor(collisionTiles, x, bbox_bottom + 1) >= 0);


if (grounded || in_floor(collisionTiles, bbox_left, bbox_bottom + 1) >= 0 || in_floor(collisionTiles, bbox_right, bbox_bottom + 1) >= 0) {
	if (keyJump || keyJumpHeld) {
		vsp = -10;
		stretch_x = 0.75;
		stretch_y = 1.5
		grounded = false;
	}
}

if (vsp < 0 && !keyJumpHeld) {
	vsp += grv;
}

// Fractional movement

hsp += hsp_fraction;
vsp += vsp_fraction;

hsp_fraction = hsp - (floor(abs(hsp)) * sign(hsp));
hsp -= hsp_fraction;
vsp_fraction = vsp - (floor(abs(vsp)) * sign(vsp));
vsp -= vsp_fraction;


calc_coll(grounded, keyDown)


if (hsp != 0 && grounded) image_index = 1;
else image_index = 0;

if (hsp != 0) image_xscale = sign(hsp);

stretch_x = lerp(stretch_x, 1, .1);
stretch_y = lerp(stretch_y, 1, .1);