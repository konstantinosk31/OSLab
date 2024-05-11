	.file	"simplesync.c"
	.text
.Ltext0:
	.file 0 "/home/orion/Desktop/ntua/semester6/operating_systems/lab/OSLab/exercise2/sync" "simplesync.c"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"About to increase variable %d times\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Done increasing variable.\n"
	.text
	.p2align 4
	.globl	increase_fn
	.type	increase_fn, @function
increase_fn:
.LVL0:
.LFB23:
	.file 1 "simplesync.c"
	.loc 1 42 1 view -0
	.cfi_startproc
	.loc 1 43 2 view .LVU1
	.loc 1 44 2 view .LVU2
	.loc 1 42 1 is_stmt 0 view .LVU3
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 42 1 view .LVU4
	movq	%rdi, %rbx
.LVL1:
	.loc 1 46 2 is_stmt 1 view .LVU5
	movq	stderr(%rip), %rdi
.LVL2:
	.loc 1 46 2 is_stmt 0 view .LVU6
	movl	$10000000, %edx
	leaq	.LC0(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.LVL3:
	.loc 1 47 2 is_stmt 1 view .LVU7
	.loc 1 47 16 discriminator 1 view .LVU8
	.loc 1 46 2 is_stmt 0 view .LVU9
	movl	$10000000, %eax
.LVL4:
	.p2align 4,,10
	.p2align 3
.L2:
	.loc 1 48 3 is_stmt 1 view .LVU10
	.loc 1 51 4 view .LVU11
	lock addl	$1, (%rbx)
	.loc 1 47 22 discriminator 2 view .LVU12
	.loc 1 47 16 discriminator 1 view .LVU13
	.loc 1 48 3 view .LVU14
	.loc 1 51 4 view .LVU15
	lock addl	$1, (%rbx)
	.loc 1 47 22 discriminator 2 view .LVU16
	.loc 1 47 16 discriminator 1 view .LVU17
	subl	$2, %eax
	jne	.L2
	.loc 1 60 2 view .LVU18
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC1(%rip), %rdi
	call	fwrite@PLT
.LVL5:
	.loc 1 62 2 view .LVU19
	.loc 1 63 1 is_stmt 0 view .LVU20
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
.LVL6:
	.loc 1 63 1 view .LVU21
	ret
	.cfi_endproc
.LFE23:
	.size	increase_fn, .-increase_fn
	.section	.rodata.str1.8
	.align 8
.LC2:
	.string	"About to decrease variable %d times\n"
	.section	.rodata.str1.1
.LC3:
	.string	"Done decreasing variable.\n"
	.text
	.p2align 4
	.globl	decrease_fn
	.type	decrease_fn, @function
decrease_fn:
.LVL7:
.LFB24:
	.loc 1 66 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 67 2 view .LVU23
	.loc 1 68 2 view .LVU24
	.loc 1 66 1 is_stmt 0 view .LVU25
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	.loc 1 66 1 view .LVU26
	movq	%rdi, %rbx
.LVL8:
	.loc 1 70 2 is_stmt 1 view .LVU27
	movq	stderr(%rip), %rdi
.LVL9:
	.loc 1 70 2 is_stmt 0 view .LVU28
	movl	$10000000, %edx
	leaq	.LC2(%rip), %rsi
	xorl	%eax, %eax
	call	fprintf@PLT
.LVL10:
	.loc 1 71 2 is_stmt 1 view .LVU29
	.loc 1 71 16 discriminator 1 view .LVU30
	.loc 1 70 2 is_stmt 0 view .LVU31
	movl	$10000000, %eax
.LVL11:
	.p2align 4,,10
	.p2align 3
.L8:
	.loc 1 72 3 is_stmt 1 view .LVU32
	.loc 1 75 4 view .LVU33
	lock subl	$1, (%rbx)
	.loc 1 71 22 discriminator 2 view .LVU34
	.loc 1 71 16 discriminator 1 view .LVU35
	.loc 1 72 3 view .LVU36
	.loc 1 75 4 view .LVU37
	lock subl	$1, (%rbx)
	.loc 1 71 22 discriminator 2 view .LVU38
	.loc 1 71 16 discriminator 1 view .LVU39
	subl	$2, %eax
	jne	.L8
	.loc 1 84 2 view .LVU40
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
.LVL12:
	.loc 1 86 2 view .LVU41
	.loc 1 87 1 is_stmt 0 view .LVU42
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 8
.LVL13:
	.loc 1 87 1 view .LVU43
	ret
	.cfi_endproc
.LFE24:
	.size	decrease_fn, .-decrease_fn
	.section	.rodata.str1.1
.LC4:
	.string	""
.LC5:
	.string	"NOT "
.LC6:
	.string	"pthread_create"
.LC7:
	.string	"pthread_join"
.LC8:
	.string	"%sOK, val = %d.\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB9:
	.section	.text.startup,"ax",@progbits
.LHOTB9:
	.p2align 4
	.section	.text.unlikely
.Ltext_cold0:
	.section	.text.startup
	.globl	main
	.type	main, @function
main:
.LVL14:
.LFB25:
	.loc 1 91 1 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 91 1 is_stmt 0 view .LVU45
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	.loc 1 103 8 view .LVU46
	xorl	%esi, %esi
.LVL15:
	.loc 1 103 8 view .LVU47
	leaq	increase_fn(%rip), %rdx
	.loc 1 91 1 view .LVU48
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	.loc 1 91 1 view .LVU49
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	.loc 1 92 2 is_stmt 1 view .LVU50
	.loc 1 93 2 view .LVU51
	.loc 1 98 2 view .LVU52
	.loc 1 103 8 is_stmt 0 view .LVU53
	leaq	4(%rsp), %rbp
	leaq	8(%rsp), %rdi
.LVL16:
	.loc 1 98 6 view .LVU54
	movl	$0, 4(%rsp)
	.loc 1 103 2 is_stmt 1 view .LVU55
	.loc 1 103 8 is_stmt 0 view .LVU56
	movq	%rbp, %rcx
	call	pthread_create@PLT
.LVL17:
	.loc 1 104 2 is_stmt 1 view .LVU57
	.loc 1 104 5 is_stmt 0 view .LVU58
	testl	%eax, %eax
	jne	.L26
	.loc 1 108 2 is_stmt 1 view .LVU59
	.loc 1 108 8 is_stmt 0 view .LVU60
	leaq	16(%rsp), %rdi
	movq	%rbp, %rcx
	leaq	decrease_fn(%rip), %rdx
	xorl	%esi, %esi
	call	pthread_create@PLT
.LVL18:
	.loc 1 108 8 view .LVU61
	movl	%eax, %ebx
.LVL19:
	.loc 1 109 2 is_stmt 1 view .LVU62
	.loc 1 109 5 is_stmt 0 view .LVU63
	testl	%eax, %eax
	jne	.L27
	.loc 1 117 2 is_stmt 1 view .LVU64
	.loc 1 117 8 is_stmt 0 view .LVU65
	movq	8(%rsp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
.LVL20:
	.loc 1 117 8 view .LVU66
	movl	%eax, %ebx
.LVL21:
	.loc 1 118 2 is_stmt 1 view .LVU67
	.loc 1 118 5 is_stmt 0 view .LVU68
	testl	%eax, %eax
	jne	.L28
.LVL22:
.L15:
	.loc 1 119 3 is_stmt 1 discriminator 1 view .LVU69
	.loc 1 120 2 view .LVU70
	.loc 1 120 8 is_stmt 0 view .LVU71
	movq	16(%rsp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
.LVL23:
	movl	%eax, %ebx
.LVL24:
	.loc 1 121 2 is_stmt 1 view .LVU72
	.loc 1 121 5 is_stmt 0 view .LVU73
	testl	%eax, %eax
	jne	.L29
.LVL25:
.L16:
	.loc 1 122 3 is_stmt 1 discriminator 1 view .LVU74
	.loc 1 127 2 view .LVU75
	.loc 1 127 12 is_stmt 0 view .LVU76
	movl	4(%rsp), %edx
	xorl	%ebx, %ebx
.LVL26:
	.loc 1 129 2 discriminator 1 view .LVU77
	leaq	.LC4(%rip), %rax
	leaq	.LC5(%rip), %rsi
	.loc 1 129 2 discriminator 4 view .LVU78
	leaq	.LC8(%rip), %rdi
	.loc 1 127 12 view .LVU79
	testl	%edx, %edx
	.loc 1 129 2 discriminator 1 view .LVU80
	cmove	%rax, %rsi
	.loc 1 127 12 view .LVU81
	sete	%bl
.LVL27:
	.loc 1 129 2 is_stmt 1 view .LVU82
	.loc 1 129 2 is_stmt 0 discriminator 4 view .LVU83
	xorl	%eax, %eax
	call	printf@PLT
.LVL28:
	.loc 1 131 2 is_stmt 1 view .LVU84
	.loc 1 132 1 is_stmt 0 view .LVU85
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L31
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	%ebx, %eax
.LVL29:
	.loc 1 132 1 view .LVU86
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.LVL30:
.L31:
	.cfi_restore_state
	.loc 1 132 1 view .LVU87
	call	__stack_chk_fail@PLT
.LVL31:
	.loc 1 132 1 view .LVU88
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB25:
.L29:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	.loc 1 122 3 is_stmt 1 view -0
	.loc 1 122 3 view .LVU90
	call	__errno_location@PLT
.LVL32:
	.loc 1 122 3 is_stmt 0 discriminator 1 view .LVU91
	leaq	.LC7(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 122 3 is_stmt 1 discriminator 1 view .LVU92
	call	perror@PLT
.LVL33:
	jmp	.L16
.LVL34:
.L28:
	.loc 1 119 3 view .LVU93
	.loc 1 119 3 view .LVU94
	call	__errno_location@PLT
.LVL35:
	.loc 1 119 3 is_stmt 0 discriminator 1 view .LVU95
	leaq	.LC7(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 119 3 is_stmt 1 discriminator 1 view .LVU96
	call	perror@PLT
.LVL36:
	jmp	.L15
.LVL37:
.L27:
	.loc 1 110 3 view .LVU97
	.loc 1 110 3 view .LVU98
	call	__errno_location@PLT
.LVL38:
	.loc 1 110 3 is_stmt 0 discriminator 1 view .LVU99
	leaq	.LC6(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 110 3 is_stmt 1 discriminator 1 view .LVU100
	call	perror@PLT
.LVL39:
	.loc 1 110 3 discriminator 2 view .LVU101
	.loc 1 111 3 view .LVU102
	movl	$1, %edi
	call	exit@PLT
.LVL40:
.L26:
	.loc 1 111 3 is_stmt 0 view .LVU103
	movl	%eax, %ebx
	.loc 1 105 3 is_stmt 1 view .LVU104
	.loc 1 105 3 view .LVU105
	call	__errno_location@PLT
.LVL41:
	.loc 1 105 3 is_stmt 0 discriminator 1 view .LVU106
	leaq	.LC6(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 105 3 is_stmt 1 discriminator 1 view .LVU107
	call	perror@PLT
.LVL42:
	.loc 1 105 3 discriminator 2 view .LVU108
	.loc 1 106 3 view .LVU109
	movl	$1, %edi
	call	exit@PLT
.LVL43:
	.cfi_endproc
.LFE25:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE9:
	.section	.text.startup
.LHOTE9:
	.globl	mut
	.bss
	.align 32
	.type	mut, @object
	.size	mut, 40
mut:
	.zero	40
	.text
.Letext0:
	.section	.text.unlikely
.Letext_cold0:
	.file 2 "/usr/lib/gcc/x86_64-pc-linux-gnu/14.1.1/include/stddef.h"
	.file 3 "/usr/include/bits/types.h"
	.file 4 "/usr/include/bits/types/struct_FILE.h"
	.file 5 "/usr/include/bits/types/FILE.h"
	.file 6 "/usr/include/bits/thread-shared-types.h"
	.file 7 "/usr/include/bits/struct_mutex.h"
	.file 8 "/usr/include/bits/pthreadtypes.h"
	.file 9 "/usr/include/stdio.h"
	.file 10 "/usr/include/pthread.h"
	.file 11 "/usr/include/stdlib.h"
	.file 12 "/usr/include/errno.h"
	.file 13 "<built-in>"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x857
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x19
	.long	.LASF78
	.byte	0x1d
	.long	.LASF0
	.long	.LASF1
	.long	.LLRL11
	.quad	0
	.long	.Ldebug_line0
	.uleb128 0x7
	.long	.LASF9
	.byte	0x2
	.byte	0xd6
	.byte	0x17
	.long	0x36
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF2
	.uleb128 0x6
	.byte	0x4
	.byte	0x7
	.long	.LASF3
	.uleb128 0x1a
	.byte	0x8
	.uleb128 0xd
	.long	0x44
	.uleb128 0x6
	.byte	0x1
	.byte	0x8
	.long	.LASF4
	.uleb128 0x6
	.byte	0x2
	.byte	0x7
	.long	.LASF5
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF6
	.uleb128 0x6
	.byte	0x2
	.byte	0x5
	.long	.LASF7
	.uleb128 0x1b
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x1c
	.long	0x67
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF8
	.uleb128 0x7
	.long	.LASF10
	.byte	0x3
	.byte	0x98
	.byte	0x19
	.long	0x73
	.uleb128 0x7
	.long	.LASF11
	.byte	0x3
	.byte	0x99
	.byte	0x1b
	.long	0x73
	.uleb128 0x3
	.long	0x97
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF12
	.uleb128 0x12
	.long	0x97
	.uleb128 0xe
	.long	.LASF48
	.byte	0xd8
	.byte	0x4
	.byte	0x31
	.byte	0x8
	.long	0x22a
	.uleb128 0x1
	.long	.LASF13
	.byte	0x4
	.byte	0x33
	.byte	0x7
	.long	0x67
	.byte	0
	.uleb128 0x1
	.long	.LASF14
	.byte	0x4
	.byte	0x36
	.byte	0x9
	.long	0x92
	.byte	0x8
	.uleb128 0x1
	.long	.LASF15
	.byte	0x4
	.byte	0x37
	.byte	0x9
	.long	0x92
	.byte	0x10
	.uleb128 0x1
	.long	.LASF16
	.byte	0x4
	.byte	0x38
	.byte	0x9
	.long	0x92
	.byte	0x18
	.uleb128 0x1
	.long	.LASF17
	.byte	0x4
	.byte	0x39
	.byte	0x9
	.long	0x92
	.byte	0x20
	.uleb128 0x1
	.long	.LASF18
	.byte	0x4
	.byte	0x3a
	.byte	0x9
	.long	0x92
	.byte	0x28
	.uleb128 0x1
	.long	.LASF19
	.byte	0x4
	.byte	0x3b
	.byte	0x9
	.long	0x92
	.byte	0x30
	.uleb128 0x1
	.long	.LASF20
	.byte	0x4
	.byte	0x3c
	.byte	0x9
	.long	0x92
	.byte	0x38
	.uleb128 0x1
	.long	.LASF21
	.byte	0x4
	.byte	0x3d
	.byte	0x9
	.long	0x92
	.byte	0x40
	.uleb128 0x1
	.long	.LASF22
	.byte	0x4
	.byte	0x40
	.byte	0x9
	.long	0x92
	.byte	0x48
	.uleb128 0x1
	.long	.LASF23
	.byte	0x4
	.byte	0x41
	.byte	0x9
	.long	0x92
	.byte	0x50
	.uleb128 0x1
	.long	.LASF24
	.byte	0x4
	.byte	0x42
	.byte	0x9
	.long	0x92
	.byte	0x58
	.uleb128 0x1
	.long	.LASF25
	.byte	0x4
	.byte	0x44
	.byte	0x16
	.long	0x243
	.byte	0x60
	.uleb128 0x1
	.long	.LASF26
	.byte	0x4
	.byte	0x46
	.byte	0x14
	.long	0x248
	.byte	0x68
	.uleb128 0x1
	.long	.LASF27
	.byte	0x4
	.byte	0x48
	.byte	0x7
	.long	0x67
	.byte	0x70
	.uleb128 0x1
	.long	.LASF28
	.byte	0x4
	.byte	0x49
	.byte	0x7
	.long	0x67
	.byte	0x74
	.uleb128 0x1
	.long	.LASF29
	.byte	0x4
	.byte	0x4a
	.byte	0xb
	.long	0x7a
	.byte	0x78
	.uleb128 0x1
	.long	.LASF30
	.byte	0x4
	.byte	0x4d
	.byte	0x12
	.long	0x52
	.byte	0x80
	.uleb128 0x1
	.long	.LASF31
	.byte	0x4
	.byte	0x4e
	.byte	0xf
	.long	0x59
	.byte	0x82
	.uleb128 0x1
	.long	.LASF32
	.byte	0x4
	.byte	0x4f
	.byte	0x8
	.long	0x24d
	.byte	0x83
	.uleb128 0x1
	.long	.LASF33
	.byte	0x4
	.byte	0x51
	.byte	0xf
	.long	0x25d
	.byte	0x88
	.uleb128 0x1
	.long	.LASF34
	.byte	0x4
	.byte	0x59
	.byte	0xd
	.long	0x86
	.byte	0x90
	.uleb128 0x1
	.long	.LASF35
	.byte	0x4
	.byte	0x5b
	.byte	0x17
	.long	0x267
	.byte	0x98
	.uleb128 0x1
	.long	.LASF36
	.byte	0x4
	.byte	0x5c
	.byte	0x19
	.long	0x271
	.byte	0xa0
	.uleb128 0x1
	.long	.LASF37
	.byte	0x4
	.byte	0x5d
	.byte	0x14
	.long	0x248
	.byte	0xa8
	.uleb128 0x1
	.long	.LASF38
	.byte	0x4
	.byte	0x5e
	.byte	0x9
	.long	0x44
	.byte	0xb0
	.uleb128 0x1
	.long	.LASF39
	.byte	0x4
	.byte	0x5f
	.byte	0xa
	.long	0x2a
	.byte	0xb8
	.uleb128 0x1
	.long	.LASF40
	.byte	0x4
	.byte	0x60
	.byte	0x7
	.long	0x67
	.byte	0xc0
	.uleb128 0x1
	.long	.LASF41
	.byte	0x4
	.byte	0x62
	.byte	0x8
	.long	0x276
	.byte	0xc4
	.byte	0
	.uleb128 0x7
	.long	.LASF42
	.byte	0x5
	.byte	0x7
	.byte	0x19
	.long	0xa3
	.uleb128 0x1d
	.long	.LASF79
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0xf
	.long	.LASF43
	.uleb128 0x3
	.long	0x23e
	.uleb128 0x3
	.long	0xa3
	.uleb128 0xb
	.long	0x97
	.long	0x25d
	.uleb128 0xc
	.long	0x36
	.byte	0
	.byte	0
	.uleb128 0x3
	.long	0x236
	.uleb128 0xf
	.long	.LASF44
	.uleb128 0x3
	.long	0x262
	.uleb128 0xf
	.long	.LASF45
	.uleb128 0x3
	.long	0x26c
	.uleb128 0xb
	.long	0x97
	.long	0x286
	.uleb128 0xc
	.long	0x36
	.byte	0x13
	.byte	0
	.uleb128 0x3
	.long	0x9e
	.uleb128 0x3
	.long	0x22a
	.uleb128 0x1e
	.long	.LASF68
	.byte	0x9
	.byte	0x97
	.byte	0xe
	.long	0x28b
	.uleb128 0x6
	.byte	0x8
	.byte	0x5
	.long	.LASF46
	.uleb128 0x6
	.byte	0x8
	.byte	0x7
	.long	.LASF47
	.uleb128 0xe
	.long	.LASF49
	.byte	0x10
	.byte	0x6
	.byte	0x33
	.byte	0x10
	.long	0x2d2
	.uleb128 0x1
	.long	.LASF50
	.byte	0x6
	.byte	0x35
	.byte	0x23
	.long	0x2d2
	.byte	0
	.uleb128 0x1
	.long	.LASF51
	.byte	0x6
	.byte	0x36
	.byte	0x23
	.long	0x2d2
	.byte	0x8
	.byte	0
	.uleb128 0x3
	.long	0x2aa
	.uleb128 0x7
	.long	.LASF52
	.byte	0x6
	.byte	0x37
	.byte	0x3
	.long	0x2aa
	.uleb128 0xe
	.long	.LASF53
	.byte	0x28
	.byte	0x7
	.byte	0x16
	.byte	0x8
	.long	0x359
	.uleb128 0x1
	.long	.LASF54
	.byte	0x7
	.byte	0x18
	.byte	0x7
	.long	0x67
	.byte	0
	.uleb128 0x1
	.long	.LASF55
	.byte	0x7
	.byte	0x19
	.byte	0x10
	.long	0x3d
	.byte	0x4
	.uleb128 0x1
	.long	.LASF56
	.byte	0x7
	.byte	0x1a
	.byte	0x7
	.long	0x67
	.byte	0x8
	.uleb128 0x1
	.long	.LASF57
	.byte	0x7
	.byte	0x1c
	.byte	0x10
	.long	0x3d
	.byte	0xc
	.uleb128 0x1
	.long	.LASF58
	.byte	0x7
	.byte	0x20
	.byte	0x7
	.long	0x67
	.byte	0x10
	.uleb128 0x1
	.long	.LASF59
	.byte	0x7
	.byte	0x22
	.byte	0x9
	.long	0x60
	.byte	0x14
	.uleb128 0x1
	.long	.LASF60
	.byte	0x7
	.byte	0x23
	.byte	0x9
	.long	0x60
	.byte	0x16
	.uleb128 0x1
	.long	.LASF61
	.byte	0x7
	.byte	0x24
	.byte	0x14
	.long	0x2d7
	.byte	0x18
	.byte	0
	.uleb128 0x7
	.long	.LASF62
	.byte	0x8
	.byte	0x1b
	.byte	0x1b
	.long	0x36
	.uleb128 0x1f
	.long	.LASF65
	.byte	0x38
	.byte	0x8
	.byte	0x38
	.byte	0x7
	.long	0x389
	.uleb128 0x9
	.long	.LASF63
	.byte	0x3a
	.byte	0x8
	.long	0x389
	.uleb128 0x9
	.long	.LASF64
	.byte	0x3b
	.byte	0xc
	.long	0x73
	.byte	0
	.uleb128 0xb
	.long	0x97
	.long	0x399
	.uleb128 0xc
	.long	0x36
	.byte	0x37
	.byte	0
	.uleb128 0x7
	.long	.LASF65
	.byte	0x8
	.byte	0x3e
	.byte	0x1e
	.long	0x365
	.uleb128 0x12
	.long	0x399
	.uleb128 0x20
	.byte	0x28
	.byte	0x8
	.byte	0x43
	.byte	0x9
	.long	0x3d5
	.uleb128 0x9
	.long	.LASF66
	.byte	0x45
	.byte	0x1c
	.long	0x2e3
	.uleb128 0x9
	.long	.LASF63
	.byte	0x46
	.byte	0x8
	.long	0x3d5
	.uleb128 0x9
	.long	.LASF64
	.byte	0x47
	.byte	0xc
	.long	0x73
	.byte	0
	.uleb128 0xb
	.long	0x97
	.long	0x3e5
	.uleb128 0xc
	.long	0x36
	.byte	0x27
	.byte	0
	.uleb128 0x7
	.long	.LASF67
	.byte	0x8
	.byte	0x48
	.byte	0x3
	.long	0x3aa
	.uleb128 0x3
	.long	0x92
	.uleb128 0x21
	.string	"mut"
	.byte	0x1
	.byte	0x27
	.byte	0x11
	.long	0x3e5
	.uleb128 0x9
	.byte	0x3
	.quad	mut
	.uleb128 0x13
	.long	.LASF69
	.value	0x16b
	.long	0x67
	.long	0x422
	.uleb128 0x4
	.long	0x286
	.uleb128 0x14
	.byte	0
	.uleb128 0x15
	.long	.LASF70
	.byte	0xdb
	.long	0x67
	.long	0x43b
	.uleb128 0x4
	.long	0x359
	.uleb128 0x4
	.long	0x43b
	.byte	0
	.uleb128 0x3
	.long	0x44
	.uleb128 0x22
	.long	.LASF71
	.byte	0xb
	.value	0x2f4
	.byte	0xd
	.long	0x453
	.uleb128 0x4
	.long	0x67
	.byte	0
	.uleb128 0x23
	.long	.LASF80
	.byte	0x9
	.value	0x36e
	.byte	0xd
	.long	0x466
	.uleb128 0x4
	.long	0x286
	.byte	0
	.uleb128 0x24
	.long	.LASF81
	.byte	0xc
	.byte	0x25
	.byte	0xd
	.long	0x472
	.uleb128 0x3
	.long	0x67
	.uleb128 0x15
	.long	.LASF72
	.byte	0xca
	.long	0x67
	.long	0x49a
	.uleb128 0x4
	.long	0x49f
	.uleb128 0x4
	.long	0x4a9
	.uleb128 0x4
	.long	0x4ae
	.uleb128 0x4
	.long	0x46
	.byte	0
	.uleb128 0x3
	.long	0x359
	.uleb128 0xd
	.long	0x49a
	.uleb128 0x3
	.long	0x3a5
	.uleb128 0xd
	.long	0x4a4
	.uleb128 0x3
	.long	0x4b3
	.uleb128 0x25
	.long	0x44
	.long	0x4c2
	.uleb128 0x4
	.long	0x44
	.byte	0
	.uleb128 0x13
	.long	.LASF73
	.value	0x165
	.long	0x67
	.long	0x4dd
	.uleb128 0x4
	.long	0x28b
	.uleb128 0x4
	.long	0x286
	.uleb128 0x14
	.byte	0
	.uleb128 0x26
	.long	.LASF82
	.byte	0x1
	.byte	0x5a
	.byte	0x5
	.long	0x67
	.long	.LLRL6
	.uleb128 0x1
	.byte	0x9c
	.long	0x6fb
	.uleb128 0x16
	.long	.LASF74
	.byte	0x5a
	.byte	0xe
	.long	0x67
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x16
	.long	.LASF75
	.byte	0x5a
	.byte	0x1a
	.long	0x3f1
	.long	.LLST8
	.long	.LVUS8
	.uleb128 0x10
	.string	"val"
	.byte	0x5c
	.byte	0x6
	.long	0x67
	.uleb128 0x2
	.byte	0x91
	.sleb128 -60
	.uleb128 0x8
	.string	"ret"
	.byte	0x5c
	.byte	0xb
	.long	0x67
	.long	.LLST9
	.long	.LVUS9
	.uleb128 0x8
	.string	"ok"
	.byte	0x5c
	.byte	0x10
	.long	0x67
	.long	.LLST10
	.long	.LVUS10
	.uleb128 0x10
	.string	"t1"
	.byte	0x5d
	.byte	0xc
	.long	0x359
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x10
	.string	"t2"
	.byte	0x5d
	.byte	0x10
	.long	0x359
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x5
	.quad	.LVL17
	.long	0x477
	.long	0x596
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	increase_fn
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x5
	.quad	.LVL18
	.long	0x477
	.long	0x5c6
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x9
	.byte	0x3
	.quad	decrease_fn
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x52
	.uleb128 0x2
	.byte	0x76
	.sleb128 0
	.byte	0
	.uleb128 0x5
	.quad	.LVL20
	.long	0x422
	.long	0x5dd
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x5
	.quad	.LVL23
	.long	0x422
	.long	0x5f4
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x5
	.quad	.LVL28
	.long	0x40c
	.long	0x613
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC8
	.byte	0
	.uleb128 0xa
	.quad	.LVL31
	.long	0x846
	.uleb128 0xa
	.quad	.LVL32
	.long	0x466
	.uleb128 0x5
	.quad	.LVL33
	.long	0x453
	.long	0x64c
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.byte	0
	.uleb128 0xa
	.quad	.LVL35
	.long	0x466
	.uleb128 0x5
	.quad	.LVL36
	.long	0x453
	.long	0x678
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC7
	.byte	0
	.uleb128 0xa
	.quad	.LVL38
	.long	0x466
	.uleb128 0x5
	.quad	.LVL39
	.long	0x453
	.long	0x6a4
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.byte	0
	.uleb128 0x5
	.quad	.LVL40
	.long	0x440
	.long	0x6bb
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.uleb128 0xa
	.quad	.LVL41
	.long	0x466
	.uleb128 0x5
	.quad	.LVL42
	.long	0x453
	.long	0x6e7
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
	.byte	0
	.uleb128 0x11
	.quad	.LVL43
	.long	0x440
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.byte	0
	.uleb128 0x17
	.long	.LASF76
	.byte	0x41
	.long	0x44
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x79e
	.uleb128 0x18
	.string	"arg"
	.byte	0x41
	.long	0x44
	.long	.LLST3
	.long	.LVUS3
	.uleb128 0x8
	.string	"i"
	.byte	0x43
	.byte	0x6
	.long	0x67
	.long	.LLST4
	.long	.LVUS4
	.uleb128 0x8
	.string	"ip"
	.byte	0x44
	.byte	0x10
	.long	0x79e
	.long	.LLST5
	.long	.LVUS5
	.uleb128 0x5
	.quad	.LVL10
	.long	0x4c2
	.long	0x778
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0xc
	.long	0x989680
	.byte	0
	.uleb128 0x11
	.quad	.LVL12
	.long	0x84f
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC3
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x4a
	.byte	0
	.byte	0
	.uleb128 0x3
	.long	0x6e
	.uleb128 0x17
	.long	.LASF77
	.byte	0x29
	.long	0x44
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x846
	.uleb128 0x18
	.string	"arg"
	.byte	0x29
	.long	0x44
	.long	.LLST0
	.long	.LVUS0
	.uleb128 0x8
	.string	"i"
	.byte	0x2b
	.byte	0x6
	.long	0x67
	.long	.LLST1
	.long	.LVUS1
	.uleb128 0x8
	.string	"ip"
	.byte	0x2c
	.byte	0x10
	.long	0x79e
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0x5
	.quad	.LVL3
	.long	0x4c2
	.long	0x820
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC0
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x5
	.byte	0xc
	.long	0x989680
	.byte	0
	.uleb128 0x11
	.quad	.LVL5
	.long	0x84f
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC1
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x31
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x1
	.byte	0x4a
	.byte	0
	.byte	0
	.uleb128 0x27
	.long	.LASF83
	.long	.LASF83
	.uleb128 0x28
	.long	.LASF84
	.long	.LASF85
	.byte	0xd
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x49
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x7e
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 9
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 12
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 10
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 12
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 7
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 25
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0x17
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x87
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x15
	.byte	0x1
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x27
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x28
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.long	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.Ldebug_loc0:
.LVUS7:
	.uleb128 0
	.uleb128 .LVU54
	.uleb128 .LVU54
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST7:
	.byte	0x6
	.quad	.LVL14
	.byte	0x4
	.uleb128 .LVL14-.LVL14
	.uleb128 .LVL16-.LVL14
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL16-.LVL14
	.uleb128 .LHOTE9-.LVL14
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0x8
	.quad	.LFSB25
	.uleb128 .LCOLDE9-.LFSB25
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS8:
	.uleb128 0
	.uleb128 .LVU47
	.uleb128 .LVU47
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST8:
	.byte	0x6
	.quad	.LVL14
	.byte	0x4
	.uleb128 .LVL14-.LVL14
	.uleb128 .LVL15-.LVL14
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL15-.LVL14
	.uleb128 .LHOTE9-.LVL14
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.byte	0x8
	.quad	.LFSB25
	.uleb128 .LCOLDE9-.LFSB25
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.byte	0
.LVUS9:
	.uleb128 .LVU57
	.uleb128 .LVU61
	.uleb128 .LVU62
	.uleb128 .LVU66
	.uleb128 .LVU66
	.uleb128 .LVU67
	.uleb128 .LVU67
	.uleb128 .LVU69
	.uleb128 .LVU69
	.uleb128 .LVU72
	.uleb128 .LVU72
	.uleb128 .LVU74
	.uleb128 .LVU74
	.uleb128 .LVU77
	.uleb128 .LVU88
	.uleb128 0
	.uleb128 0
	.uleb128 .LVU91
	.uleb128 .LVU91
	.uleb128 .LVU93
	.uleb128 .LVU93
	.uleb128 .LVU95
	.uleb128 .LVU95
	.uleb128 .LVU97
	.uleb128 .LVU97
	.uleb128 .LVU99
	.uleb128 .LVU99
	.uleb128 .LVU103
	.uleb128 .LVU103
	.uleb128 .LVU106
	.uleb128 .LVU106
	.uleb128 0
.LLST9:
	.byte	0x6
	.quad	.LVL17
	.byte	0x4
	.uleb128 .LVL17-.LVL17
	.uleb128 .LVL18-1-.LVL17
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL19-.LVL17
	.uleb128 .LVL20-1-.LVL17
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL20-1-.LVL17
	.uleb128 .LVL21-.LVL17
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL21-.LVL17
	.uleb128 .LVL22-.LVL17
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL22-.LVL17
	.uleb128 .LVL24-.LVL17
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL24-.LVL17
	.uleb128 .LVL25-.LVL17
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL25-.LVL17
	.uleb128 .LVL26-.LVL17
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL31-.LVL17
	.uleb128 .LHOTE9-.LVL17
	.uleb128 0x1
	.byte	0x50
	.byte	0x6
	.quad	.LFSB25
	.byte	0x4
	.uleb128 .LFSB25-.LFSB25
	.uleb128 .LVL32-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL32-1-.LFSB25
	.uleb128 .LVL34-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL34-.LFSB25
	.uleb128 .LVL35-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL35-1-.LFSB25
	.uleb128 .LVL37-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL37-.LFSB25
	.uleb128 .LVL38-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL38-1-.LFSB25
	.uleb128 .LVL40-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL40-.LFSB25
	.uleb128 .LVL41-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL41-1-.LFSB25
	.uleb128 .LFE25-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0
.LVUS10:
	.uleb128 .LVU82
	.uleb128 .LVU86
	.uleb128 .LVU86
	.uleb128 .LVU87
	.uleb128 .LVU87
	.uleb128 .LVU88
.LLST10:
	.byte	0x6
	.quad	.LVL27
	.byte	0x4
	.uleb128 .LVL27-.LVL27
	.uleb128 .LVL29-.LVL27
	.uleb128 0x6
	.byte	0x73
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL29-.LVL27
	.uleb128 .LVL30-.LVL27
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL30-.LVL27
	.uleb128 .LVL31-.LVL27
	.uleb128 0x6
	.byte	0x73
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.byte	0
.LVUS3:
	.uleb128 0
	.uleb128 .LVU28
	.uleb128 .LVU28
	.uleb128 .LVU43
	.uleb128 .LVU43
	.uleb128 0
.LLST3:
	.byte	0x6
	.quad	.LVL7
	.byte	0x4
	.uleb128 .LVL7-.LVL7
	.uleb128 .LVL9-.LVL7
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL9-.LVL7
	.uleb128 .LVL13-.LVL7
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL13-.LVL7
	.uleb128 .LFE24-.LVL7
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS4:
	.uleb128 .LVU30
	.uleb128 .LVU32
.LLST4:
	.byte	0x8
	.quad	.LVL10
	.uleb128 .LVL11-.LVL10
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS5:
	.uleb128 .LVU27
	.uleb128 .LVU28
	.uleb128 .LVU28
	.uleb128 .LVU43
	.uleb128 .LVU43
	.uleb128 0
.LLST5:
	.byte	0x6
	.quad	.LVL8
	.byte	0x4
	.uleb128 .LVL8-.LVL8
	.uleb128 .LVL9-.LVL8
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL9-.LVL8
	.uleb128 .LVL13-.LVL8
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL13-.LVL8
	.uleb128 .LFE24-.LVL8
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS0:
	.uleb128 0
	.uleb128 .LVU6
	.uleb128 .LVU6
	.uleb128 .LVU21
	.uleb128 .LVU21
	.uleb128 0
.LLST0:
	.byte	0x6
	.quad	.LVL0
	.byte	0x4
	.uleb128 .LVL0-.LVL0
	.uleb128 .LVL2-.LVL0
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL2-.LVL0
	.uleb128 .LVL6-.LVL0
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL6-.LVL0
	.uleb128 .LFE23-.LVL0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS1:
	.uleb128 .LVU8
	.uleb128 .LVU10
.LLST1:
	.byte	0x8
	.quad	.LVL3
	.uleb128 .LVL4-.LVL3
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS2:
	.uleb128 .LVU5
	.uleb128 .LVU6
	.uleb128 .LVU6
	.uleb128 .LVU21
	.uleb128 .LVU21
	.uleb128 0
.LLST2:
	.byte	0x6
	.quad	.LVL1
	.byte	0x4
	.uleb128 .LVL1-.LVL1
	.uleb128 .LVL2-.LVL1
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL2-.LVL1
	.uleb128 .LVL6-.LVL1
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL6-.LVL1
	.uleb128 .LFE23-.LVL1
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.long	0x4c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	.Ltext_cold0
	.quad	.Letext_cold0-.Ltext_cold0
	.quad	.LFB25
	.quad	.LHOTE9-.LFB25
	.quad	0
	.quad	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.long	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.LLRL6:
	.byte	0x7
	.quad	.LFB25
	.uleb128 .LHOTE9-.LFB25
	.byte	0x7
	.quad	.LFSB25
	.uleb128 .LCOLDE9-.LFSB25
	.byte	0
.LLRL11:
	.byte	0x7
	.quad	.Ltext0
	.uleb128 .Letext0-.Ltext0
	.byte	0x7
	.quad	.Ltext_cold0
	.uleb128 .Letext_cold0-.Ltext_cold0
	.byte	0x7
	.quad	.LFB25
	.uleb128 .LHOTE9-.LFB25
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF81:
	.string	"__errno_location"
.LASF66:
	.string	"__data"
.LASF48:
	.string	"_IO_FILE"
.LASF24:
	.string	"_IO_save_end"
.LASF7:
	.string	"short int"
.LASF9:
	.string	"size_t"
.LASF34:
	.string	"_offset"
.LASF49:
	.string	"__pthread_internal_list"
.LASF18:
	.string	"_IO_write_ptr"
.LASF13:
	.string	"_flags"
.LASF67:
	.string	"pthread_mutex_t"
.LASF55:
	.string	"__count"
.LASF33:
	.string	"_lock"
.LASF64:
	.string	"__align"
.LASF25:
	.string	"_markers"
.LASF15:
	.string	"_IO_read_end"
.LASF38:
	.string	"_freeres_buf"
.LASF50:
	.string	"__prev"
.LASF51:
	.string	"__next"
.LASF42:
	.string	"FILE"
.LASF68:
	.string	"stderr"
.LASF58:
	.string	"__kind"
.LASF46:
	.string	"long long int"
.LASF70:
	.string	"pthread_join"
.LASF72:
	.string	"pthread_create"
.LASF8:
	.string	"long int"
.LASF69:
	.string	"printf"
.LASF30:
	.string	"_cur_column"
.LASF80:
	.string	"perror"
.LASF73:
	.string	"fprintf"
.LASF59:
	.string	"__spins"
.LASF75:
	.string	"argv"
.LASF71:
	.string	"exit"
.LASF29:
	.string	"_old_offset"
.LASF85:
	.string	"__builtin_fwrite"
.LASF4:
	.string	"unsigned char"
.LASF74:
	.string	"argc"
.LASF6:
	.string	"signed char"
.LASF35:
	.string	"_codecvt"
.LASF47:
	.string	"long long unsigned int"
.LASF76:
	.string	"decrease_fn"
.LASF3:
	.string	"unsigned int"
.LASF43:
	.string	"_IO_marker"
.LASF32:
	.string	"_shortbuf"
.LASF17:
	.string	"_IO_write_base"
.LASF41:
	.string	"_unused2"
.LASF14:
	.string	"_IO_read_ptr"
.LASF63:
	.string	"__size"
.LASF21:
	.string	"_IO_buf_end"
.LASF12:
	.string	"char"
.LASF57:
	.string	"__nusers"
.LASF82:
	.string	"main"
.LASF36:
	.string	"_wide_data"
.LASF37:
	.string	"_freeres_list"
.LASF78:
	.string	"GNU C17 14.1.1 20240507 -mtune=generic -march=x86-64 -g -O2"
.LASF39:
	.string	"__pad5"
.LASF54:
	.string	"__lock"
.LASF56:
	.string	"__owner"
.LASF5:
	.string	"short unsigned int"
.LASF77:
	.string	"increase_fn"
.LASF53:
	.string	"__pthread_mutex_s"
.LASF84:
	.string	"fwrite"
.LASF2:
	.string	"long unsigned int"
.LASF19:
	.string	"_IO_write_end"
.LASF11:
	.string	"__off64_t"
.LASF60:
	.string	"__elision"
.LASF27:
	.string	"_fileno"
.LASF26:
	.string	"_chain"
.LASF52:
	.string	"__pthread_list_t"
.LASF40:
	.string	"_mode"
.LASF10:
	.string	"__off_t"
.LASF23:
	.string	"_IO_backup_base"
.LASF20:
	.string	"_IO_buf_base"
.LASF28:
	.string	"_flags2"
.LASF44:
	.string	"_IO_codecvt"
.LASF16:
	.string	"_IO_read_base"
.LASF61:
	.string	"__list"
.LASF31:
	.string	"_vtable_offset"
.LASF45:
	.string	"_IO_wide_data"
.LASF22:
	.string	"_IO_save_base"
.LASF83:
	.string	"__stack_chk_fail"
.LASF65:
	.string	"pthread_attr_t"
.LASF62:
	.string	"pthread_t"
.LASF79:
	.string	"_IO_lock_t"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"simplesync.c"
.LASF1:
	.string	"/home/orion/Desktop/ntua/semester6/operating_systems/lab/OSLab/exercise2/sync"
	.ident	"GCC: (GNU) 14.1.1 20240507"
	.section	.note.GNU-stack,"",@progbits
