section .data
	msg1 db 10,13, "Enter 5 Numbers:"
	len1 equ $-msg1
	msg2 db 10,13, "5 Numbers Are:"
	len2 equ $-msg2

section .bss
	array resd 200
	counter resb 1

section .text
	global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, msg1
	mov rdx, len1
	syscall

	mov byte[counter],5
	mov rbx, 0

accept:
	mov rax, 0
	mov rdi, 0
	mov rsi, array
	add rsi, rbx
	mov rdx, 17
	syscall
	add rbx, 17
	dec byte[counter]
	jnz accept

 mov rax, 1
 mov rdi, 1
 mov rsi, msg2
 mov rdx, len2
 syscall

mov byte[counter], 5
mov rbx, 0

	display:
		mov rax, 1
		mov rdi, 1
		mov rsi, array
		add rsi, rbx
		mov rdx, 17
		syscall
		add rbx, 17
		dec byte[counter]
		jnz display

mov rax, 60
mov rdi, 0
syscall