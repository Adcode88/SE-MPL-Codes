section .data
array db 11h,59h,33h,22h,44h

msg1 db 10,13,"**********ALP to find the largest number in an array**********"
len1 equ $-msg1

msg3 db 10,13, "The Largest number in the array is: "
len3 equ $-msg3

msg4 db 10,13, ""
len4 equ $-msg4

section .bss
counter resb 1
result resb 4

%macro write 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .text
global _start

_start:
	write msg1,len1

	mov byte[counter], 5
	mov rsi, array
	mov al, 0

loop:
	cmp al, [rsi]
	jg skip
	xchg al,[rsi]

skip:
	inc rsi
	dec byte[counter]
	jnz loop


mov bl, al
mov rdi, result
mov cx, 2	

display:
	rol bl, 4
	mov al, bl
	and al, 0fh
	cmp al, 09h
	jg add37
	add al, 30h
	jmp next

add37:
	add al, 37h
	
next:
	mov [rdi], al
	inc rdi
	dec cx
	jnz display

write msg3, len3
write result, 2
write msg4, len4

mov rax, 60
mov rdi, 0
syscall