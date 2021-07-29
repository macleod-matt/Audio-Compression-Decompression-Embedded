	.file	"mulawAPI.c"
	.text
	.globl	decToBinary
	.type	decToBinary, @function
decToBinary:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$28, %rsp
	movl	%edi, -148(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L3:
	movl	-148(%rbp), %eax
	cltd
	shrl	$31, %edx
	addl	%edx, %eax
	andl	$1, %eax
	subl	%edx, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	cltq
	movl	%edx, -144(%rbp,%rax,4)
	movl	-148(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, -148(%rbp)
	addl	$1, -4(%rbp)
.L2:
	cmpl	$0, -148(%rbp)
	jg	.L3
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	decToBinary, .-decToBinary
	.section	.rodata
	.align 8
.LC0:
	.string	"\n!!!!! INPUT IS TOO LARGE !!!!!"
	.text
	.globl	codeword_compression
	.type	codeword_compression, @function
codeword_compression:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	cmpl	$8191, -20(%rbp)
	jle	.L16
	subl	$8192, -20(%rbp)
.L16:
	cmpl	$0, -24(%rbp)
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -24(%rbp)
	cmpl	$16383, -20(%rbp)
	jle	.L6
	movl	$.LC0, %edi
	call	puts
	movl	$0, %eax
	jmp	.L7
.L6:
	cmpl	$4095, -20(%rbp)
	jle	.L8
	movl	$7, -4(%rbp)
	movl	-20(%rbp), %eax
	sarl	$8, %eax
	andl	$15, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	jmp	.L7
.L8:
	cmpl	$2047, -20(%rbp)
	jle	.L9
	movl	$6, -4(%rbp)
	movl	-20(%rbp), %eax
	sarl	$7, %eax
	andl	$15, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	jmp	.L7
.L9:
	cmpl	$1023, -20(%rbp)
	jle	.L10
	movl	$5, -4(%rbp)
	movl	-20(%rbp), %eax
	sarl	$6, %eax
	andl	$15, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	jmp	.L7
.L10:
	cmpl	$511, -20(%rbp)
	jle	.L11
	movl	$4, -4(%rbp)
	movl	-20(%rbp), %eax
	sarl	$5, %eax
	andl	$15, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	jmp	.L7
.L11:
	cmpl	$255, -20(%rbp)
	jle	.L12
	movl	$3, -4(%rbp)
	movl	-20(%rbp), %eax
	sarl	$4, %eax
	andl	$15, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	jmp	.L7
.L12:
	cmpl	$127, -20(%rbp)
	jle	.L13
	movl	$2, -4(%rbp)
	movl	-20(%rbp), %eax
	sarl	$3, %eax
	andl	$15, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	jmp	.L7
.L13:
	cmpl	$63, -20(%rbp)
	jle	.L14
	movl	$1, -4(%rbp)
	movl	-20(%rbp), %eax
	sarl	$2, %eax
	andl	$15, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	jmp	.L7
.L14:
	cmpl	$31, -20(%rbp)
	jle	.L15
	movl	$0, -4(%rbp)
	movl	-20(%rbp), %eax
	sarl	%eax
	andl	$15, %eax
	movl	%eax, -8(%rbp)
	movl	-24(%rbp), %eax
	sall	$7, %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %eax
	jmp	.L7
.L15:
	movl	$0, %eax
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	codeword_compression, .-codeword_compression
	.globl	codeword_decompression
	.type	codeword_decompression, @function
codeword_decompression:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -36(%rbp)
	movl	-36(%rbp), %eax
	sall	$6, %eax
	andl	$8192, %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	sete	%al
	movzbl	%al, %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	sall	$13, %eax
	andl	$8192, %eax
	movl	%eax, -8(%rbp)
	movl	-36(%rbp), %eax
	andl	$15, %eax
	movl	%eax, -12(%rbp)
	movl	-36(%rbp), %eax
	sarl	$4, %eax
	andl	$7, %eax
	movl	%eax, -16(%rbp)
	movl	-16(%rbp), %eax
	addl	$1, %eax
	movl	-12(%rbp), %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	movl	%eax, -20(%rbp)
	movl	-16(%rbp), %eax
	movl	$33, %edx
	movl	%eax, %ecx
	sall	%cl, %edx
	movl	%edx, %eax
	movl	%eax, -24(%rbp)
	movl	-20(%rbp), %eax
	movl	-24(%rbp), %edx
	orl	%edx, %eax
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl	-8(%rbp), %edx
	orl	%edx, %eax
	movl	%eax, -32(%rbp)
	movl	-32(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	codeword_decompression, .-codeword_decompression
	.globl	signum
	.type	signum, @function
signum:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	cmpl	$8192, -4(%rbp)
	jle	.L20
	movl	$1, %eax
	jmp	.L21
.L20:
	movl	$0, %eax
.L21:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	signum, .-signum
	.globl	magnitude
	.type	magnitude, @function
magnitude:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	cmpl	$8192, -4(%rbp)
	jle	.L25
	andl	$8191, -4(%rbp)
.L25:
	movl	-4(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	magnitude, .-magnitude
	.section	.rodata
.LC1:
	.string	"\n<Testing.."
.LC2:
	.string	"\nInput: %d | "
.LC3:
	.string	"\nCompressed: %d | "
.LC4:
	.string	"\nDecompressed: %d | "
	.text
	.globl	Test
	.type	Test, @function
Test:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movl	%edi, -36(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	signum
	movl	%eax, %ebx
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	magnitude
	movl	%ebx, %esi
	movl	%eax, %edi
	call	codeword_compression
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	codeword_decompression
	movl	%eax, -24(%rbp)
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	movl	-36(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movl	-36(%rbp), %eax
	movl	%eax, %edi
	call	decToBinary
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	decToBinary
	movl	-24(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	-24(%rbp), %eax
	movl	%eax, %edi
	call	decToBinary
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	Test, .-Test
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-44)"
	.section	.note.GNU-stack,"",@progbits
