.MODEL SMALL

.DATA
N1 DW 0FF23H, 0FF54H ; 32-bit number (low, high)
N2 DW 0F123H         ; 16-bit number
N3 DW 3 DUP(0)       ; 48-bit result initialized to 0

.CODE
MOV AX, @DATA
MOV DS, AX           ; Initialize data segment

; Multiply N2 by low part of N1
MOV AX, N2
MUL WORD PTR [N1]    ; AX * N1(low) -> DX:AX
MOV WORD PTR [N3], AX ; Store low word in N3
MOV WORD PTR [N3+2], DX ; Store high word in N3+2

; Multiply N2 by high part of N1
MOV AX, N2
MUL WORD PTR [N1+2]  ; AX * N1(high) -> DX:AX
ADD WORD PTR [N3+2], AX ; Add to N3+2 (middle part)
ADC WORD PTR [N3+4], DX ; Add carry to N3+4 (high part)

HLT
            ; DX:AX = AX * BX
    MOV WORD PTR PRODUCT, AX     ; Store lower 16 bits of product in PRODUCT
    MOV CX, DX                   ; Store upper 16 bits of the partial result
    
    ; Load upper 16 bits of NUMBER into AX
    MOV AX, WORD PTR NUMBER+2    ; AX = upper 16 bits of NUMBER (1234H)
    
    ; Multiply upper 16 bits of NUMBER by MULTIPLIER
    MUL BX                      ; DX:AX = AX * BX
    ADD CX, AX                  ; Add lower 16 bits of this result to CX
    MOV WORD PTR PRODUCT+2, CX   ; Store higher 16 bits of product in PRODUCT+2
    MOV EXTRA, DX                ; Store any overflow into EXTRA
    
    ; Exit the program
    MOV AH, 4CH
    INT 21H

END START
into AX
    MOV BX, WORD PTR NUM2   ; Load lower 16 bits of NUM2 into BX
    MUL BX                  ; Multiply AX by BX
    ADD CX, AX              ; Add result to CX (upper 16 bits from first cross-product)
    ADC DX, 0               ; Add carry if there's overflow
    
    ; Handle upper 16 bits of NUM1 * upper 16 bits of NUM2
    MOV AX, WORD PTR NUM1+2 ; Load upper 16 bits of NUM1 into AX
    MOV BX, WORD PTR NUM2+2 ; Load upper 16 bits of NUM2 into BX
    MUL BX                  ; Multiply AX by BX
    ADD DX, AX              ; Add result to DX (upper part of final result)
    
    ; At this point, the result in CX:DX holds the upper 32 bits, 
    ; and RESULT contains the lower 32 bits of the final 64-bit result.
    
    ; For simplicity, we are only storing the lower 32 bits in RESULT.
    MOV WORD PTR RESULT+2, CX ; Store upper 16 bits of the lower 32 bits in RESULT+2

    ; Program end
    MOV AH, 4CH               ; DOS terminate program function
    INT 21H

END START

