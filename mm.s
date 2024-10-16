	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 0
	.globl	_new_page                       ; -- Begin function new_page
	.p2align	2
_new_page:                              ; @new_page
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x8, _pagesize@GOTPAGE
	ldr	x8, [x8, _pagesize@GOTPAGEOFF]
	ldr	x8, [x8]
	mov	x0, x8
	bl	_mem_sbrk
	str	x0, [sp]
	ldr	x8, [sp]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB0_2
	b	LBB0_1
LBB0_1:
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #8]
	b	LBB0_3
LBB0_2:
	ldr	x8, [sp]
	str	x8, [sp, #8]
	b	LBB0_3
LBB0_3:
	ldr	x0, [sp, #8]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_set_block                      ; -- Begin function set_block
	.p2align	2
_set_block:                             ; @set_block
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]                    ; 8-byte Folded Spill
	mov	x8, x0
	stur	x8, [x29, #-8]
	ldr	x8, [x0, #8]
	add	x8, x8, #16
	ldr	x9, [x0, #16]
	subs	x8, x8, x9
	cset	w9, ne
                                        ; implicit-def: $x8
	mov	x8, x9
	ands	x8, x8, #0x1
	cset	w8, eq
	tbnz	w8, #0, LBB1_2
	b	LBB1_1
LBB1_1:
	adrp	x0, l___func__.set_block@PAGE
	add	x0, x0, l___func__.set_block@PAGEOFF
	adrp	x1, l_.str@PAGE
	add	x1, x1, l_.str@PAGEOFF
	mov	w2, #56                         ; =0x38
	adrp	x3, l_.str.1@PAGE
	add	x3, x3, l_.str.1@PAGEOFF
	bl	___assert_rtn
LBB1_2:
	b	LBB1_3
LBB1_3:
	ldr	x9, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x8, [x9, #24]
	str	x8, [sp, #16]
	ldr	x8, [sp, #16]
	subs	x8, x8, #8
	str	x8, [sp, #16]
	ldr	x10, [x9, #8]
	ldr	w8, [x9]
                                        ; kill: def $x8 killed $w8
	orr	x8, x8, x10, lsl #1
	ldr	x10, [sp, #16]
	str	x8, [x10]
	ldr	x8, [x9, #8]
	mov	x10, #8                         ; =0x8
	udiv	x8, x8, x10
	add	x11, x8, #1
	ldr	x8, [sp, #16]
	add	x8, x8, x11, lsl #3
	str	x8, [sp, #16]
	ldr	x11, [x9, #8]
	ldr	w8, [x9]
                                        ; kill: def $x8 killed $w8
	orr	x8, x8, x11, lsl #1
	ldr	x11, [sp, #16]
	str	x8, [x11]
	ldr	x8, [sp, #16]
	ldr	x9, [x9, #8]
	udiv	x10, x9, x10
	mov	x9, #0                          ; =0x0
	subs	x9, x9, x10
	add	x0, x8, x9, lsl #3
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_block                      ; -- Begin function get_block
	.p2align	2
_get_block:                             ; @get_block
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	x9, x8
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	str	x8, [sp]
	ldr	x8, [sp]
	ldur	x8, [x8, #-8]
	and	x8, x8, #0x1
                                        ; kill: def $w8 killed $w8 killed $x8
	str	w8, [x9]
	ldr	x8, [sp]
	ldur	x8, [x8, #-8]
	lsr	x8, x8, #1
	str	x8, [x9, #8]
	ldr	x8, [sp]
	ldur	x8, [x8, #-8]
	lsr	x8, x8, #1
	add	x8, x8, #16
	str	x8, [x9, #16]
	ldr	x8, [sp, #8]
	str	x8, [x9, #24]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_print_block                    ; -- Begin function print_block
	.p2align	2
_print_block:                           ; @print_block
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #128
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	ldur	x8, [x29, #-8]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB3_2
	b	LBB3_1
LBB3_1:
	ldur	x0, [x29, #-8]
	sub	x8, x29, #40
	bl	_get_block
	ldur	x8, [x29, #-32]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB3_3
	b	LBB3_2
LBB3_2:
	ldur	x8, [x29, #-8]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.2@PAGE
	add	x0, x0, l_.str.2@PAGEOFF
	bl	_printf
	b	LBB3_4
LBB3_3:
	ldur	x0, [x29, #-8]
	add	x8, sp, #40
	bl	_get_block
	ldr	x12, [sp, #64]
	ldr	w8, [sp, #40]
                                        ; implicit-def: $x11
	mov	x11, x8
	ldr	x10, [sp, #48]
	ldr	x8, [sp, #56]
	mov	x9, sp
	str	x12, [x9]
	str	x11, [x9, #8]
	str	x10, [x9, #16]
	str	x8, [x9, #24]
	adrp	x0, l_.str.3@PAGE
	add	x0, x0, l_.str.3@PAGEOFF
	bl	_printf
	b	LBB3_4
LBB3_4:
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_print_heap                     ; -- Begin function print_heap
	.p2align	2
_print_heap:                            ; @print_heap
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	ldur	x8, [x29, #-8]
	str	x8, [sp, #24]
	ldr	x8, [sp, #24]
	ldur	x9, [x29, #-16]
	add	x8, x8, x9, lsl #3
	str	x8, [sp, #16]
	b	LBB4_1
LBB4_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #24]
	ldr	x9, [sp, #16]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB4_3
	b	LBB4_2
LBB4_2:                                 ;   in Loop: Header=BB4_1 Depth=1
	ldr	x10, [sp, #24]
	ldr	x8, [sp, #24]
	ldr	x8, [x8]
	mov	x9, sp
	str	x10, [x9]
	str	x8, [x9, #8]
	adrp	x0, l_.str.4@PAGE
	add	x0, x0, l_.str.4@PAGEOFF
	bl	_printf
	ldr	x8, [sp, #24]
	add	x8, x8, #8
	str	x8, [sp, #24]
	b	LBB4_1
LBB4_3:
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_print_heap_blocks              ; -- Begin function print_heap_blocks
	.p2align	2
_print_heap_blocks:                     ; @print_heap_blocks
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	ldur	x8, [x29, #-8]
	add	x8, x8, #24
	str	x8, [sp, #16]
	mov	w8, #1                          ; =0x1
	str	w8, [sp, #12]
	adrp	x0, l_.str.5@PAGE
	add	x0, x0, l_.str.5@PAGEOFF
	bl	_printf
	b	LBB5_1
LBB5_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #12]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB5_8
	b	LBB5_2
LBB5_2:                                 ;   in Loop: Header=BB5_1 Depth=1
	adrp	x0, l_.str.6@PAGE
	add	x0, x0, l_.str.6@PAGEOFF
	bl	_printf
	ldr	x0, [sp, #16]
	bl	_print_block
	ldr	x8, [sp, #16]
	subs	x0, x8, #24
	mov	x1, #4                          ; =0x4
	bl	_print_heap
	ldr	x0, [sp, #16]
	bl	_get_next_ptr
	str	x0, [sp, #16]
	ldr	x8, [sp, #16]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB5_4
	b	LBB5_3
LBB5_3:                                 ;   in Loop: Header=BB5_1 Depth=1
	str	wzr, [sp, #12]
	adrp	x0, l_.str.7@PAGE
	add	x0, x0, l_.str.7@PAGEOFF
	bl	_printf
	b	LBB5_7
LBB5_4:                                 ;   in Loop: Header=BB5_1 Depth=1
	ldr	x8, [sp, #16]
	ldur	x8, [x8, #-8]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB5_6
	b	LBB5_5
LBB5_5:                                 ;   in Loop: Header=BB5_1 Depth=1
	str	wzr, [sp, #12]
	adrp	x0, l_.str.6@PAGE
	add	x0, x0, l_.str.6@PAGEOFF
	bl	_printf
	ldr	x8, [sp, #16]
	subs	x0, x8, #24
	mov	x1, #4                          ; =0x4
	bl	_print_heap
	b	LBB5_6
LBB5_6:                                 ;   in Loop: Header=BB5_1 Depth=1
	b	LBB5_7
LBB5_7:                                 ;   in Loop: Header=BB5_1 Depth=1
	adrp	x0, l_.str.6@PAGE
	add	x0, x0, l_.str.6@PAGEOFF
	bl	_printf
	b	LBB5_1
LBB5_8:
	adrp	x0, l_.str.8@PAGE
	add	x0, x0, l_.str.8@PAGEOFF
	bl	_printf
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_next_ptr                   ; -- Begin function get_next_ptr
	.p2align	2
_get_next_ptr:                          ; @get_next_ptr
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-16]
	ldur	x8, [x29, #-16]
	stur	x8, [x29, #-24]
	ldur	x8, [x29, #-24]
	ldur	x8, [x8, #-8]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB6_2
	b	LBB6_1
LBB6_1:
                                        ; kill: def $x8 killed $xzr
	stur	xzr, [x29, #-8]
	b	LBB6_5
LBB6_2:
	ldur	x0, [x29, #-16]
	add	x8, sp, #8
	bl	_get_block
	ldr	x8, [sp, #32]
	ldr	x9, [sp, #24]
	mov	x10, #8                         ; =0x8
	udiv	x9, x9, x10
	add	x8, x8, x9, lsl #3
	str	x8, [sp]
	ldr	x8, [sp]
	ldur	x8, [x8, #-8]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB6_4
	b	LBB6_3
LBB6_3:
                                        ; kill: def $x8 killed $xzr
	stur	xzr, [x29, #-8]
	b	LBB6_5
LBB6_4:
	ldr	x8, [sp]
	stur	x8, [x29, #-8]
	b	LBB6_5
LBB6_5:
	ldur	x0, [x29, #-8]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_get_prev_ptr                   ; -- Begin function get_prev_ptr
	.p2align	2
_get_prev_ptr:                          ; @get_prev_ptr
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	x0, [sp, #16]
	ldr	x8, [sp, #16]
	str	x8, [sp, #8]
	ldr	x8, [sp, #8]
	ldur	x8, [x8, #-8]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB7_2
	b	LBB7_1
LBB7_1:
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #24]
	b	LBB7_5
LBB7_2:
	ldr	x8, [sp, #8]
	ldur	x8, [x8, #-16]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB7_4
	b	LBB7_3
LBB7_3:
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #24]
	b	LBB7_5
LBB7_4:
	ldr	x8, [sp, #8]
	ldr	x9, [sp, #8]
	ldur	x9, [x9, #-16]
	lsr	x9, x9, #1
	mov	x10, #8                         ; =0x8
	udiv	x10, x9, x10
	mov	x9, #0                          ; =0x0
	subs	x9, x9, x10
	add	x8, x8, x9, lsl #3
	subs	x8, x8, #16
	str	x8, [sp]
	ldr	x8, [sp]
	str	x8, [sp, #24]
	b	LBB7_5
LBB7_5:
	ldr	x0, [sp, #24]
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_coalesce                       ; -- Begin function coalesce
	.p2align	2
_coalesce:                              ; @coalesce
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #336
	stp	x28, x27, [sp, #304]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #320]            ; 16-byte Folded Spill
	add	x29, sp, #320
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	sub	x8, x29, #152
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	stur	x0, [x29, #-32]
	ldur	x0, [x29, #-32]
	bl	_get_prev_ptr
	stur	x0, [x29, #-40]
	ldur	x0, [x29, #-32]
	bl	_get_next_ptr
	stur	x0, [x29, #-48]
	ldur	x0, [x29, #-32]
	sub	x8, x29, #80
	bl	_get_block
	ldur	w8, [x29, #-80]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB8_2
	b	LBB8_1
LBB8_1:
	ldur	x8, [x29, #-32]
	stur	x8, [x29, #-24]
	b	LBB8_11
LBB8_2:
	ldur	x8, [x29, #-40]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB8_6
	b	LBB8_3
LBB8_3:
	ldur	x0, [x29, #-40]
	sub	x8, x29, #112
	bl	_get_block
	ldur	w8, [x29, #-112]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB8_5
	b	LBB8_4
LBB8_4:
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	ldur	x9, [x29, #-96]
	ldur	x10, [x29, #-64]
	add	x9, x9, x10
	stur	x9, [x29, #-120]
	stur	wzr, [x29, #-152]
	ldur	x9, [x29, #-120]
	subs	x9, x9, #16
	stur	x9, [x29, #-144]
	ldur	x9, [x29, #-120]
	stur	x9, [x29, #-136]
	ldur	x9, [x29, #-88]
	stur	x9, [x29, #-128]
	ldr	q0, [x8]
	add	x0, sp, #128
	str	q0, [sp, #128]
	ldr	q0, [x8, #16]
	str	q0, [sp, #144]
	bl	_set_block
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	ldr	q0, [x8]
	stur	q0, [x29, #-80]
	ldr	q0, [x8, #16]
	stur	q0, [x29, #-64]
	b	LBB8_5
LBB8_5:
	b	LBB8_6
LBB8_6:
	ldur	x8, [x29, #-48]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB8_10
	b	LBB8_7
LBB8_7:
	ldur	x0, [x29, #-48]
	add	x8, sp, #96
	bl	_get_block
	ldr	w8, [sp, #96]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB8_9
	b	LBB8_8
LBB8_8:
	ldr	x8, [sp, #112]
	ldur	x9, [x29, #-64]
	add	x8, x8, x9
	str	x8, [sp, #88]
	str	wzr, [sp, #56]
	ldr	x8, [sp, #88]
	subs	x8, x8, #16
	str	x8, [sp, #64]
	ldr	x8, [sp, #88]
	str	x8, [sp, #72]
	ldur	x8, [x29, #-56]
	str	x8, [sp, #80]
	ldur	q0, [sp, #56]
	add	x0, sp, #16
	str	q0, [sp, #16]
	ldur	q0, [sp, #72]
	str	q0, [sp, #32]
	bl	_set_block
	b	LBB8_9
LBB8_9:
	b	LBB8_10
LBB8_10:
	ldur	x8, [x29, #-56]
	stur	x8, [x29, #-24]
	b	LBB8_11
LBB8_11:
	ldur	x0, [x29, #-24]
	ldp	x29, x30, [sp, #320]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #304]            ; 16-byte Folded Reload
	add	sp, sp, #336
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_mm_init                        ; -- Begin function mm_init
	.p2align	2
_mm_init:                               ; @mm_init
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #128
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	_mem_pagesize
	adrp	x8, _pagesize@GOTPAGE
	ldr	x8, [x8, _pagesize@GOTPAGEOFF]
	str	x0, [x8]
	bl	_new_page
	adrp	x8, _begin@PAGE
	str	x0, [x8, _begin@PAGEOFF]
	ldr	x8, [x8, _begin@PAGEOFF]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB9_2
	b	LBB9_1
LBB9_1:
	mov	w8, #-1                         ; =0xffffffff
	stur	w8, [x29, #-4]
	b	LBB9_3
LBB9_2:
	adrp	x8, _begin@PAGE
	ldr	x8, [x8, _begin@PAGEOFF]
	stur	x8, [x29, #-16]
	ldur	x8, [x29, #-16]
	str	xzr, [x8]
	ldur	x8, [x29, #-16]
	str	xzr, [x8, #8]
	adrp	x8, _pagesize@GOTPAGE
	ldr	x8, [x8, _pagesize@GOTPAGEOFF]
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	ldr	x8, [x8]
	subs	x8, x8, #32
	stur	x8, [x29, #-24]
	str	wzr, [sp, #56]
	ldur	x8, [x29, #-24]
	subs	x8, x8, #16
	str	x8, [sp, #64]
	ldur	x8, [x29, #-24]
	str	x8, [sp, #72]
	ldur	x8, [x29, #-16]
	add	x8, x8, #24
	str	x8, [sp, #80]
	ldur	q0, [sp, #56]
	add	x0, sp, #16
	str	q0, [sp, #16]
	ldur	q0, [sp, #72]
	str	q0, [sp, #32]
	bl	_set_block
	ldr	x9, [sp, #8]                    ; 8-byte Folded Reload
	ldur	x8, [x29, #-16]
	ldr	x9, [x9]
	mov	x10, #8                         ; =0x8
	udiv	x9, x9, x10
	add	x8, x8, x9, lsl #3
	stur	xzr, [x8, #-16]
	stur	wzr, [x29, #-4]
	b	LBB9_3
LBB9_3:
	ldur	w0, [x29, #-4]
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_mm_malloc                      ; -- Begin function mm_malloc
	.p2align	2
_mm_malloc:                             ; @mm_malloc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #416
	stp	x28, x27, [sp, #384]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #400]            ; 16-byte Folded Spill
	add	x29, sp, #400
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	stur	x0, [x29, #-32]
	ldur	x8, [x29, #-32]
	add	x8, x8, #7
	and	x8, x8, #0xfffffffffffffff8
	stur	x8, [x29, #-40]
	ldur	x8, [x29, #-32]
	add	x8, x8, #16
	add	x8, x8, #7
	and	x8, x8, #0xfffffffffffffff8
	stur	x8, [x29, #-48]
	adrp	x8, _begin@PAGE
	ldr	x8, [x8, _begin@PAGEOFF]
	add	x8, x8, #24
	stur	x8, [x29, #-56]
	b	LBB10_1
LBB10_1:                                ; =>This Inner Loop Header: Depth=1
	ldur	x0, [x29, #-56]
	sub	x8, x29, #88
	bl	_get_block
	ldur	x8, [x29, #-56]
	ldur	x8, [x8, #-8]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB10_8
	b	LBB10_2
LBB10_2:                                ;   in Loop: Header=BB10_1 Depth=1
	bl	_new_page
	stur	x0, [x29, #-96]
	ldur	x8, [x29, #-96]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB10_4
	b	LBB10_3
LBB10_3:
                                        ; kill: def $x8 killed $xzr
	stur	xzr, [x29, #-24]
	b	LBB10_16
LBB10_4:                                ;   in Loop: Header=BB10_1 Depth=1
	ldur	x8, [x29, #-96]
	ldur	x9, [x29, #-56]
	add	x9, x9, #8
	subs	x8, x8, x9
	cset	w9, ne
                                        ; implicit-def: $x8
	mov	x8, x9
	ands	x8, x8, #0x1
	cset	w8, eq
	tbnz	w8, #0, LBB10_6
	b	LBB10_5
LBB10_5:
	adrp	x0, l___func__.mm_malloc@PAGE
	add	x0, x0, l___func__.mm_malloc@PAGEOFF
	adrp	x1, l_.str@PAGE
	add	x1, x1, l_.str@PAGEOFF
	mov	w2, #273                        ; =0x111
	adrp	x3, l_.str.9@PAGE
	add	x3, x3, l_.str.9@PAGEOFF
	bl	___assert_rtn
LBB10_6:                                ;   in Loop: Header=BB10_1 Depth=1
	b	LBB10_7
LBB10_7:                                ;   in Loop: Header=BB10_1 Depth=1
	ldur	x9, [x29, #-96]
	adrp	x8, _pagesize@GOTPAGE
	ldr	x8, [x8, _pagesize@GOTPAGEOFF]
	ldr	x10, [x8]
	mov	x11, #8                         ; =0x8
	udiv	x10, x10, x11
	add	x9, x9, x10, lsl #3
	stur	xzr, [x9, #-16]
	stur	wzr, [x29, #-128]
	ldr	x9, [x8]
	subs	x9, x9, #16
	stur	x9, [x29, #-120]
	ldr	x8, [x8]
	stur	x8, [x29, #-112]
	ldur	x8, [x29, #-96]
	subs	x8, x8, #8
	stur	x8, [x29, #-104]
	ldur	q0, [x29, #-128]
	sub	x0, x29, #160
	stur	q0, [x29, #-160]
	ldur	q0, [x29, #-112]
	stur	q0, [x29, #-144]
	bl	_set_block
	stur	x0, [x29, #-56]
	ldur	x0, [x29, #-56]
	bl	_coalesce
	b	LBB10_1
LBB10_8:                                ;   in Loop: Header=BB10_1 Depth=1
	ldur	w8, [x29, #-88]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB10_14
	b	LBB10_9
LBB10_9:                                ;   in Loop: Header=BB10_1 Depth=1
	ldur	x8, [x29, #-72]
	ldur	x9, [x29, #-48]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB10_11
	b	LBB10_10
LBB10_10:                               ;   in Loop: Header=BB10_1 Depth=1
	ldur	x8, [x29, #-72]
	ldur	x9, [x29, #-48]
	add	x9, x9, #32
	subs	x8, x8, x9
	cset	w8, lo
	tbnz	w8, #0, LBB10_14
	b	LBB10_11
LBB10_11:
	ldur	x8, [x29, #-72]
	ldur	x9, [x29, #-48]
	subs	x8, x8, x9
	cset	w8, ne
	tbnz	w8, #0, LBB10_13
	b	LBB10_12
LBB10_12:
	mov	w8, #1                          ; =0x1
	stur	w8, [x29, #-192]
	ldur	x8, [x29, #-40]
	stur	x8, [x29, #-184]
	ldur	x8, [x29, #-48]
	stur	x8, [x29, #-176]
	ldur	x8, [x29, #-56]
	stur	x8, [x29, #-168]
	ldur	q0, [x29, #-192]
	add	x0, sp, #160
	str	q0, [sp, #160]
	ldur	q0, [x29, #-176]
	str	q0, [sp, #176]
	bl	_set_block
	str	x0, [sp, #200]
	ldr	x8, [sp, #200]
	stur	x8, [x29, #-24]
	b	LBB10_16
LBB10_13:
	ldur	x8, [x29, #-72]
	ldur	x9, [x29, #-48]
	subs	x8, x8, x9
	str	x8, [sp, #152]
	mov	w8, #1                          ; =0x1
	str	w8, [sp, #120]
	ldur	x8, [x29, #-40]
	str	x8, [sp, #128]
	ldur	x8, [x29, #-48]
	str	x8, [sp, #136]
	ldur	x8, [x29, #-56]
	str	x8, [sp, #144]
	str	wzr, [sp, #88]
	ldr	x8, [sp, #152]
	subs	x8, x8, #16
	str	x8, [sp, #96]
	ldr	x8, [sp, #152]
	str	x8, [sp, #104]
	ldur	x8, [x29, #-56]
	ldur	x9, [x29, #-48]
	mov	x10, #8                         ; =0x8
	udiv	x9, x9, x10
	add	x8, x8, x9, lsl #3
	str	x8, [sp, #112]
	ldur	q0, [sp, #88]
	add	x0, sp, #48
	str	q0, [sp, #48]
	ldur	q0, [sp, #104]
	str	q0, [sp, #64]
	bl	_set_block
	ldur	q0, [sp, #120]
	mov	x0, sp
	str	q0, [sp]
	ldur	q0, [sp, #136]
	str	q0, [sp, #16]
	bl	_set_block
	str	x0, [sp, #40]
	ldr	x8, [sp, #40]
	stur	x8, [x29, #-24]
	b	LBB10_16
LBB10_14:                               ;   in Loop: Header=BB10_1 Depth=1
	ldur	x8, [x29, #-72]
	mov	x9, #8                          ; =0x8
	udiv	x9, x8, x9
	ldur	x8, [x29, #-56]
	add	x8, x8, x9, lsl #3
	stur	x8, [x29, #-56]
	b	LBB10_15
LBB10_15:                               ;   in Loop: Header=BB10_1 Depth=1
	b	LBB10_1
LBB10_16:
	ldur	x0, [x29, #-24]
	ldp	x29, x30, [sp, #400]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #384]            ; 16-byte Folded Reload
	add	sp, sp, #416
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_mm_free                        ; -- Begin function mm_free
	.p2align	2
_mm_free:                               ; @mm_free
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	ldur	x0, [x29, #-8]
	add	x8, sp, #40
	bl	_get_block
	str	wzr, [sp, #40]
	ldur	q0, [sp, #40]
	mov	x0, sp
	str	q0, [sp]
	ldur	q0, [sp, #56]
	str	q0, [sp, #16]
	bl	_set_block
	ldur	x0, [x29, #-8]
	bl	_coalesce
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_mm_realloc                     ; -- Begin function mm_realloc
	.p2align	2
_mm_realloc:                            ; @mm_realloc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-16]
	stur	x1, [x29, #-24]
	ldur	x8, [x29, #-16]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB12_2
	b	LBB12_1
LBB12_1:
	ldur	x0, [x29, #-24]
	bl	_mm_malloc
	stur	x0, [x29, #-8]
	b	LBB12_10
LBB12_2:
	ldur	x8, [x29, #-24]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB12_4
	b	LBB12_3
LBB12_3:
	ldur	x0, [x29, #-16]
	bl	_mm_free
	b	LBB12_4
LBB12_4:
	ldur	x0, [x29, #-16]
	add	x8, sp, #40
	bl	_get_block
	ldur	x0, [x29, #-16]
	bl	_mm_free
	ldur	x0, [x29, #-24]
	bl	_mm_malloc
	str	x0, [sp, #32]
	ldr	x8, [sp, #32]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB12_6
	b	LBB12_5
LBB12_5:
                                        ; kill: def $x8 killed $xzr
	stur	xzr, [x29, #-8]
	b	LBB12_10
LBB12_6:
	ldr	x8, [sp, #32]
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	ldur	x8, [x29, #-16]
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	ldr	x8, [sp, #48]
	ldur	x9, [x29, #-24]
	subs	x8, x8, x9
	cset	w8, hs
	tbnz	w8, #0, LBB12_8
	b	LBB12_7
LBB12_7:
	ldr	x8, [sp, #48]
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	b	LBB12_9
LBB12_8:
	ldur	x8, [x29, #-24]
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	b	LBB12_9
LBB12_9:
	ldr	x1, [sp, #24]                   ; 8-byte Folded Reload
	ldr	x0, [sp, #16]                   ; 8-byte Folded Reload
	ldr	x2, [sp, #8]                    ; 8-byte Folded Reload
	mov	x3, #-1                         ; =0xffffffffffffffff
	bl	___memcpy_chk
	ldr	x8, [sp, #32]
	stur	x8, [x29, #-8]
	b	LBB12_10
LBB12_10:
	ldur	x0, [x29, #-8]
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_begin                          ; @begin
.zerofill __DATA,__common,_begin,8,3
	.comm	_pagesize,8,3                   ; @pagesize
	.section	__TEXT,__cstring,cstring_literals
l___func__.set_block:                   ; @__func__.set_block
	.asciz	"set_block"

l_.str:                                 ; @.str
	.asciz	"mm.c"

l_.str.1:                               ; @.str.1
	.asciz	"b.payload_bytes + WORD_TO_BYTE(2) == b.block_bytes"

l_.str.2:                               ; @.str.2
	.asciz	"DEBUG: Invalid block at %p\n"

l_.str.3:                               ; @.str.3
	.asciz	"DEBUG: block at %p: [ is_used: %u, payload: %zu, block: %zu]\n"

l_.str.4:                               ; @.str.4
	.asciz	"@%p: [%llu]\n"

l_.str.5:                               ; @.str.5
	.asciz	" <-- Begin heap dump\n"

l_.str.6:                               ; @.str.6
	.asciz	"\n"

l_.str.7:                               ; @.str.7
	.asciz	"invalid pointer\n"

l_.str.8:                               ; @.str.8
	.asciz	" <-- End of heap dump\n"

l___func__.mm_malloc:                   ; @__func__.mm_malloc
	.asciz	"mm_malloc"

l_.str.9:                               ; @.str.9
	.asciz	"next_page == ptr + 1"

.subsections_via_symbols
