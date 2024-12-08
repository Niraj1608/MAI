.MODEL SMALL
.STACK 100H

.DATA
    NUM1 DB 15H
    NUM2 DB 10H
    RESULT DB ?
    
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AL, NUM1
    ADD AL, NUM2
    
    MOV RESULT, AL
    
    MOV AH, 4CH
    INT 21H
    
END START     