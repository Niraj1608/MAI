; interchange the values of two variables
.MODEL SMALL
.STACK 100H

.DATA
    VAR1 DB 10H
    VAR2 DB 09H
    TEMP DB ?
    
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AL, VAR1
    MOV TEMP, AL
    
    MOV AL, VAR2
    MOV VAR1, AL
    
    MOV AL, TEMP
    MOV VAR2, AL
    
    MOV AH, 4CH
    INT 21H
    
END START