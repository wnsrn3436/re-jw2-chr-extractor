var __nchar;

__nchar = ord(argument3);
if ((__nchar >> 7) = 1) {
 if (__nchar = $a4)
  __nchar = ((__nchar - $a4) * 94) + (ord(string_char_at(argument3, 2)) - $a1);
 else
  __nchar = ((__nchar - $b0) * 94) + (ord(string_char_at(argument3, 2)) - $6e);
 if (__nchar >= 0)
  draw_sprite_part_ext(global.__sexfont, (__nchar & $f00) >> 8, (__nchar & $f) * global.__sexwidth[1], ((__nchar& $f0) >> 4) * global.__sexheight, global.__sexwidth[1], global.__sexheight, argument0, argument1, 1, 1, argument2, 1);
 return 1;
} else {
  draw_sprite_part_ext(global.__sexfont, 10, (__nchar & $f) * global.__sexwidth[0], ((__nchar & $f0) >> 4) * global.__sexheight, global.__sexwidth[0], global.__sexheight, argument0, argument1, 1, 1, argument2, 1);
 return 0;
}
