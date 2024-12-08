.MODEL SMALL
.STACK 100H

.DATA
    NUM1 DD 12345678H
    NUM2 DD 56781234H
    RESULT DD ?

.CODE
START:
  
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AX, WORD PTR NUM1
    MOV DX, WORD PTR NUM2
    SUB AX, DX
    MOV WORD PTR RESULT, AX
    
    MOV AX, WORD PTR NUM1+2
    MOV DX, WORD PTR NUM2+2
    SBB AX, DX
    MOV WORD PTR RESULT+2, AX
    
    JNC EXIT
    
    ; If there was a borrow (negative result), negate the result
    MOV AX, WORD PTR RESULT      ; Negate the lower 16 bits
    NEG AX
    MOV WORD PTR RESULT, AX      ; Store negated lower 16 bits
    
    MOV AX, WORD PTR RESULT+2    ; Negate the higher 16 bits
    NEG AX
    SBB AX, 0                    ; Subtract with borrow to handle the negation
    MOV WORD PTR RESULT+2, AX    ; Store negated higher 16 bits
    
    EXIT:
        MOV AH, 4CH
        INT 21H
END START

