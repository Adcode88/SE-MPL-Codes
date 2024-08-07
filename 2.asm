section .data
msg1 db 10,13,"Enter your string: "
len1 equ $-msg1

msg2 db 10,13,"Length of string is: "
len2 equ $-msg2

msg3 db 10,13,""
len3 equ $-msg3

section .bss
input resb 200
output resb 200


section .text
global _start

_start:
	mov rax, 1
	mov rdi, 1
	mov rsi, msg1
	mov rdx, len1
	syscall

	mov rax, 0
	mov rdi, 0
	mov rsi, input
	mov rdx, 200
	syscall
	
	mov rbx, rax
	dec rbx
	mov rdi, output
	mov cx, 16

up:
	rol rbx, 4
	mov al, bl
	and al, 0fh
	cmp al, 09h
	jg add37
	add al, 30h
	jmp skip

add37:
	add al, 37h

skip:
	mov [rdi], al
	inc rdi
	dec cx
	jnz up

mov rax, 1
mov rdi, 1
mov rsi, msg2
mov rdx, len2
syscall
	 
mov rax, 1
mov rdi, 1
mov rsi, output
mov rdx, 16
syscall

mov rax, 1
mov rdi, 1
mov rsi, msg3
mov rdx, len3
syscall

mov rax ,60
mov rdi,0
syscall
