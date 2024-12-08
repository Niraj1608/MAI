.MODEL SMALL
.STACK 100H

.DATA
    nWords EQU 5                   ; Define the number of words in the array
    arr DW 1234, 5678, 1234, 9999, 1234  ; Array of n words (16-bit each)
    target DW 1234                 ; The number to count the occurrences of
    count DW 0                     ; Variable to store the count of occurrences

.CODE
    MOV AX, @DATA
    MOV DS, AX                     ; Initialize the data segment

    MOV CX, nWords                 ; Load the number of words to process
    LEA SI, arr                    ; Load the address of the array in SI
    MOV DX, target                 ; Load the target number into DX
    MOV AX, 0                      ; Clear the AX register (for comparison)
    MOV count, 0                   ; Initialize count to 0

START_LOOP:
    MOV AX, [SI]                   ; Load the current word from the array into AX
    CMP AX, DX                     ; Compare AX with the target number
    JNE NOT_EQUAL                  ; If they are not equal, jump to NOT_EQUAL

    INC WORD PTR count             ; If they are equal, increment the count

NOT_EQUAL:
    ADD SI, 2                      ; Move to the next word in the array
    LOOP START_LOOP                ; Repeat for all words in the array

    ; Program exit
    MOV AH, 4CH
    INT 21H

END
