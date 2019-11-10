/******************************************************************************
* file: assigment5-part2.s
* author: Basant Kumar
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/


@ BSS section
    .bss

@ DATA SECTION
    .data
SRTING: .asciz "11010011011111"
@SRTING: .asciz "110107110"

.align
Flag: .byte 0x0
.align
NUMBER: .word 0x0


@ TEXT section
    .text

.globl _main

_main:
/*one time read operation*/
  ldr r4, =SRTING        /*load addr of str1 in r4   */
  ldr r5, =Flag        /*load addr of str2 in r5   */
  ldr r6, =NUMBER        /*load addr of LENGTH in r6 */

  mov r1, #0
/*sanity to check empty string*/
  ldrb r0, [r4, r1]      /*read str 1-byte at offset r1*/
  cmp r0, #0             /*check for string termination*/
  beq err

compare:
  cmp r0, #'0'           /*compare with char '0'*/
  mov r2, #0
  beq store
  cmp r0, #'1'          /*compare with char '1'*/
  mov r2, #1
  beq store
  mvn r0, #0
  mvn r3, #0
  b err

next:
  add r1, r1, #1      /*jump to addr of next character*/
  ldrb r0, [r4, r1]    /*read str 1-byte at offset r1*/
  cmp r0, #0          /*check for string termination*/
  bne compare         /*if not equal jump to level:compare for next character comparision*/
  mov r0, #0          /* complete string parsed so no error */
  b err

@11010010
store:
  lsl r3, #4
  orr r3, r3, r2
  cmp r1, #7
  bne next                    /*Show only result for 1st 8 character, rest ignored*/
  str r3, [r6, r8, lsl #2]    /*update NUMBER*/

err:
  str r0, [r5]                /*update FLAG*/
  str r3, [r6, r8, lsl #2]    /*update NUMBER*/

.end