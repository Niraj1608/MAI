.MODEL SMALL
.STACK 100H

.DATA
    NUM1 DB 05H
    NUM2 DB 10H
    RESULT DB ? 
    BORROW DB ?
    
    
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AL, NUM1
    SUB AL, NUM2
    JNC STORE_RESULT
    
    NEG AL    
    MOV BORROW, 1
    
    STORE_RESULT:
        MOV RESULT, AL
        
    MOV AH, 4CH
    INT 21H
    
END START     