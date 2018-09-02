.MODEL SMALL
.stack 100
.data
     MS Db  'Nhap vao so thap phan:',13,10 ,'$'
     
     So  DW ?
     S1 DW ?
     s2 dw ?

.code 
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    XOR BX,BX
    ; Nhap so thu nhat
    mov ah,9
    LEA DX,MS
    INT 21H
    CALL DecInput
    
    MOV S1,BX 
    XOR BX,BX
    ;nhap so thu 2
    mov ah,9
    LEA DX,MS
    INT 21H
    CALL DecInput
    MOV S2,BX
    
    ;cong 2 so
    MOV AX,S1
    ADD AX,S2 
    ;hien thi so o danh thap phan
    
    CALL DecOutput
    
    
mov ax, 4c00h
int 21h  

MAIN Endp

DecOutput PROC  
    ; Tong duoc luu trong AX
    XOR CX,CX   ; CX dem so chu so
    
CHIA:  
    MOV BX,10
    DIV BX        ; Chia AX cho 10, phan du luu trong DX
    PUSH DX
    XOR DX,DX      ; Cat DX vao stack
    INC CX         ; tang CX 
    CMP AX,0       ; neu phan thuong = 0 thi thoi
    JNE CHIA
    
    MOV AH,2
    
HIEN:
    POP Dx        ; Lay ra tu DX va hien
    ADD DX,30H
    INT 21H
    LOOP HIEN
    
    RET
DecOutput  ENDP


DecInput PROC 
    ;BX CHUA SO THAP PHAN
    NHAP: 
    MOV AH,1
    INT 21H 
    CMP AL,13  ; neu nhan enter thi dung 
    JE DUNG  
    CMP AL,30H ;
    JL KHONGPHAISO
    CMP AL,39H
    JG KHONGPHAISO
    
    SUB AL,30H  ; CHUYEN ASCII VE SO
    XOR AH,AH   ; CHUYEN AH VE 0 DE THUC HIEN PHEP NHAN 16BIT
    PUSH AX     ; CAT SO VUA NHAP VAO STACK
    MOV AX,10   ; NHAN SO NHAP VAO VS 10
    MUL BX      ;KET QUA LUA TRONG AX
    MOV BX,AX   ; CHUYEN KQ VE BX
    POP AX
    ADD BX,AX   ; CONG VOI SO VUA NHAP
    JMP NHAP
    RET  
    
    KHONGPHAISO:
    
    XOR BX,BX
    JMP NHAP   
    
    DUNG:
    MOV So,BX   ; luu BX vao bien So
    RET
       
DecInput ENDP

