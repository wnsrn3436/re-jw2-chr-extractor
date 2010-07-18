//정보로드

file_bin_seek(argument2, argument1)
for(v=argument3-1; v!=-1; v-=1)
{
file_bin_seek(argument2, argument1+v)

variable_local_set(argument0, variable_local_get(argument0)+sk_hex_conversion(file_bin_read_byte(argument2)))
}
variable_local_set(argument0, sk_dec_conversion(variable_local_get(argument0)))

// sk_load_data("변수명", 위치, 파일명, 한번에로드량)
