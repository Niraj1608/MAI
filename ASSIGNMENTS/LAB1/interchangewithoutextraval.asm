; interchange the values of two variables without using extra registers
.MODEL SMALL
.STACK 100H

.DATA
    VAR1 DB 10H
    VAR2 DB 09H
    
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AL, VAR1
    ADD AL, VAR2
    MOV VAR1, AL
    MOV AL, VAR1
    SUB AL, VAR2
    MOV VAR2, AL
    MOV AL, VAR1
    SUB AL, VAR2
    MOV VAR1, AL
    
    MOV AH, 4CH
    INT 21H
    
END START