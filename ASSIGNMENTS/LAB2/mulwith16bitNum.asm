.MODEL SMALL
.STACK 100H
.DATA
    nWords EQU 5               ; Define the number of words in the array
    arr DW 1000, 2000, 3000, 4000, 5000  ; Array of n words (16-bit each)
    multiplier DW 3            ; 16-bit number to multiply the array by
    result DW nWords*2 DUP(?)  ; Array to store the 32-bit result (2 words per result)
.CODE
    MOV AX, @DATA
    MOV DS, AX                 ; Initialize the data segment
    MOV CX, nWords             ; Load the number of words to process into CX
    LEA SI, arr                ; Load the address of the input array into SI
    LEA DI, result             ; Load the address of the result array into DI

START_LOOP:
    MOV AX, [SI]               ; Load the current word from the input array into AX
    MOV BX, multiplier         ; Load the multiplier into BX
    MUL BX                     ; Multiply AX by BX, result stored in DX:AX
    MOV [DI], AX               ; Store the lower 16 bits of the result
    MOV [DI+2], DX             ; Store the upper 16 bits of the result
    ADD SI, 2                  ; Move to next input word
    ADD DI, 4                  ; Move to next result double-word
    LOOP START_LOOP            ; Continue until all words processed

    ; Program exit
    MOV AH, 4CH
    INT 21H
END   ; Repeat for all words in the array

    ; Program exit
    MOV AH, 4CH
    INT 21H

END
