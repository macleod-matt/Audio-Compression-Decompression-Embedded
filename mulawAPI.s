	.file	"mulawAPI.c"
	.section	.rodata
.LC0:
	.string	"%d"
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
	subq	$160, %rsp
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
	movl	-4(%rbp), %eax
	subl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	.L4
.L5:
	movl	-8(%rbp), %eax
	cltq
	movl	-144(%rbp,%rax,4), %eax
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	subl	$1, -8(%rbp)
.L4:
	cmpl	$0, -8(%rbp)
	jns	.L5
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	decToBinary, .-decToBinary
	.section	.rodata
	.align 8
.LC1:
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
	pushq	%r12
	pushq	%rbx
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movl	%edi, %eax
	movl	%esi, %edx
	testl	%edx, %edx
	sete	%dl
	movzbl	%dl, %edx
	movl	%eax, %ecx
	andl	$32, %ecx
	testl	%ecx, %ecx
	je	.L7
	movl	$0, %ebx
	sarl	%eax
	andl	$15, %eax
	movl	%eax, %r12d
	sall	$7, %edx
	movl	%ebx, %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	%r12d, %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	jmp	.L8
.L7:
	movl	%eax, %ecx
	andl	$64, %ecx
	testl	%ecx, %ecx
	je	.L9
	movl	$1, %ebx
	sarl	$2, %eax
	andl	$15, %eax
	movl	%eax, %r12d
	sall	$7, %edx
	movl	%ebx, %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	%r12d, %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	jmp	.L8
.L9:
	movl	%eax, %ecx
	andl	$128, %ecx
	testl	%ecx, %ecx
	je	.L10
	movl	$2, %ebx
	sarl	$3, %eax
	andl	$15, %eax
	movl	%eax, %r12d
	sall	$7, %edx
	movl	%ebx, %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	%r12d, %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	jmp	.L8
.L10:
	movl	%eax, %ecx
	andl	$256, %ecx
	testl	%ecx, %ecx
	je	.L11
	movl	$3, %ebx
	sarl	$4, %eax
	andl	$15, %eax
	movl	%eax, %r12d
	sall	$7, %edx
	movl	%ebx, %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	%r12d, %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	jmp	.L8
.L11:
	movl	%eax, %ecx
	andl	$512, %ecx
	testl	%ecx, %ecx
	je	.L12
	movl	$4, %ebx
	sarl	$5, %eax
	andl	$15, %eax
	movl	%eax, %r12d
	sall	$7, %edx
	movl	%ebx, %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	%r12d, %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	jmp	.L8
.L12:
	movl	%eax, %ecx
	andl	$1024, %ecx
	testl	%ecx, %ecx
	je	.L13
	movl	$5, %ebx
	sarl	$6, %eax
	andl	$15, %eax
	movl	%eax, %r12d
	sall	$7, %edx
	movl	%ebx, %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	%r12d, %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	jmp	.L8
.L13:
	movl	%eax, %ecx
	andl	$2048, %ecx
	testl	%ecx, %ecx
	je	.L14
	movl	$6, %ebx
	sarl	$7, %eax
	andl	$15, %eax
	movl	%eax, %r12d
	sall	$7, %edx
	movl	%ebx, %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	%r12d, %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	jmp	.L8
.L14:
	movl	%eax, %ecx
	andl	$4096, %ecx
	testl	%ecx, %ecx
	je	.L15
	movl	$7, %ebx
	sarl	$8, %eax
	andl	$15, %eax
	movl	%eax, %r12d
	sall	$7, %edx
	movl	%ebx, %eax
	sall	$4, %eax
	xorl	%edx, %eax
	xorl	%r12d, %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	jmp	.L8
.L15:
	cmpl	$16383, %eax
	jle	.L16
	movl	$.LC1, %edi
	call	puts
.L16:
	movl	$0, %eax
.L8:
	popq	%rbx
	popq	%r12
	popq	%rbp
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
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %eax
	sall	$6, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	jne	.L18
	movl	$8192, %eax
	jmp	.L19
.L18:
	movl	$0, %eax
.L19:
	movl	-4(%rbp), %edx
	sarl	$4, %edx
	andl	$7, %edx
	movl	$33, %esi
	movl	%edx, %ecx
	sall	%cl, %esi
	movl	-4(%rbp), %edx
	movl	%edx, %edi
	andl	$15, %edi
	movl	-4(%rbp), %edx
	sarl	$4, %edx
	andl	$7, %edx
	addl	$1, %edx
	movl	%edx, %ecx
	sall	%cl, %edi
	movl	%edi, %edx
	orl	%esi, %edx
	orl	%edx, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	codeword_decompression, .-codeword_decompression
	.section	.rodata
	.align 8
.LC2:
	.string	"\nTurn debugging to 1 in mulawAPI.h for debugging mode\n"
.LC3:
	.string	"\n<Testing.."
.LC4:
	.string	"\nInput: %d | "
.LC5:
	.string	"\nCompressed: %d | "
.LC6:
	.string	"\nDecompressed: %d | "
	.text
	.globl	Test
	.type	Test, @function
Test:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	$.LC2, %edi
	call	puts
	movl	-20(%rbp), %eax
	andl	$8192, %eax
	movl	%eax, %edx
	movl	-20(%rbp), %eax
	andl	$8192, %eax
	testl	%eax, %eax
	je	.L22
	movl	-20(%rbp), %eax
	andl	$8191, %eax
	jmp	.L23
.L22:
	movl	-20(%rbp), %eax
.L23:
	movl	%edx, %esi
	movl	%eax, %edi
	call	codeword_compression
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	codeword_decompression
	movl	%eax, -8(%rbp)
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	-20(%rbp), %eax
	movl	%eax, %edi
	call	decToBinary
	movl	-4(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	decToBinary
	movl	-8(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	movl	-8(%rbp), %eax
	movl	%eax, %edi
	call	decToBinary
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	Test, .-Test
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-44)"
	.section	.note.GNU-stack,"",@progbits