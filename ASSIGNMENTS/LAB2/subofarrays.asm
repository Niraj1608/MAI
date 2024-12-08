.MODEL SMALL

.DATA
    ARRAY1 DW 1000H, 2000H, 3000H, 4000H, 5000H  ; First array (n=5)
    ARRAY2 DW 0500H, 1000H, 1500H, 2000H, 2500H  ; Second array (n=5)
    RESULT DW 5 DUP(?)                            ; Result array (initialized with empty)
    SIZE DB 05H                                   ; Size of the arrays (number of words)

.CODE
    MOV AX, @DATA                 ; Initialize data segment
    MOV DS, AX

    LEA SI, ARRAY1                ; Load address of ARRAY1 into SI
    LEA DI, ARRAY2                ; Load address of ARRAY2 into DI
    LEA BX, RESULT                ; Load address of RESULT array into BX
    MOV CL, SIZE                  ; Load the size of the arrays into CL

LABEL1:
    MOV AX, [SI]                  ; Load a word from ARRAY1 into AX
    SUB AX, [DI]                  ; Subtract the word from ARRAY2
    JNB LABEL2                    ; If no borrow, jump to LABEL2

    NEG AX                        ; If borrow occurred, negate AX
LABEL2:
    MOV [BX], AX                  ; Store the result in RESULT array

    ; Increment pointers to process the next element
    ADD SI, 2                     ; Increment SI to point to the next word (2 bytes)
    ADD DI, 2                     ; Increment DI to point to the next word (2 bytes)
    ADD BX, 2                     ; Increment BX to point to the next word (2 bytes)

    DEC CL                        ; Decrement the counter
    JNZ LABEL1                    ; Repeat if more elements remain

    HLT                           ; Halt execution
END
OFFSET msgPositive ; Load positive result message
    JMP STORE_RESULT

ZERO_RESULT:
    MOV DX, OFFSET msgEqual    ; Load zero result message

STORE_RESULT:
    MOV AH, 09H                ; DOS interrupt to print the message
    INT 21H

    ADD SI, 2                  ; Move to the next word in arr1
    ADD DI, 2                  ; Move to the next word in arr2
    ADD BX, 2                  ; Move to the next word in result array
    LOOP START_LOOP            ; Repeat for all words in the arrays

    MOV AH, 4CH                ; Terminate program
    INT 21H

END
