; to do division between two values

.MODEL SMALL
.STACK 100H

.DATA
    NUM1 DB 11H
    NUM2 DB 02H         
    QUOTIENT DB ?
    REMAINDER DB ?
    
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AL, NUM1
    Mov BL, NUM2  
    
    XOR AH, AH
    
    DIV BL
    
    MOV QUOTIENT, AL
    MOV REMAINDER, AH
    
    MOV AH, 4CH
    INT 21H
    
END START