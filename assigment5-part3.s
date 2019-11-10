/******************************************************************************
* file: assigment5-part3.s
* author: Basant Kumar
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/


@ BSS section
    .bss

@ DATA SECTION
    .data
BCDNUM: .asciz "92529679"

.align

//Output
NUMBER: .word 0

@ TEXT section
    .text

.globl _main

_main:
  ldr r6, =BCDNUM        //load addr of LENGTH in r6
  ldr r7, =NUMBER       //load addr of GREATER in r7

//one time read operation
  ldrb r2, [r6]        //read LENGTH

  mov r0, #0           //counter
  mov r3, #0           //converted value
  mov r4, #1           //flag to track error, set means error
compare:
  cmp r2, #'0'         //boundary check for digit greater than zero
  bmi error
  cmp r2, #'9'         //boundary check for digit samller than nine
  bgt error
  sub r2, r2, #'0'     //r2 = r2 - 0
  mov r4, #0           //clear error flag
  mov r5, r3
  lsl r3, r3, #2         //multiply by 10*x = 2*(2^2*x+x)
  add r3, r3, r5         //2^2*x+x
  lsl r3, r3, #1         //2*(2^2*x+x)
  add r3, r3, r2         // 10*prev + curr


next:
  add r0, r0, #1
  ldrb r2, [r6, r0]        //read next
  cmp r2, #0              //check string termination
  bne compare             //if not equal jump to level:compare for next character comparision

error:
  cmp r4, #0            //If no error jump to update the converted value
  beq update
  mov r3, #0            //If error clear partially processed data to zero

update:
  str r3, [r7]        //update GREATER

.end