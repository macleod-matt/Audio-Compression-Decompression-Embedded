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
	.text
	.align	2
	.global	decToBinary
	.type	decToBinary, %function
decToBinary:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 144
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #148
	str	r0, [fp, #-144]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L2
.L3:
	ldr	r0, [fp, #-8]
	ldr	r2, [fp, #-144]
	mov	r3, r2, asr #31
	mov	r1, r3, lsr #31
	add	r3, r2, r1
	and	r3, r3, #1
	rsb	r3, r1, r3
	mov	r1, r3
	mvn	r2, #131
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
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L2:
	ldr	r3, [fp, #-144]
	cmp	r3, #0
	bgt	.L3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	decToBinary, .-decToBinary
	.section	.rodata
	.align	2
.LC0:
	.ascii	"\012!!!!! INPUT IS TOO LARGE !!!!!\000"
	.text
	.align	2
	.global	codeword_compression
	.type	codeword_compression, %function
codeword_compression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	ldr	r2, [fp, #-24]
	mov	r3, #8128
	add	r3, r3, #63
	cmp	r2, r3
	ble	.L6
	ldr	r3, [fp, #-24]
	sub	r3, r3, #8192
	str	r3, [fp, #-24]
.L6:
	ldr	r3, [fp, #-28]
	cmp	r3, #0
	movne	r3, #0
	moveq	r3, #1
	str	r3, [fp, #-28]
	ldr	r2, [fp, #-24]
	mov	r3, #16320
	add	r3, r3, #63
	cmp	r2, r3
	ble	.L7
	ldr	r0, .L18
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L8
.L7:
	ldr	r2, [fp, #-24]
	mov	r3, #4080
	add	r3, r3, #15
	cmp	r2, r3
	ble	.L9
	mov	r3, #7
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #8
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-12]
	eor	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-32]
	b	.L8
.L9:
	ldr	r2, [fp, #-24]
	mov	r3, #2032
	add	r3, r3, #15
	cmp	r2, r3
	ble	.L10
	mov	r3, #6
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #7
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-12]
	eor	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-32]
	b	.L8
.L10:
	ldr	r2, [fp, #-24]
	mov	r3, #1020
	add	r3, r3, #3
	cmp	r2, r3
	ble	.L11
	mov	r3, #5
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #6
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-12]
	eor	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-32]
	b	.L8
.L11:
	ldr	r2, [fp, #-24]
	mov	r3, #508
	add	r3, r3, #3
	cmp	r2, r3
	ble	.L12
	mov	r3, #4
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #5
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-12]
	eor	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-32]
	b	.L8
.L12:
	ldr	r3, [fp, #-24]
	cmp	r3, #255
	ble	.L13
	mov	r3, #3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #4
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-12]
	eor	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-32]
	b	.L8
.L13:
	ldr	r3, [fp, #-24]
	cmp	r3, #127
	ble	.L14
	mov	r3, #2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #3
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-12]
	eor	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-32]
	b	.L8
.L14:
	ldr	r3, [fp, #-24]
	cmp	r3, #63
	ble	.L15
	mov	r3, #1
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #2
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-12]
	eor	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-32]
	b	.L8
.L15:
	ldr	r3, [fp, #-24]
	cmp	r3, #31
	ble	.L16
	mov	r3, #0
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #1
	and	r3, r3, #15
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-28]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-16]
	mov	r3, r3, asl #4
	eor	r2, r2, r3
	ldr	r3, [fp, #-12]
	eor	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-32]
	b	.L8
.L16:
	mov	r3, #0
	str	r3, [fp, #-32]
.L8:
	ldr	r3, [fp, #-32]
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L19:
	.align	2
.L18:
	.word	.LC0
	.size	codeword_compression, .-codeword_compression
	.align	2
	.global	codeword_decompression
	.type	codeword_decompression, %function
codeword_decompression:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #44
	str	r0, [fp, #-40]
	ldr	r3, [fp, #-40]
	mov	r3, r3, asl #6
	and	r3, r3, #8192
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	movne	r3, #0
	moveq	r3, #1
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-36]
	mov	r3, r3, asl #13
	and	r3, r3, #8192
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-40]
	and	r3, r3, #15
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-40]
	mov	r3, r3, asr #4
	and	r3, r3, #7
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	add	r2, r3, #1
	ldr	r3, [fp, #-28]
	mov	r3, r3, asl r2
	str	r3, [fp, #-20]
	mov	r2, #33
	ldr	r3, [fp, #-24]
	mov	r3, r2, asl r3
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-20]
	orr	r3, r2, r3
	str	r3, [fp, #-12]
	ldr	r2, [fp, #-32]
	ldr	r3, [fp, #-12]
	orr	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	codeword_decompression, .-codeword_decompression
	.align	2
	.global	signum
	.type	signum, %function
signum:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #8192
	ble	.L23
	mov	r3, #1
	str	r3, [fp, #-12]
	b	.L24
.L23:
	mov	r3, #0
	str	r3, [fp, #-12]
.L24:
	ldr	r3, [fp, #-12]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	signum, .-signum
	.align	2
	.global	magnitude
	.type	magnitude, %function
magnitude:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #8192
	ble	.L27
	ldr	r3, [fp, #-8]
	mov	r3, r3, asl #19
	mov	r3, r3, lsr #19
	str	r3, [fp, #-8]
.L27:
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	magnitude, .-magnitude
	.section	.rodata
	.align	2
.LC1:
	.ascii	"\012<Testing..\000"
	.align	2
.LC2:
	.ascii	"\012Input: %d | \000"
	.align	2
.LC3:
	.ascii	"\012Compressed: %d | \000"
	.align	2
.LC4:
	.ascii	"\012Decompressed: %d | \000"
	.text
	.align	2
	.global	Test
	.type	Test, %function
Test:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #20
	str	r0, [fp, #-24]
	ldr	r0, [fp, #-24]
	bl	magnitude
	mov	r4, r0
	ldr	r0, [fp, #-24]
	bl	signum
	mov	r3, r0
	mov	r0, r4
	mov	r1, r3
	bl	codeword_compression
	mov	r3, r0
	str	r3, [fp, #-20]
	ldr	r0, [fp, #-20]
	bl	codeword_decompression
	mov	r3, r0
	str	r3, [fp, #-16]
	ldr	r0, .L31
	bl	printf
	ldr	r0, .L31+4
	ldr	r1, [fp, #-24]
	bl	printf
	ldr	r0, [fp, #-24]
	bl	decToBinary
	ldr	r0, .L31+8
	ldr	r1, [fp, #-20]
	bl	printf
	ldr	r0, [fp, #-20]
	bl	decToBinary
	ldr	r0, .L31+12
	ldr	r1, [fp, #-16]
	bl	printf
	ldr	r0, [fp, #-16]
	bl	decToBinary
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
.L32:
	.align	2
.L31:
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.size	Test, .-Test
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
