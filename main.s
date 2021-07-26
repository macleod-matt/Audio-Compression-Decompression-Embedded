	.file	"main.c"
	.comm	start,8,8
	.comm	stop,8,8
	.comm	start2,8,8
	.comm	stop2,8,8
	.comm	compression_time,8,8
	.comm	decompression_time,8,8
	.section	.rodata
.LC0:
	.string	"No wave file specified"
.LC2:
	.string	"Complete"
	.align 8
.LC3:
	.string	"Audio Compression Time Using Mu Law:%lf  Seconds\n"
	.align 8
.LC4:
	.string	"Audio Decompression Time: %lf  Seconds \n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$1096, %rsp
	.cfi_offset 3, -24
	movl	%edi, -1076(%rbp)
	movq	%rsi, -1088(%rbp)
	movl	$1024, %edi
	call	malloc
	movq	%rax, -24(%rbp)
	movl	$1024, %edi
	call	malloc
	movq	%rax, -32(%rbp)
	movl	$1024, %edi
	call	malloc
	movq	%rax, -40(%rbp)
	leaq	-1072(%rbp), %rax
	movl	$1024, %esi
	movq	%rax, %rdi
	call	getcwd
	testq	%rax, %rax
	je	.L2
	leaq	-1072(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy
	leaq	-1072(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy
	leaq	-1072(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy
	cmpl	$1, -1076(%rbp)
	jg	.L3
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	jmp	.L5
.L3:
	movq	-24(%rbp), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movw	$47, (%rax)
	movq	-1088(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat
	movq	-32(%rbp), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$8315178114207408943, %rbx
	movq	%rbx, (%rax)
	movabsq	$33321211759191411, %rbx
	movq	%rbx, 8(%rax)
	movq	-40(%rbp), %rax
	movq	$-1, %rcx
	movq	%rax, %rdx
	movl	$0, %eax
	movq	%rdx, %rdi
	repnz scasb
	movq	%rcx, %rax
	notq	%rax
	leaq	-1(%rax), %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$8246211242891764783, %rbx
	movq	%rbx, (%rax)
	movabsq	$7023133152641250149, %rbx
	movq	%rbx, 8(%rax)
	movw	$118, 16(%rax)
	call	clock
	movq	%rax, start(%rip)
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movl	$1, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	encode_wave_file
	call	clock
	movq	%rax, stop(%rip)
	movq	stop(%rip), %rax
	cvtsi2sdq	%rax, %xmm0
	movq	start(%rip), %rax
	cvtsi2sdq	%rax, %xmm1
	subsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, compression_time(%rip)
	call	clock
	movq	%rax, start2(%rip)
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	encode_wave_file
	call	clock
	movq	%rax, stop2(%rip)
	movq	stop(%rip), %rax
	cvtsi2sdq	%rax, %xmm0
	movq	start(%rip), %rax
	cvtsi2sdq	%rax, %xmm1
	subsd	%xmm1, %xmm0
	movsd	.LC1(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, decompression_time(%rip)
	movl	$.LC2, %edi
	call	puts
	movq	compression_time(%rip), %rax
	movq	%rax, -1096(%rbp)
	movsd	-1096(%rbp), %xmm0
	movl	$.LC3, %edi
	movl	$1, %eax
	call	printf
	movq	decompression_time(%rip), %rax
	movq	%rax, -1096(%rbp)
	movsd	-1096(%rbp), %xmm0
	movl	$.LC4, %edi
	movl	$1, %eax
	call	printf
.L2:
	movl	$0, %eax
.L5:
	addq	$1096, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC1:
	.long	0
	.long	1093567616
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-44)"
	.section	.note.GNU-stack,"",@progbits
