.MODEL SMALL
.STACK 100H

.DATA
    nBytes EQU 5               ; Define the number of bytes in the array
    arr DB 10, 20, 30, 40, 50  ; Array of n bytes
    multiplier DB 5            ; 8-bit number to multiply the array by
    result DW nBytes DUP(0)    ; Array to store the 16-bit result for each multiplication

.CODE
    MOV AX, @DATA
    MOV DS, AX                 ; Initialize the data segment

    MOV CX, nBytes             ; Load the number of bytes to process
    LEA SI, arr                ; Load the address of the array in SI
    LEA DI, result             ; Load the address of the result array in DI
    MOV BL, multiplier         ; Load the 8-bit multiplier into BL

START_LOOP:
    MOV AL, [SI]               ; Load current byte from the array into AL
    MUL BL                     ; Multiply AL by BL, result is in AX (AX = AL * BL)

    MOV [DI], AX               ; Store the 16-bit result in the result array

    ADD SI, 1                  ; Move to the next byte in the array
    ADD DI, 2                  ; Move to the next word in the result array (2 bytes)
    LOOP START_LOOP            ; Repeat for all bytes in the array

    ; Program exit
    MOV AH, 4CH
    INT 21H

END
