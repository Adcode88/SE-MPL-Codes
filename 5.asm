%macro write 2
mov rax, 1
mov rdi, 1
mov rsi, %1
mov rdx, %2
syscall
%endmacro

section .data
msg1 db "Count of Positive numbers:"
len1 equ $-msg1

msg2 db "Count of negative numbers:"
len2 equ $-msg2

msg3 db 10, 13, ""
len3 equ $-msg3

array db 10,12,-21,-12,-19,-34,41

section .bss
count resb 2
pcount resb 2
ncount resb 2
totalcount resb 2

section .text
global _start

_start:

mov byte[count], 7
mov byte[pcount], 0
mov byte[ncount], 0

mov rsi, array

up:
	mov al, 0
	add al, [rsi]
	js neg
	inc byte[pcount]
	jmp down
	
neg:
	inc byte[ncount]

down:
	inc rsi
	dec byte[count]
	jnz up

d:
	write msg1, len1
	mov bh, [pcount]
	call disp

	write msg3, len3

	write msg2, len2
	mov bh, [ncount]
	call disp

	write msg3, len3

	mov rax, 60
	mov rdi, 0
	syscall

disp:
	mov byte[count], 2
	mov bl, bh

loop:
	rol bl, 4
	mov bh, bl
	and bh, 0fh
	cmp bh, 09h
	jg add37
	add bh, 30h
	jmp nxt

add37:
	add bh, 37h

nxt:
	mov [totalcount], bh
	write totalcount, 2
	dec byte[count]
	jnz loop
ret