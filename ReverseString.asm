data segment
     MSG DB 'Nhap vao chuoi: ' ,13,10,'$' 
     M2 db 'Chuoi sau khi dao nguoc: ',13,10,'$'
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
    MOV AX,@DATA
    MOV DS,AX
    XOR CX,CX   
    MOV AH,9
    LEA DX,MSG
    INT 21H
NHAP: MOV AH,1
    INT 21H
    CMP AL,13
    JE DUNG
    PUSH AX      ; cat vao ngan xep
    INC CX
    JMP NHAP
DUNG:
    mov ah,9
    lea dx,m2
    int 21h
    
Hien:POP dx       ; dua ra khoi ngan xep va hien thi
    MOV AH,2
    INT 21H
    LOOP Hien
    
    ; add your code here

mov ax, 4c00h
int 21h  

ends

end start
