; -*- mode: mr32asm; tab-width: 4; indent-tabs-mode: nil; -*-
;-----------------------------------------------------------------------------
; Copyright (c) 2021 Marcus Geelnard
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

    BEGIN_TEST  test_popcnt

    ldi     s9, #0x00000000
    popcnt  s10, s9
    CHECKEQ s10, 0

    ldi     s9, #0x55555555
    popcnt  s10, s9
    CHECKEQ s10, 16

    ldi     s9, #0xffffffff
    popcnt  s10, s9
    CHECKEQ s10, 32

    ldi     s9, #0x08153000
    popcnt  s10, s9
    CHECKEQ s10, 6

    ; Can we do packed operations?
    NOPO    no_packed_ops

    ; s9 = 0x08153000
    popcnt.h s10, s9
    CHECKEQ s10, 0x00040002

    ; s9 = 0x08153000
    popcnt.b s10, s9
    CHECKEQ s10, 0x01030200

no_packed_ops:

    END_TEST
