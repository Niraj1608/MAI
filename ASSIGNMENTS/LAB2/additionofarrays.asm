.MODEL SMALL
.STACK 100H

.DATA
    ARRAY1 DW 10H, 20H, 30H, 40H    ; Example array 1
    ARRAY2 DW 5H, 15H, 25H, 35H     ; Example array 2
    RESULT DW 4 DUP (?)             ; Array to store the result (same size as input arrays)
    ARRAY_LENGTH DW 4               ; Length of arrays (number of elements)

.CODE
START:
    ; Set up data segment
    MOV AX, @DATA
    MOV DS, AX
    
    ; Initialize pointers to arrays and result array
    LEA SI, ARRAY1       ; SI points to the start of ARRAY1
    LEA DI, ARRAY2       ; DI points to the start of ARRAY2
    LEA BX, RESULT       ; BX points to the start of RESULT
    MOV CX, ARRAY_LENGTH ; CX = length of the arrays
    
    ; Loop through arrays and add corresponding elements
ADD_LOOP:
    ; Load elements from ARRAY1 and ARRAY2
    MOV AX, [SI]         ; Load word from ARRAY1 into AX
    ADD AX, [DI]         ; Add word from ARRAY2 to AX
    
    ; Store result in RESULT array
    MOV [BX], AX         ; Store the result in RESULT array
    
    ; Increment pointers and loop counter
    ADD SI, 2            ; Move to the next word in ARRAY1
    ADD DI, 2            ; Move to the next word in ARRAY2
    ADD BX, 2            ; Move to the next word in RESULT
    LOOP ADD_LOOP        ; Decrement CX and repeat if CX != 0
    
    ; Exit program
    MOV AH, 4CH
    INT 21H

END START

