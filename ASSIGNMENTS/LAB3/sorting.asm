.MODEL SMALL
.STACK 100H

.DATA
    nWords EQU 5                   ; Number of words in the array
    arr DW 4321, 1234, 8765, 5678, 3456  ; Array of n words (16-bit each)

.CODE
    MOV AX, @DATA
    MOV DS, AX                     ; Initialize the data segment

    MOV CX, nWords                 ; Load the number of elements into CX

OUTER_LOOP:
    MOV SI, 0                      ; Set SI to the first element's offset (start of the array)
    MOV BX, CX                     ; Load the number of passes (current array size) into BX
    DEC BX                         ; We reduce by one because we compare adjacent elements

INNER_LOOP:
    MOV AX, [SI]                   ; Load current element into AX
    MOV DX, [SI+2]                 ; Load next element into DX (adjacent element)

    CMP AX, DX                     ; Compare current element with next
    JBE NO_SWAP                    ; If current <= next, no swap needed

    ; Swap AX and DX (current and next element)
    XCHG AX, DX
    MOV [SI], AX                   ; Store smaller element in the current position
    MOV [SI+2], DX                 ; Store larger element in the next position

NO_SWAP:
    ADD SI, 2                      ; Move to the next element (each element is 2 bytes)
    DEC BX                         ; Decrement BX, number of remaining comparisons in this pass
    JNZ INNER_LOOP                 ; Continue inner loop if more elements to compare

    DEC CX                         ; Decrease the outer loop counter (remaining passes)
    CMP CX, 1                      ; If only one element left, sorting is done
    JG OUTER_LOOP                  ; If CX > 1, repeat the outer loop

    ; Program exit
    MOV AH, 4CH
    INT 21H

END
