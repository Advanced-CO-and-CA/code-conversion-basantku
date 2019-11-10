/******************************************************************************
* file: assigment5-part1.s
* author: Basant Kumar
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/


@ BSS section
    .bss

@ DATA SECTION
    .data
A_DIGIT: .word 0x43
@A_DIGIT: .word 0x63
@A_DIGIT: .word 0x37
/*Output*/
H_DIGIT: .word 0

@ TEXT section
    .text

.globl _main

_main:
  ldr r6, =A_DIGIT        /*load addr of A_DIGIT in r6 */
  ldr r7, =H_DIGIT        /*load addr of H_DIGIT in r7*/

  mov r4, #1           //flag to track error, set means error

/*one time read operation*/
  ldr r2, [r6]        /*read A_DIGIT content*/
  and r2, r2, #0xFF
  cmp r2, #'a'         //boundary check for a to f range
  bmi atof
  cmp r2, #'f'
  ble processatof
atof:
  cmp r2, #'A'         //boundary check for A to F range
  bmi zeroTo9
  cmp r2, #'F'
  ble processAtoF
zeroTo9:
  cmp r2, #'0'         //boundary check for 0 to 9 range
  bmi error
  cmp r2, #'9'
  bgt error

processAtoF:
  cmp r2, #58
  blt sub_zero
  sub r2, r2, #'A' - '0' -0xA
  b sub_zero

processatof:
  cmp r2, #58
  blt sub_zero
  sub r2, r2, #'a' - '0' - 0xA

sub_zero:
  sub r2, r2, #'0'
  mov r4, #0          //clear error flag

error:
  cmp r4, #0            //If no error jump to update the converted value
  beq update
  mov r2, #0            //If error clear partially processed data to zero

update:
  str r2, [r7]         //update GREATER

.end