// SEX의 폰트를 추가하는 부분

switch (argument0) {
 case 0:
  global.__sexfont = spr_kor1;
  global.__sexwidth[0] = 8;
  global.__sexwidth[1] = 16;
  global.__sexheight = 16;
  break;
 case 1:
  global.__sexfont = spr_kor2;
  global.__sexwidth[0] = 6;
  global.__sexwidth[1] = 12;
  global.__sexheight = 12;
  break;
}

// sk_sex_set_font(폰트번호)
