.MODEL SMALL
.STACK 100H

.DATA
    NUM1 DD 12345678H   ; First 32-bit number
    NUM2 DD 87654321H   ; Second 32-bit number
    RESULT DD ?         ; To store the 32-bit result (64 bits in case of overflow)
    
.CODE
START:
    MOV AX, @DATA       ; Initialize the data segment
    MOV DS, AX

    ; Load lower 16 bits of NUM1 and NUM2
    MOV AX, WORD PTR NUM1     ; Load lower 16 bits of NUM1 into AX
    MOV DX, WORD PTR NUM2     ; Load lower 16 bits of NUM2 into DX
    ADD AX, DX                ; Add the lower 16 bits

    MOV WORD PTR RESULT, AX   ; Store the result of the lower 16 bits in RESULT

    ; Load higher 16 bits of NUM1 and NUM2
    MOV AX, WORD PTR NUM1+2   ; Load higher 16 bits of NUM1 into AX
    MOV DX, WORD PTR NUM2+2   ; Load higher 16 bits of NUM2 into DX
    ADC AX, DX                ; Add the higher 16 bits, including the carry from the lower bits

    MOV WORD PTR RESULT+2, AX ; Store the result of the higher 16 bits in RESULT

    ; Program end
    MOV AH, 4CH               ; DOS terminate program function
    INT 21H

END START
