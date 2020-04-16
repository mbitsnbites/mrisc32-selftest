; -*- mode: mr32asm; tab-width: 4; indent-tabs-mode: nil; -*-
;-----------------------------------------------------------------------------
; Copyright (c) 2020 Marcus Geelnard
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

    .include    "selftest.inc"

    BEGIN_TEST  test_sub

    ; Immediate operand.
    ldi     s9, #123456
    sub     s10, #42, s9
    CHECKEQ s10, -123414

    ; Register operands.
    ldi     s9, #123456
    ldi     s10, #-9456
    sub     s11, s9, s10
    CHECKEQ s11, 132912

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldi     s9,  #0x1234a698
    ldi     s10, #0xa7ef83a3

    ; Packed half-word.
    sub.h   s11, s9, s10
    CHECKEQ s11, 0x6a4522f5

    ; Packed byte.
    sub.b   s11, s9, s10
    CHECKEQ s11, 0x6b4523f5

no_packed_ops:

    END_TEST

