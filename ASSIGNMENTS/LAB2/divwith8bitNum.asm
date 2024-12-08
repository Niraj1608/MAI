.MODEL SMALL
.STACK 100H

.DATA
    nBytes EQU 5               ; Define the number of bytes in the array
    arr DB 50, 100, 150, 200, 250  ; Array of n bytes
    divisor DB 5              ; 8-bit number to divide the array by
    result DB nBytes DUP(0)    ; Array to store the quotient (result of division)
    remainder DB nBytes DUP(0) ; Array to store the remainder

.CODE
    MOV AX, @DATA
    MOV DS, AX                 ; Initialize the data segment

    MOV CX, nBytes             ; Load the number of bytes to process
    LEA SI, arr                ; Load the address of the array in SI
    LEA DI, result             ; Load the address of the result array in DI
    LEA BX, remainder          ; Load the address of the remainder array in BX
    MOV DL, divisor            ; Load the 8-bit divisor into BL

START_LOOP:
    MOV AL, [SI]               ; Load the current byte from the array into AL
    XOR AH, AH                 ; Clear AH to ensure AX is a valid 16-bit number (for DIV)

    DIV DL                     ; Divide AX by BL, result in AL, remainder in AH

    MOV [DI], AL               ; Store the quotient (AL) in the result array
    MOV [BX], AH               ; Store the remainder (AH) in the remainder array

    ADD SI, 1                  ; Move to the next byte in the input array
    ADD DI, 1                  ; Move to the next byte in the result array
    ADD BX, 1                  ; Move to the next byte in the remainder array
    LOOP START_LOOP            ; Repeat for all bytes in the array

    ; Program exit
    MOV AH, 4CH
    INT 21H

END

