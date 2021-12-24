heightsToGet = sprite_get_width(sCollisionTile)
tiles = heightsToGet / TILESIZE;

var layerid = layer_create(0, "Tiles");
tilemapid = layer_tilemap_create(layerid, 0,0,tCollision,tiles, 1);
for (var i = 0; i <= tiles; i++) {
	tilemap_set(tilemapid, i, i, 0);
}