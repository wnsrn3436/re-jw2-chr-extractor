//숫자를 헥스값으로 변환함

var num1, decimal, hexpos, hexlist, sRevReturn, sReturn;

hexlist="0123456789ABCDEF";
sRevReturn="";
sReturn="";
num1=argument0;

if num1=0{sReturn+="0"}
if 16>num1{sReturn+="0"}

while(num1>0)
{
decimal=(num1/16);
num1=floor(decimal);
hexpos=(decimal-num1)*16;
sRevReturn+=string_char_at(hexlist, hexpos+1);
}

for(e=string_length(sRevReturn)+1; e>0; e-=1)
{
sReturn+=string_char_at(sRevReturn, e);
}

return(sReturn);

// sk_hex_conversion(변환할 수치)
