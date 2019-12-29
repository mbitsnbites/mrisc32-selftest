; -*- mode: mr32asm; tab-width: 4; indent-tabs-mode: nil; -*-
;-----------------------------------------------------------------------------
; Copyright (c) 2019 Marcus Geelnard
;
; This software is provided 'as-is', without any express or implied warranty.
; In no event will the authors be held liable for any damages arising from
; the use of this software.
;
; Permission is granted to anyone to use this software for any purpose,
; including commercial applications, and to alter it and redistribute it
; freely, subject to the following restrictions:
;
;  1. The origin of this software must not be misrepresented; you must not
;     claim that you wrote the original software. If you use this software in
;     a product, an acknowledgment in the product documentation would be
;     appreciated but is not required.
;
;  2. Altered source versions must be plainly marked as such, and must not be
;     misrepresented as being the original software.
;
;  3. This notice may not be removed or altered from any source distribution.
;-----------------------------------------------------------------------------

    .text

;-----------------------------------------------------------------------------
; typedef void (*test_result_fun_t)(int pass, int test_no);
;
; int selftest_run(test_result_fun_t test_result_fun);
;
;  s1 = test_result_fun
;-----------------------------------------------------------------------------

    .p2align 2
    .global selftest_init

selftest_run:
    add     sp, sp, #-20
    stw     lr, sp, #0
    stw     s16, sp, #4
    stw     s17, sp, #8
    stw     s18, sp, #12
    stw     s19, sp, #16

    ; s16 = Pointer to the list of tests.
    addpchi s16, #tests@pchi
    add     s16, s16, #tests+4@pclo

    ; s17 = Total test result.
    ldi     s17, #-1

    ; s18 = test_result_fun
    mov     s18, s1

    ; s19 = test_no
    ldi     s19, #0

loop:
    ldw     s1, s16, s19*4  ; Load the next test
    bz      s1, done        ; (exit when there are no more tests)

    ; Call the test function.
    jl      s1
    and     s17, s17, s1    ; Update the total test result

    ; Call the test result function.
    ;  s1 = test result (pass/fail)
    ;  s2 = test number
    mov     s2, s19
    jl      s18, #0

    add     s19, s19, #1
    j       pc, #loop@pc

done:
    mov     s1, s17         ; Return the total test result

    ldw     lr, sp, #0
    ldw     s16, sp, #4
    ldw     s17, sp, #8
    ldw     s18, sp, #12
    ldw     s19, sp, #16
    add     sp, sp, #20
    j       lr


    .section .rodata

;-----------------------------------------------------------------------------
; The test list. When a new test source file is added, also add the test here.
;-----------------------------------------------------------------------------

tests:
    .word   test_add
    .word   0
