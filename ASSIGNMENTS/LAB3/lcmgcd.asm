.MODEL SMALL
.STACK 100H

.DATA
    num1 DW 15                   ; First 16-bit number (example: 15)
    num2 DW 10                   ; Second 16-bit number (example: 10)
    gcd DW 0                     ; To store GCD
    lcm DW 0                     ; To store LCM

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX                   ; Initialize the data segment

    ; Calculate GCD using Euclidean algorithm
    MOV AX, num1                 ; Load num1 into AX
    MOV BX, num2                 ; Load num2 into BX

GCD_LOOP:
    CMP BX, 0                    ; Check if BX is 0
    JE GCD_DONE                  ; If BX is 0, GCD is in AX
    XOR DX, DX                   ; Clear DX for DIV operation
    DIV BX                       ; AX = AX / BX, DX = AX % BX
    MOV AX, BX                   ; Set AX = previous BX (next iteration)
    MOV BX, DX                   ; Set BX = remainder
    JMP GCD_LOOP                 ; Repeat the loop

GCD_DONE:
    MOV gcd, AX                  ; Store the GCD

    ; Calculate LCM
    MOV AX, num1                 ; Load num1 into AX
    MUL num2                     ; Multiply AX by num2
    MOV BX, gcd                  ; Load GCD into BX
    DIV BX                       ; Divide the product by GCD to get LCM
    MOV lcm, AX                  ; Store the LCM

    ; Program exit
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
