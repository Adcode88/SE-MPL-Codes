; Write x86 ALP to find the factorial of a given integer number on a command line
; by using recursion.
; Explicit stack manipulation is expected in the code.
;------------------------------ .data section—--------------------------------------
section .data
    msgno: db 'Number is:', 0xa
    msgnoSize: equ $ - msgno
    msgfact: db 'Factorial is:', 0xa
    msgfactSize: equ $ - msgfact
    newLine: db 10
;------------------------------ .bss section--------------------------------------
section .bss
    fact: resb 8
    num: resb 2
;------------------------------ define macro for print and stop------------------------------
%macro Print 2
    mov rax, 1          ; syscall for sys_write
    mov rdi, 1          ; file descriptor 1 (stdout)
    mov rsi, %1         ; pointer to the message
    mov rdx, %2         ; message length
    syscall
%endmacro

%macro Stop 0
    mov rax, 60         ; syscall for sys_exit
    xor rdi, rdi        ; exit status 0
    syscall
%endmacro

;------------------------------ .text section—--------------------------------------
section .text
global _start

_start:
    pop rbx             ; Remove number of arguments from stack
    pop rbx             ; Remove the program name from stack
    pop rbx             ; Remove the actual number whose factorial is to be calculated (Address of number) from stack
    mov [num], rbx      ; Store the number in num

    Print msgno, msgnoSize
    Print [num], 4      ; Print the number accepted from the command line

    mov rsi, [num]      ; Point rsi to num
    mov rcx, 2          ; Load number of digits to display
    xor rbx, rbx        ; Clear rbx (counter)
    call aToH           ; Convert ASCII to Hex
    mov rax, rbx        ; Store the number in rax

    call factP          ; Call factorial procedure

    mov rcx, 8          ; Load number of digits to display
    mov rdi, fact       ; Point rdi to fact
    xor bx, bx          ; Clear bx
    mov ebx, eax        ; Move result to ebx
    call hToA           ; Convert Hex to ASCII
    Print newLine, 10

    Print msgfact, msgfactSize  ; Print the message "Factorial is"
    Print fact, 8                ; Print the factorial
    Print newLine, 10
    Stop                          ; Exit program

;************ Recursive Factorial Procedure *****************
factP:
    dec rbx
    cmp rbx, 1
    je b1
    cmp rbx, 0
    je b1
    mul rbx
    call factP
b1:
    ret

;********************* Ascii Hex to Hex ******************
aToH:
    up1:
        rol bx, 4       ; Rotate number left by four bits
        mov al, [rsi]   ; Move ASCII character to AL
        cmp al, 39H     ; Compare with '9'
        jbe A2          ; Jump if below or equal to '9'
        sub al, 07H     ; Adjust for A-F
    A2:
        sub al, 30H     ; Convert ASCII to hex
        add bl, al
        inc rsi
        loop up1
    ret

;********************* Hex to Ascii Hex ******************
hToA:
    next1:
        rol ebx, 4          ; Rotate number left by four bits
        mov ax, bx          ; Move contents of bx to ax
        and ax, 0FH         ; Mask the lower 4 bits
        cmp ax, 09H         ; Compare with 9
        jbe p1              ; Jump if below or equal to 9
        add ax, 07H         ; Adjust for A-F
    p1:
        add ax, 30H         ; Convert to ASCII
        mov [rdi], ax       ; Store the ASCII character
        inc rdi             ; Move to the next position
        loop next1          ; Continue loop if count is not zero
    ret
