.MODEL SMALL
.STACK 100H

.DATA
    nWords EQU 5
    arr DW 5000, 10000, 15000, 20000, 25000
    divisor DW 1002
    quotient DW nWords DUP(0)
    remainder DW nWords DUP(0)

.CODE
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, nWords
    LEA SI, arr
    LEA DI, quotient
    LEA BX, remainder

START_LOOP:
    MOV AX, [SI]
    MOV DX, 0              ; Clear DX before division to ensure a 32-bit dividend

    MOV AX, [SI]           ; Load the current word from the array into AX
    DIV divisor             ; Divide AX by divisor, quotient in AX, remainder in DX

    MOV [DI], AX           ; Store the quotient in the quotient array
    MOV [BX], DX           ; Store the remainder in the remainder array

    ADD SI, 2              ; Move to the next word in the input array
    ADD DI, 2              ; Move to the next word in the quotient array
    ADD BX, 2              ; Move to the next word in the remainder array
    LOOP START_LOOP

    MOV AH, 4CH
    INT 21H

END
    DIV DX                     ; Divide DX:AX by the divisor (16-bit by 16-bit), quotient in AX, remainder in DX

    MOV [DI], AX               ; Store the quotient (AX) in the quotient array
    MOV [BX], DX               ; Store the remainder (DX) in the remainder array

    ADD SI, 2                  ; Move to the next word in the input array
    ADD DI, 2                  ; Move to the next word in the quotient array
    ADD BX, 2                  ; Move to the next word in the remainder array
    LOOP START_LOOP            ; Repeat for all words in the array

    ; Program exit
    MOV AH, 4CH
    INT 21H

END
