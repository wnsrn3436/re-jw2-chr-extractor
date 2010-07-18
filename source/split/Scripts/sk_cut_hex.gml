//hex를 2글자씩 잘라냄

var num1, length, total;

num1=argument0
length=string_length(num1)
total=""

if length=0{total="00"}

for(j=0; length>0; j+=1)
{

if length!=1
{
stringeses=string_copy(num1, length-1, length)
num1=string_delete(num1, length-1, length)
length=string_length(num1)
}
else{stringeses=string_copy(num1, length-1, length); stringeses="0"+stringeses; length=0}

stringsrfg[j]=sk_dec_conversion(stringeses)
//원본------x

total+=stringeses
}

return(total);

// sk_cut_hex(hex값)
