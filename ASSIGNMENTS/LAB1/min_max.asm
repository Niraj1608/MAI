.MODEL SMALL
.STACK 100H

.DATA
    NUMBERS DW 1234H, 4321H, 3456H, 789AH, 1B2CH  ; Array of 16-bit numbers
    MAX DW ?                                      ; To store the maximum number
    MIN DW ?                                      ; To store the minimum number
    SIZE DW 5                                     ; Size of the array

.CODE
START:
    MOV AX, @DATA          ; Initialize data segment
    MOV DS, AX

    MOV CX, SIZE           ; Set counter to the number of elements in the array
    LEA SI, NUMBERS        ; Load the address of the first element in the array

    MOV AX, [SI]           ; Load the first element of the array into AX
    MOV MAX, AX            ; Initialize MAX with the first element
    MOV MIN, AX            ; Initialize MIN with the first element

    ADD SI, 2              ; Point to the second element (each element is 2 bytes)
    DEC CX                 ; Decrease counter by 1 (we already processed the first element)

FIND_MAX_MIN:
    MOV AX, [SI]           ; Load the next element in the array into AX

    ; Compare with MAX
    CMP AX, MAX            ; Compare AX (current element) with MAX
    JBE NOT_MAX            ; If AX <= MAX, skip to NOT_MAX
    MOV MAX, AX            ; Otherwise, store AX in MAX

NOT_MAX:
    ; Compare with MIN
    CMP AX, MIN            ; Compare AX (current element) with MIN
    JAE NOT_MIN            ; If AX >= MIN, skip to NOT_MIN
    MOV MIN, AX            ; Otherwise, store AX in MIN

NOT_MIN:
    ADD SI, 2              ; Move to the next 16-bit element
    DEC CX                 ; Decrease the counter
    JNZ FIND_MAX_MIN       ; Repeat the process until all elements are processed

    ; Program end
    MOV AH, 4CH            ; DOS terminate program function
    INT 21H

END START
