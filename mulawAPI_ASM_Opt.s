	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"mulawAPI.c"
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\000"
	.text
	.align	2
	.global	decToBinary
	.type	decToBinary, %function
decToBinary:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 144
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #144
	str	r0, [fp, #-144]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L2
.L3:
	ldr	r0, [fp, #-12]
	ldr	r2, [fp, #-144]
	mov	r3, r2, asr #31
	mov	r1, r3, lsr #31
	add	r3, r2, r1
	and	r3, r3, #1
	rsb	r3, r1, r3
	mov	r1, r3
	mvn	r2, #135
	mov	r3, r0, asl #2
	sub	r0, fp, #4
	add	r3, r0, r3
	add	r3, r3, r2
	str	r1, [r3, #0]
	ldr	r2, [fp, #-144]
	mov	r3, r2, lsr #31
	add	r3, r3, r2
	mov	r3, r3, asr #1
	str	r3, [fp, #-144]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L2:
	ldr	r3, [fp, #-144]
	cmp	r3, #0
	bgt	.L3
	ldr	r3, [fp, #-12]
	sub	r3, r3, #1
	str	r3, [fp, #-8]
	b	.L4
.L5:
	ldr	r3, [fp, #-8]
	mvn	r2, #135
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r3, [r3, #0]
	ldr	r0, .L7
	mov	r1, r3
	bl	printf
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	str	r3, [fp, #-8]
.L4:
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bge	.L5
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LC0
	.size	decToBinary, .-decToBinary
	.section	.rodata
	.align	2
.LC1:
	.ascii	"\012!!!!! INPUT IS TOO LARGE !!!!!\000"
	.text
	.align	2
	.global	codeword_compression
	.type	codeword_compression, %function
codeword_compression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-24]
	cmp	r1, #0
	movne	r2, #0
	moveq	r2, #1
	str	r2, [fp, #-28]
	ldr	r1, [fp, #-24]
	and	r3, r1, #32
	cmp	r3, #0
	beq	.L10
	mov	r2, #0
	str	r2, [fp, #-16]
	ldr	r1, [fp, #-24]
	mov	r3, r1, asr #1
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r1, [fp, #-16]
	mov	r3, r1, asl #4
	eor	r3, r2, r3
	ldr	r2, [fp, #-12]
	eor	r3, r3, r2
	str	r3, [fp, #-20]
	b	.L11
.L10:
	ldr	r1, [fp, #-24]
	and	r3, r1, #64
	cmp	r3, #0
	beq	.L12
	mov	r2, #1
	str	r2, [fp, #-16]
	ldr	r1, [fp, #-24]
	mov	r3, r1, asr #2
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r1, [fp, #-16]
	mov	r3, r1, asl #4
	eor	r3, r2, r3
	ldr	r2, [fp, #-12]
	eor	r3, r3, r2
	str	r3, [fp, #-20]
	b	.L11
.L12:
	ldr	r1, [fp, #-24]
	and	r3, r1, #128
	cmp	r3, #0
	beq	.L13
	mov	r2, #2
	str	r2, [fp, #-16]
	ldr	r1, [fp, #-24]
	mov	r3, r1, asr #3
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r1, [fp, #-16]
	mov	r3, r1, asl #4
	eor	r3, r2, r3
	ldr	r2, [fp, #-12]
	eor	r3, r3, r2
	str	r3, [fp, #-20]
	b	.L11
.L13:
	ldr	r1, [fp, #-24]
	and	r3, r1, #256
	cmp	r3, #0
	beq	.L14
	mov	r2, #3
	str	r2, [fp, #-16]
	ldr	r1, [fp, #-24]
	mov	r3, r1, asr #4
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r1, [fp, #-16]
	mov	r3, r1, asl #4
	eor	r3, r2, r3
	ldr	r2, [fp, #-12]
	eor	r3, r3, r2
	str	r3, [fp, #-20]
	b	.L11
.L14:
	ldr	r1, [fp, #-24]
	and	r3, r1, #512
	cmp	r3, #0
	beq	.L15
	mov	r2, #4
	str	r2, [fp, #-16]
	ldr	r1, [fp, #-24]
	mov	r3, r1, asr #5
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r1, [fp, #-16]
	mov	r3, r1, asl #4
	eor	r3, r2, r3
	ldr	r2, [fp, #-12]
	eor	r3, r3, r2
	str	r3, [fp, #-20]
	b	.L11
.L15:
	ldr	r1, [fp, #-24]
	and	r3, r1, #1024
	cmp	r3, #0
	beq	.L16
	mov	r2, #5
	str	r2, [fp, #-16]
	ldr	r1, [fp, #-24]
	mov	r3, r1, asr #6
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r1, [fp, #-16]
	mov	r3, r1, asl #4
	eor	r3, r2, r3
	ldr	r2, [fp, #-12]
	eor	r3, r3, r2
	str	r3, [fp, #-20]
	b	.L11
.L16:
	ldr	r1, [fp, #-24]
	and	r3, r1, #2048
	cmp	r3, #0
	beq	.L17
	mov	r2, #6
	str	r2, [fp, #-16]
	ldr	r1, [fp, #-24]
	mov	r3, r1, asr #7
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r1, [fp, #-16]
	mov	r3, r1, asl #4
	eor	r3, r2, r3
	ldr	r2, [fp, #-12]
	eor	r3, r3, r2
	str	r3, [fp, #-20]
	b	.L11
.L17:
	ldr	r1, [fp, #-24]
	and	r3, r1, #4096
	cmp	r3, #0
	beq	.L18
	mov	r2, #7
	str	r2, [fp, #-16]
	ldr	r1, [fp, #-24]
	mov	r3, r1, asr #8
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r1, [fp, #-16]
	mov	r3, r1, asl #4
	eor	r3, r2, r3
	ldr	r2, [fp, #-12]
	eor	r3, r3, r2
	str	r3, [fp, #-20]
	b	.L11
.L18:
	mov	r3, #16320
	add	r3, r3, #63
	ldr	r1, [fp, #-24]
	cmp	r1, r3
	ble	.L19
	ldr	r0, .L21
	bl	puts
.L19:
	mov	r2, #0
	str	r2, [fp, #-20]
.L11:
	ldr	r0, [fp, #-20]
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L22:
	.align	2
.L21:
	.word	.LC1
	.size	codeword_compression, .-codeword_compression
	.align	2
	.global	codeword_decompression
	.type	codeword_decompression, %function
codeword_decompression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #6
	and	r3, r3, #8192
	cmp	r3, #0
	bne	.L24
	mov	r2, #8192
	str	r2, [fp, #-12]
	b	.L25
.L24:
	mov	r3, #0
	str	r3, [fp, #-12]
.L25:
	ldr	r3, [fp, #-8]
	mov	r3, r3, asr #4
	and	r2, r3, #7
	mov	r3, #33
	mov	r1, r3, asl r2
	ldr	r3, [fp, #-8]
	and	r2, r3, #15
	ldr	r3, [fp, #-8]
	mov	r3, r3, asr #4
	and	r3, r3, #7
	add	r3, r3, #1
	mov	r3, r2, asl r3
	orr	r3, r1, r3
	ldr	r2, [fp, #-12]
	orr	r3, r2, r3
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	codeword_decompression, .-codeword_decompression
	.section	.rodata
	.align	2
.LC2:
	.ascii	"\012Turn debugging to 1 in mulawAPI.h for debugging"
	.ascii	" mode\012\000"
	.align	2
.LC3:
	.ascii	"\012<Testing..\000"
	.align	2
.LC4:
	.ascii	"\012Input: %d | \000"
	.align	2
.LC5:
	.ascii	"\012Compressed: %d | \000"
	.align	2
.LC6:
	.ascii	"\012Decompressed: %d | \000"
	.text
	.align	2
	.global	Test
	.type	Test, %function
Test:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	ldr	r0, .L31
	bl	puts
	ldr	r3, [fp, #-16]
	and	r3, r3, #8192
	cmp	r3, #0
	beq	.L28
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #19
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	mov	r3, r3, lsr #19
	str	r3, [fp, #-20]
	b	.L29
.L28:
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-20]
.L29:
	ldr	r3, [fp, #-16]
	and	r3, r3, #8192
	ldr	r0, [fp, #-20]
	mov	r1, r3
	bl	codeword_compression
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r0, [fp, #-12]
	bl	codeword_decompression
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, .L31+4
	bl	printf
	ldr	r0, .L31+8
	ldr	r1, [fp, #-16]
	bl	printf
	ldr	r0, [fp, #-16]
	bl	decToBinary
	ldr	r0, .L31+12
	ldr	r1, [fp, #-12]
	bl	printf
	ldr	r0, [fp, #-12]
	bl	decToBinary
	ldr	r0, .L31+16
	ldr	r1, [fp, #-8]
	bl	printf
	ldr	r0, [fp, #-8]
	bl	decToBinary
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L32:
	.align	2
.L31:
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.size	Test, .-Test
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
