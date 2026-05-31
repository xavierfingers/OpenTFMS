	.file	"test.c"
	.text
	.def	fast_log;	.scl	3;	.type	32;	.endef
	.seh_proc	fast_log
fast_log:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	%ecx, 16(%rbp)
	movl	16(%rbp), %eax
	sarl	$23, %eax
	movzbl	%al, %eax
	subl	$127, %eax
	movl	%eax, -8(%rbp)
	pxor	%xmm3, %xmm3
	cvtsi2sdl	16(%rbp), %xmm3
	movq	%xmm3, %rax
	leaq	-8(%rbp), %rdx
	movq	%rax, %xmm0
	call	frexp
	cvtsd2ss	%xmm0, %xmm0
	movss	%xmm0, -4(%rbp)
	movl	-4(%rbp), %eax
	movd	%eax, %xmm0
	call	logf
	pxor	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	movl	-8(%rbp), %eax
	pxor	%xmm2, %xmm2
	cvtsi2sdl	%eax, %xmm2
	movsd	.LC0(%rip), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	cvtsd2ss	%xmm0, %xmm0
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "Log(%d) = %f\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
	call	__main
	movq	16(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	call	fast_log
	cvtss2sd	%xmm0, %xmm0
	movapd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	movq	%xmm1, %rdx
	movl	-4(%rbp), %eax
	leaq	.LC1(%rip), %rcx
	movapd	%xmm0, %xmm2
	movq	%rdx, %r8
	movl	%eax, %edx
	call	__mingw_printf
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.long	-1643495006
	.long	1072049730
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (Rev8, Built by MSYS2 project) 15.2.0"
	.def	frexp;	.scl	2;	.type	32;	.endef
	.def	logf;	.scl	2;	.type	32;	.endef
