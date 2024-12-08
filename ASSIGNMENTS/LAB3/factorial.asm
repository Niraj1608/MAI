.MODEL SMALL
.STACK 100H

.DATA
    num DW 5                 ; Store the number whose factorial is to be calculated
    result DW 0, 0           ; To store the result (32-bit: high part in DX, low part in AX)

.CODE
    MOV AX, @DATA
    MOV DS, AX               ; Initialize the data segment

    MOV CX, [num]            ; Load the number into CX
    MOV AX, 1                ; Initialize result to 1 in AX
    MOV DX, 0                ; Clear DX for the multiplication

FACTORIAL_LOOP:
    CMP CX, 1                ; Check if CX is less than or equal to 1
    JBE DONE                 ; If CX <= 1, exit the loop

    MUL CX                   ; AX = AX * CX, DX = 0 (lower part of result is in AX)
    DEC CX                   ; Decrement CX
    JMP FACTORIAL_LOOP       ; Repeat the loop

DONE:
    MOV [result], AX         ; Store the low part of the result
    MOV [result + 2], DX     ; Store the high part of the result

    MOV AH, 4CH              ; Exit program
    INT 21H

END
  ; Program exit
    MOV AH, 4CH
    INT 21H

END
