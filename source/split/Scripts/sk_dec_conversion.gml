//헥스를 숫자값으로 변환함

var num1, length, total, va1;

num1=argument0
while(string_copy(num1, 0, 1)="0"){num1=string_delete(num1, 1, 1)}

length=string_length(num1)
total=0

for(e=0; e!=length; e+=1)
{
va1=1
stringeses=string_copy(num1, 0, 1)
num1=string_delete(num1, 1, 1)

if stringeses="A"{stringeses="10"}
if stringeses="B"{stringeses="11"}
if stringeses="C"{stringeses="12"}
if stringeses="D"{stringeses="13"}
if stringeses="E"{stringeses="14"}
if stringeses="F"{stringeses="15"}

if length-e-2>=0{for(k=0; k!=length-e-2; k+=1){va1=va1*16}}

if e+1!=length{total+=16*va1*real(stringeses)}
else{total+=real(stringeses)}
}

return(string(total));

// sk_dec_conversion(변환할 16진수문자열)
