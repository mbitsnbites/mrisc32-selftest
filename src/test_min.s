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

    BEGIN_TEST  test_min

    ; Immediate operand.
    ldi     s9, #123456
    min     s10, s9, #42
    CHECKEQ s10, 42

    ldi     s9, #-41
    min     s10, s9, #42
    CHECKEQ s10, -41


    ; Register operands.
    ldi     s9, #123456
    ldi     s10, #-9456
    min     s11, s9, s10
    CHECKEQ s11, -9456

    ldi     s9, #-123456
    ldi     s10, #123456
    min     s11, s9, s10
    CHECKEQ s11, -123456

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ldi     s9,  #0x12f4a607
    ldi     s10, #0x11125698

    ; Packed half-word.
    min.h   s11, s9, s10
    CHECKEQ s11, 0x1112a607

    ; Packed byte.
    min.b   s11, s9, s10
    CHECKEQ s11, 0x11f4a698

no_packed_ops:

    END_TEST

