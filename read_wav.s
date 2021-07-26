	.file	"read_wav.c"
	.section	.rodata
.LC0:
	.string	"rb+"
.LC1:
	.string	"wb"
	.text
	.globl	encode_wave_file
	.type	encode_wave_file, @function
encode_wave_file:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$200, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -184(%rbp)
	movq	%rsi, -192(%rbp)
	movl	%edx, %eax
	movb	%al, -196(%rbp)
	movq	-184(%rbp), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -24(%rbp)
	movq	-192(%rbp), %rax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rdx
	leaq	-144(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$4, %esi
	movq	%rax, %rdi
	call	fread
	movq	-32(%rbp), %rdx
	leaq	-144(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$4, %esi
	movq	%rax, %rdi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	4(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread
	movzbl	-140(%rbp), %eax
	movzbl	%al, %eax
	movzbl	-139(%rbp), %edx
	movzbl	%dl, %edx
	sall	$8, %edx
	orl	%eax, %edx
	movzbl	-138(%rbp), %eax
	movzbl	%al, %eax
	sall	$16, %eax
	orl	%eax, %edx
	movzbl	-137(%rbp), %eax
	movzbl	%al, %eax
	sall	$24, %eax
	orl	%edx, %eax
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	subl	$36, %eax
	movl	%eax, -40(%rbp)
	movl	-40(%rbp), %eax
	shrl	%eax
	movl	%eax, -40(%rbp)
	addl	$36, -40(%rbp)
	movl	-40(%rbp), %eax
	shrl	$24, %eax
	movb	%al, -176(%rbp)
	movl	-40(%rbp), %eax
	shrl	$16, %eax
	movb	%al, -175(%rbp)
	movl	-40(%rbp), %eax
	shrl	$8, %eax
	movb	%al, -174(%rbp)
	movl	-40(%rbp), %eax
	movb	%al, -173(%rbp)
	movq	-32(%rbp), %rax
	leaq	-176(%rbp), %rdx
	leaq	3(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rax
	leaq	-176(%rbp), %rdx
	leaq	2(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rax
	leaq	-176(%rbp), %rdx
	leaq	1(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rdx
	leaq	-176(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	8(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread
	movq	-32(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	8(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	12(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread
	movq	-32(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	12(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	16(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread
	movq	-32(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	16(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	20(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$2, %esi
	call	fread
	movb	$7, -160(%rbp)
	movb	$0, -159(%rbp)
	movq	-32(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fwrite
	movq	-32(%rbp), %rax
	leaq	-160(%rbp), %rdx
	leaq	1(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	22(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$2, %esi
	call	fread
	movzbl	-122(%rbp), %eax
	movzbl	%al, %eax
	movzbl	-121(%rbp), %edx
	movzbl	%dl, %edx
	sall	$8, %edx
	orl	%edx, %eax
	movl	%eax, -44(%rbp)
	movq	-32(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	22(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$2, %esi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	24(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread
	movzbl	-120(%rbp), %eax
	movzbl	%al, %eax
	movzbl	-119(%rbp), %edx
	movzbl	%dl, %edx
	sall	$8, %edx
	orl	%eax, %edx
	movzbl	-118(%rbp), %eax
	movzbl	%al, %eax
	sall	$16, %eax
	orl	%eax, %edx
	movzbl	-117(%rbp), %eax
	movzbl	%al, %eax
	sall	$24, %eax
	orl	%edx, %eax
	movl	%eax, -48(%rbp)
	movq	-32(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	24(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	28(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread
	movl	-48(%rbp), %eax
	imull	-44(%rbp), %eax
	sall	$3, %eax
	shrl	$3, %eax
	movl	%eax, -52(%rbp)
	movl	-52(%rbp), %eax
	shrl	$24, %eax
	movb	%al, -176(%rbp)
	movl	-52(%rbp), %eax
	shrl	$16, %eax
	movb	%al, -175(%rbp)
	movl	-52(%rbp), %eax
	shrl	$8, %eax
	movb	%al, -174(%rbp)
	movl	-52(%rbp), %eax
	movb	%al, -173(%rbp)
	movq	-32(%rbp), %rax
	leaq	-176(%rbp), %rdx
	leaq	3(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rax
	leaq	-176(%rbp), %rdx
	leaq	2(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rax
	leaq	-176(%rbp), %rdx
	leaq	1(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rdx
	leaq	-176(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	32(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$2, %esi
	call	fread
	movl	-44(%rbp), %eax
	sall	$3, %eax
	shrl	$3, %eax
	movl	%eax, -56(%rbp)
	movl	-56(%rbp), %eax
	shrl	$8, %eax
	movb	%al, -160(%rbp)
	movl	-56(%rbp), %eax
	movb	%al, -159(%rbp)
	movq	-32(%rbp), %rax
	leaq	-160(%rbp), %rdx
	leaq	1(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	34(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$2, %esi
	call	fread
	movb	$8, -160(%rbp)
	movb	$0, -159(%rbp)
	movq	-32(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fwrite
	movq	-32(%rbp), %rax
	leaq	-160(%rbp), %rdx
	leaq	1(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	36(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread
	movq	-32(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	36(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fwrite
	movq	-24(%rbp), %rax
	leaq	-144(%rbp), %rdx
	leaq	40(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread
	movl	-40(%rbp), %eax
	subl	$36, %eax
	movl	%eax, -60(%rbp)
	movl	-60(%rbp), %eax
	shrl	$24, %eax
	movb	%al, -176(%rbp)
	movl	-60(%rbp), %eax
	sarl	$16, %eax
	movb	%al, -175(%rbp)
	movl	-60(%rbp), %eax
	sarl	$8, %eax
	movb	%al, -174(%rbp)
	movl	-60(%rbp), %eax
	movb	%al, -173(%rbp)
	movq	-32(%rbp), %rax
	leaq	-176(%rbp), %rdx
	leaq	3(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rax
	leaq	-176(%rbp), %rdx
	leaq	2(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rax
	leaq	-176(%rbp), %rdx
	leaq	1(%rdx), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movl	$1, %esi
	call	fwrite
	movq	-32(%rbp), %rdx
	leaq	-176(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fwrite
	subl	$36, -36(%rbp)
	movl	-36(%rbp), %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -72(%rbp)
	movl	-36(%rbp), %esi
	movq	-24(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movq	%rax, %rdi
	call	fread
	cmpb	$0, -196(%rbp)
	je	.L2
	movl	-36(%rbp), %eax
	shrl	%eax
	movl	%eax, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -80(%rbp)
	movl	$0, %ebx
	jmp	.L3
.L4:
	movslq	%ebx, %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movslq	%ebx, %rax
	leaq	1(%rax), %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	orl	%edx, %eax
	movw	%ax, -82(%rbp)
	movslq	%ebx, %rax
	leaq	2(%rax), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movslq	%ebx, %rax
	leaq	3(%rax), %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	orl	%edx, %eax
	movw	%ax, -84(%rbp)
	movslq	%ebx, %rax
	leaq	4(%rax), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movslq	%ebx, %rax
	leaq	5(%rax), %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	orl	%edx, %eax
	movw	%ax, -86(%rbp)
	movslq	%ebx, %rax
	leaq	6(%rax), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movslq	%ebx, %rax
	leaq	7(%rax), %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$8, %eax
	orl	%edx, %eax
	movw	%ax, -88(%rbp)
	movswl	-82(%rbp), %eax
	andl	$8192, %eax
	movl	%eax, %edx
	movswl	-82(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	codeword_compression
	movb	%al, -89(%rbp)
	movswl	-84(%rbp), %eax
	andl	$8192, %eax
	movl	%eax, %edx
	movswl	-84(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	codeword_compression
	movb	%al, -90(%rbp)
	movswl	-86(%rbp), %eax
	andl	$8192, %eax
	movl	%eax, %edx
	movswl	-86(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	codeword_compression
	movb	%al, -91(%rbp)
	movswl	-88(%rbp), %eax
	andl	$8192, %eax
	movl	%eax, %edx
	movswl	-88(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	codeword_compression
	movb	%al, -92(%rbp)
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	movslq	%eax, %rdx
	movq	-80(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-89(%rbp), %eax
	movb	%al, (%rdx)
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	cltq
	leaq	1(%rax), %rdx
	movq	-80(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-90(%rbp), %eax
	movb	%al, (%rdx)
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	cltq
	leaq	2(%rax), %rdx
	movq	-80(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-91(%rbp), %eax
	movb	%al, (%rdx)
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	cltq
	leaq	3(%rax), %rdx
	movq	-80(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-92(%rbp), %eax
	movb	%al, (%rdx)
	addl	$8, %ebx
.L3:
	movl	%ebx, %eax
	cmpl	-36(%rbp), %eax
	jb	.L4
	movl	-36(%rbp), %eax
	shrl	%eax
	movl	%eax, %esi
	movq	-32(%rbp), %rdx
	movq	-80(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movq	%rax, %rdi
	call	fwrite
.L2:
	movzbl	-196(%rbp), %eax
	xorl	$1, %eax
	testb	%al, %al
	je	.L5
	movl	-36(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, %eax
	movq	%rax, %rdi
	call	malloc
	movq	%rax, -80(%rbp)
	movl	$0, %ebx
	jmp	.L6
.L7:
	movslq	%ebx, %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movslq	%ebx, %rax
	leaq	1(%rax), %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$6, %eax
	orl	%edx, %eax
	movw	%ax, -82(%rbp)
	movslq	%ebx, %rax
	leaq	2(%rax), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movslq	%ebx, %rax
	leaq	3(%rax), %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$6, %eax
	orl	%edx, %eax
	movw	%ax, -84(%rbp)
	movslq	%ebx, %rax
	leaq	4(%rax), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movslq	%ebx, %rax
	leaq	5(%rax), %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$6, %eax
	orl	%edx, %eax
	movw	%ax, -86(%rbp)
	movslq	%ebx, %rax
	leaq	6(%rax), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %edx
	movslq	%ebx, %rax
	leaq	7(%rax), %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$6, %eax
	orl	%edx, %eax
	movw	%ax, -88(%rbp)
	movswl	-82(%rbp), %eax
	movl	%eax, %edi
	call	codeword_decompression
	movb	%al, -89(%rbp)
	movswl	-84(%rbp), %eax
	movl	%eax, %edi
	call	codeword_decompression
	movb	%al, -90(%rbp)
	movswl	-86(%rbp), %eax
	movl	%eax, %edi
	call	codeword_decompression
	movb	%al, -91(%rbp)
	movswl	-88(%rbp), %eax
	movl	%eax, %edi
	call	codeword_decompression
	movb	%al, -92(%rbp)
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	movslq	%eax, %rdx
	movq	-80(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-89(%rbp), %eax
	movb	%al, (%rdx)
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	cltq
	leaq	1(%rax), %rdx
	movq	-80(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-90(%rbp), %eax
	movb	%al, (%rdx)
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	cltq
	leaq	2(%rax), %rdx
	movq	-80(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-91(%rbp), %eax
	movb	%al, (%rdx)
	movl	%ebx, %eax
	shrl	$31, %eax
	addl	%ebx, %eax
	sarl	%eax
	cltq
	leaq	3(%rax), %rdx
	movq	-80(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-92(%rbp), %eax
	movb	%al, (%rdx)
	addl	$8, %ebx
.L6:
	movl	%ebx, %eax
	cmpl	-36(%rbp), %eax
	jb	.L7
	movl	-36(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, %esi
	movq	-32(%rbp), %rdx
	movq	-80(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movq	%rax, %rdi
	call	fwrite
.L5:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	movl	$0, %eax
	addq	$200, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	encode_wave_file, .-encode_wave_file
	.ident	"GCC: (GNU) 4.8.5 20150623 (Red Hat 4.8.5-44)"
	.section	.note.GNU-stack,"",@progbits
