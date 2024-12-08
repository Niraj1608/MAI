.MODEL SMALL
.STACK 100H

.DATA
    num DW 10H                      ; The number to find the cube of (example: 5)
    result DW 0, 0                ; Storage for the 32-bit result (high part in DX, low part in AX)

.CODE
    MOV AX, @DATA
    MOV DS, AX                    ; Initialize the data segment

    ; Load the number (num) into AX for the first multiplication
    MOV AX, num                   ; AX = num (the number we want to cube)
    MUL AX                        ; AX = AX * AX (i.e., AX = num^2), result in DX:AX

    ; Now multiply num^2 by num to get num^3
    MOV BX, AX                    ; Save the current result (num^2) in BX
    MOV AX, num                   ; Load num again in AX for the final multiplication
    MUL BX                        ; AX = AX * BX (i.e., num * num^2), result in DX:AX

    ; Store the result (num^3) in the result variable
    MOV [result], AX              ; Store the low part of the result in result[0] (AX)
    MOV [result+2], DX            ; Store the high part of the result in result[1] (DX)

    ; Program exit
    MOV AH, 4CH
    INT 21H

END
