; To multiply two numbers

.MODEL SMALL
.STACK 100H

.DATA
    NUM1 DB 15H
    NUM2 DB 10H
    RESULT DW ?
    
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AL, NUM1
    MOV BL, NUM2
    
    MUL BL
    
    MOV RESULT, AX
    
    MOV AH, 4CH
    INT 21H
    
END START