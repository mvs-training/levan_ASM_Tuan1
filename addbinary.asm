.model small
.stack 100
.data 
    TBao db 'Go vao 1 so he 2 ',13,10,'$'
    TB DB 13,10,'HIEN$'
    SO1 DW ?
    SO2 DW ? 
    SUM DW ?
.code                                              
MAIN Proc
    MOV AX,@DATA
    MOV DS,AX 
    
    LEA DX,TBao
    CALL THBAO
    XOR BX,BX     ; BX luu so nhap vao
    CALL Nhapso
    MOV SO1,BX    ;dua BX vao SO1  
    
    LEA DX,TBao
    CALL THBAO    
    XOR BX,BX
    CALL Nhapso
    MOV SO2,BX    ; dua BX vao SO2  
    
    CALL Add2bin  ; Cong SO1 , SO2 
    
    MOV AH,4CH    ; ve DOS
    INT 21H
MAIN Endp

Nhapso Proc 
       
TIEP: MOV AH,1    
    INT 21H
    CMP AL,13     ; neu nhan ENTER
    JE THOIDOC     ;thi thoat ra
    SUB AL,30H    ; dua ve dang nhi phan
    SHL BX,1       ; dich trai BX 1 bit 
    OR BL,AL       ; dua bit nhap vao vao BX
    JMP TIEP 
    RET 
    
THOIDOC: RET
   
Nhapso ENDP


THBAO PROC
    MOV AH,9
    INT 21H
    RET
THBAO ENDP 

Add2bin PROC
    MOV AX,SO1
    ADD AX,SO2  
    MOV SUM,AX
    MOV CX,16
    MOV AH,2 
    MOV BX,SUM
HIEN: XOR DL,DL
    ROL BX,1      ; Dua MSB ra CF
    ADC DL,30H    ; chuyem MSB sang ASCII luu trong DL
    INT 21H
    LOOP HIEN
    
    RET
Add2bin ENDP
    END MAIN