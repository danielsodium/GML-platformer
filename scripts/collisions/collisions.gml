
function calc_grv(mass) {
	return floor(0.981 * mass);
}

function calc_coll(grounded) {
	var bbox_side;
	var p1;
	var p2;
	
	if (hsp >= 0) bbox_side = bbox_right;
	else bbox_side = bbox_left;
	p1 = tilemap_get_at_pixel(collisionTiles, bbox_side + hsp, bbox_top);
	p2 = tilemap_get_at_pixel(collisionTiles, bbox_side + hsp, bbox_bottom);
	if (tilemap_get_at_pixel(collisionTiles, x, bbox_bottom) > 1) p2 = 0; // ignore bottom side tiles if slope
	// Horizontal Collision
	if ((p1 == 1) || (p2 == 1)) {
		if (hsp > 0) x = x - (x mod TILESIZE) + (TILESIZE-1) - (bbox_right - x);
		else x = x - (x mod TILESIZE) - (bbox_left - x);
		hsp = 0;
	}
	x += hsp;	
	
	
	
	// Vertical Collision
	
	if (bbox_bottom + vsp >= room_height) {
		y = room_height - TILESIZE;
		vsp = 0;
	}
	
	if (tilemap_get_at_pixel(collisionTiles,x, bbox_bottom + vsp) <= 1) {
		if (vsp >= 0) bbox_side = bbox_bottom;
		else bbox_side = bbox_top;
		p1 = tilemap_get_at_pixel(collisionTiles, bbox_left, bbox_side + vsp)
		p2 = tilemap_get_at_pixel(collisionTiles, bbox_right, bbox_side + vsp)
		if ((p1 == 1) || (p2 == 1)) {
			if (vsp >= 0) {
				y = y - (bbox_bottom mod TILESIZE) + (TILESIZE-1)
			
				vsp = 0;
			}
			else {
				y = y - (y mod TILESIZE) - (bbox_top - y);
				vsp = 0;
			}
			
		}
	}
	
	
	
	var floorDist = in_floor(collisionTiles,x, bbox_bottom+vsp);
	if (floorDist >= 0) {
		y += vsp;
		y -= floorDist + 1;
		vsp = 0;
		floorDist = -1;
	}

	y += vsp;
	
	// Just landed
	
	if (!(grounded)) {
		
		if (in_floor(collisionTiles, x, bbox_bottom + 1) >= 0) {
			//for (var i =0; i < 5; i++) instance_create_layer(x, bbox_bottom, "Particles", oDust);
			stretch_y = 0.75;
			stretch_x = 1.25;
		}
	}
	
	// Walk down slopes
	if (grounded) {		
		stretch_x = 1;
		stretch_y = 1;
		y += abs(floorDist) - 1;
		
		// if at base of current tile
		if ((bbox_bottom mod TILESIZE) == TILESIZE - 1) {
			if (tilemap_get_at_pixel(collisionTiles,x, bbox_bottom+1) > 1) {
				y += abs(in_floor(collisionTiles,x, bbox_bottom+1));
			}
		}
	}
}

/// @desc checks to see if given pixel is below floor height of tile and returns how deep in floor
/// @arg tilemap
/// @arg x
/// @arg y

function in_floor(tilemap, x, y) {
	var pos = tilemap_get_at_pixel(tilemap, x, y)
	
	if (pos > 0) {
		if (pos == 1) return y mod TILESIZE;
		var theFloor = global.heights[(x mod TILESIZE) + (pos * TILESIZE)]
		return (y mod TILESIZE) - theFloor
	}
	else return -(TILESIZE - (y mod TILESIZE));
	
}
