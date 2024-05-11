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
	.string	"Mutex lock error\n"
.LC2:
	.string	"Mutex unlock error\n"
.LC3:
	.string	"Done increasing variable.\n"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB4:
	.text
.LHOTB4:
	.p2align 4
	.section	.text.unlikely
.Ltext_cold0:
	.text
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
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	.loc 1 46 2 view .LVU4
	movl	$10000000, %edx
	leaq	.LC0(%rip), %rsi
	xorl	%eax, %eax
	.loc 1 42 1 view .LVU5
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
.LVL1:
	.loc 1 46 2 is_stmt 1 view .LVU6
	movq	stderr(%rip), %rdi
.LVL2:
	.loc 1 46 2 is_stmt 0 view .LVU7
	leaq	mut(%rip), %r12
	.loc 1 42 1 view .LVU8
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.loc 1 46 2 view .LVU9
	movl	$10000000, %ebx
	call	fprintf@PLT
.LVL3:
	.loc 1 47 2 is_stmt 1 view .LVU10
	.loc 1 47 16 discriminator 1 view .LVU11
	.p2align 4,,10
	.p2align 3
.L4:
	.loc 1 48 3 view .LVU12
	.loc 1 54 4 view .LVU13
	.loc 1 54 7 is_stmt 0 view .LVU14
	movq	%r12, %rdi
	call	pthread_mutex_lock@PLT
.LVL4:
	.loc 1 54 6 discriminator 1 view .LVU15
	testl	%eax, %eax
	jne	.L12
.L2:
	.loc 1 56 4 is_stmt 1 view .LVU16
	.loc 1 56 7 is_stmt 0 view .LVU17
	movl	0(%rbp), %eax
	.loc 1 57 7 view .LVU18
	movq	%r12, %rdi
	.loc 1 56 4 view .LVU19
	addl	$1, %eax
	movl	%eax, 0(%rbp)
	.loc 1 57 4 is_stmt 1 view .LVU20
	.loc 1 57 7 is_stmt 0 view .LVU21
	call	pthread_mutex_unlock@PLT
.LVL5:
	.loc 1 57 6 discriminator 1 view .LVU22
	testl	%eax, %eax
	jne	.L13
.L3:
	.loc 1 47 22 is_stmt 1 discriminator 2 view .LVU23
	.loc 1 47 16 discriminator 1 view .LVU24
	subl	$1, %ebx
	jne	.L4
	.loc 1 60 2 view .LVU25
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rdi
	call	fwrite@PLT
.LVL6:
	.loc 1 62 2 view .LVU26
	.loc 1 63 1 is_stmt 0 view .LVU27
	popq	%rbx
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
.LVL7:
	.loc 1 63 1 view .LVU28
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.LVL8:
	.loc 1 63 1 view .LVU29
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	increase_fn.cold, @function
increase_fn.cold:
.LFSB23:
.L12:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	.loc 1 54 38 is_stmt 1 discriminator 1 view -0
	leaq	.LC1(%rip), %rdi
	call	perror@PLT
.LVL9:
	jmp	.L2
.L13:
	.loc 1 57 40 discriminator 1 view .LVU31
	leaq	.LC2(%rip), %rdi
	call	perror@PLT
.LVL10:
	jmp	.L3
	.cfi_endproc
.LFE23:
	.text
	.size	increase_fn, .-increase_fn
	.section	.text.unlikely
	.size	increase_fn.cold, .-increase_fn.cold
.LCOLDE4:
	.text
.LHOTE4:
	.section	.rodata.str1.8
	.align 8
.LC5:
	.string	"About to decrease variable %d times\n"
	.section	.rodata.str1.1
.LC6:
	.string	"Done decreasing variable.\n"
	.section	.text.unlikely
.LCOLDB7:
	.text
.LHOTB7:
	.p2align 4
	.globl	decrease_fn
	.type	decrease_fn, @function
decrease_fn:
.LVL11:
.LFB24:
	.loc 1 66 1 view -0
	.cfi_startproc
	.loc 1 67 2 view .LVU33
	.loc 1 68 2 view .LVU34
	.loc 1 66 1 is_stmt 0 view .LVU35
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	.loc 1 70 2 view .LVU36
	movl	$10000000, %edx
	leaq	.LC5(%rip), %rsi
	xorl	%eax, %eax
	.loc 1 66 1 view .LVU37
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
.LVL12:
	.loc 1 70 2 is_stmt 1 view .LVU38
	movq	stderr(%rip), %rdi
.LVL13:
	.loc 1 70 2 is_stmt 0 view .LVU39
	leaq	mut(%rip), %r12
	.loc 1 66 1 view .LVU40
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.loc 1 70 2 view .LVU41
	movl	$10000000, %ebx
	call	fprintf@PLT
.LVL14:
	.loc 1 71 2 is_stmt 1 view .LVU42
	.loc 1 71 16 discriminator 1 view .LVU43
	.p2align 4,,10
	.p2align 3
.L19:
	.loc 1 72 3 view .LVU44
	.loc 1 78 4 view .LVU45
	.loc 1 78 7 is_stmt 0 view .LVU46
	movq	%r12, %rdi
	call	pthread_mutex_lock@PLT
.LVL15:
	.loc 1 78 6 discriminator 1 view .LVU47
	testl	%eax, %eax
	jne	.L27
.L17:
	.loc 1 80 4 is_stmt 1 view .LVU48
	.loc 1 80 7 is_stmt 0 view .LVU49
	movl	0(%rbp), %eax
	.loc 1 81 7 view .LVU50
	movq	%r12, %rdi
	.loc 1 80 4 view .LVU51
	subl	$1, %eax
	movl	%eax, 0(%rbp)
	.loc 1 81 4 is_stmt 1 view .LVU52
	.loc 1 81 7 is_stmt 0 view .LVU53
	call	pthread_mutex_unlock@PLT
.LVL16:
	.loc 1 81 6 discriminator 1 view .LVU54
	testl	%eax, %eax
	jne	.L28
.L18:
	.loc 1 71 22 is_stmt 1 discriminator 2 view .LVU55
	.loc 1 71 16 discriminator 1 view .LVU56
	subl	$1, %ebx
	jne	.L19
	.loc 1 84 2 view .LVU57
	movq	stderr(%rip), %rcx
	movl	$26, %edx
	movl	$1, %esi
	leaq	.LC6(%rip), %rdi
	call	fwrite@PLT
.LVL17:
	.loc 1 86 2 view .LVU58
	.loc 1 87 1 is_stmt 0 view .LVU59
	popq	%rbx
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
.LVL18:
	.loc 1 87 1 view .LVU60
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.LVL19:
	.loc 1 87 1 view .LVU61
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	decrease_fn.cold, @function
decrease_fn.cold:
.LFSB24:
.L27:
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	.loc 1 78 38 is_stmt 1 discriminator 1 view .LVU32
	leaq	.LC1(%rip), %rdi
	call	perror@PLT
.LVL20:
	jmp	.L17
.L28:
	.loc 1 81 40 discriminator 1 view .LVU63
	leaq	.LC2(%rip), %rdi
	call	perror@PLT
.LVL21:
	jmp	.L18
	.cfi_endproc
.LFE24:
	.text
	.size	decrease_fn, .-decrease_fn
	.section	.text.unlikely
	.size	decrease_fn.cold, .-decrease_fn.cold
.LCOLDE7:
	.text
.LHOTE7:
	.section	.rodata.str1.1
.LC8:
	.string	""
.LC9:
	.string	"NOT "
.LC10:
	.string	"pthread_create"
.LC11:
	.string	"pthread_join"
.LC12:
	.string	"%sOK, val = %d.\n"
	.section	.text.unlikely
.LCOLDB13:
	.section	.text.startup,"ax",@progbits
.LHOTB13:
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LVL22:
.LFB25:
	.loc 1 91 1 view -0
	.cfi_startproc
	.loc 1 91 1 is_stmt 0 view .LVU65
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	.loc 1 103 8 view .LVU66
	xorl	%esi, %esi
.LVL23:
	.loc 1 103 8 view .LVU67
	leaq	increase_fn(%rip), %rdx
	.loc 1 91 1 view .LVU68
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	.loc 1 91 1 view .LVU69
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	.loc 1 92 2 is_stmt 1 view .LVU70
	.loc 1 93 2 view .LVU71
	.loc 1 98 2 view .LVU72
	.loc 1 103 8 is_stmt 0 view .LVU73
	leaq	4(%rsp), %rbp
	leaq	8(%rsp), %rdi
.LVL24:
	.loc 1 98 6 view .LVU74
	movl	$0, 4(%rsp)
	.loc 1 103 2 is_stmt 1 view .LVU75
	.loc 1 103 8 is_stmt 0 view .LVU76
	movq	%rbp, %rcx
	call	pthread_create@PLT
.LVL25:
	.loc 1 104 2 is_stmt 1 view .LVU77
	.loc 1 104 5 is_stmt 0 view .LVU78
	testl	%eax, %eax
	jne	.L44
	.loc 1 108 2 is_stmt 1 view .LVU79
	.loc 1 108 8 is_stmt 0 view .LVU80
	leaq	16(%rsp), %rdi
	movq	%rbp, %rcx
	leaq	decrease_fn(%rip), %rdx
	xorl	%esi, %esi
	call	pthread_create@PLT
.LVL26:
	.loc 1 108 8 view .LVU81
	movl	%eax, %ebx
.LVL27:
	.loc 1 109 2 is_stmt 1 view .LVU82
	.loc 1 109 5 is_stmt 0 view .LVU83
	testl	%eax, %eax
	jne	.L45
	.loc 1 117 2 is_stmt 1 view .LVU84
	.loc 1 117 8 is_stmt 0 view .LVU85
	movq	8(%rsp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
.LVL28:
	.loc 1 117 8 view .LVU86
	movl	%eax, %ebx
.LVL29:
	.loc 1 118 2 is_stmt 1 view .LVU87
	.loc 1 118 5 is_stmt 0 view .LVU88
	testl	%eax, %eax
	jne	.L46
.LVL30:
.L33:
	.loc 1 119 3 is_stmt 1 discriminator 1 view .LVU89
	.loc 1 120 2 view .LVU90
	.loc 1 120 8 is_stmt 0 view .LVU91
	movq	16(%rsp), %rdi
	xorl	%esi, %esi
	call	pthread_join@PLT
.LVL31:
	movl	%eax, %ebx
.LVL32:
	.loc 1 121 2 is_stmt 1 view .LVU92
	.loc 1 121 5 is_stmt 0 view .LVU93
	testl	%eax, %eax
	jne	.L47
.LVL33:
.L34:
	.loc 1 122 3 is_stmt 1 discriminator 1 view .LVU94
	.loc 1 127 2 view .LVU95
	.loc 1 127 12 is_stmt 0 view .LVU96
	movl	4(%rsp), %edx
	xorl	%ebx, %ebx
.LVL34:
	.loc 1 129 2 discriminator 1 view .LVU97
	leaq	.LC8(%rip), %rax
	leaq	.LC9(%rip), %rsi
	.loc 1 129 2 discriminator 4 view .LVU98
	leaq	.LC12(%rip), %rdi
	.loc 1 127 12 view .LVU99
	testl	%edx, %edx
	.loc 1 129 2 discriminator 1 view .LVU100
	cmove	%rax, %rsi
	.loc 1 127 12 view .LVU101
	sete	%bl
.LVL35:
	.loc 1 129 2 is_stmt 1 view .LVU102
	.loc 1 129 2 is_stmt 0 discriminator 4 view .LVU103
	xorl	%eax, %eax
	call	printf@PLT
.LVL36:
	.loc 1 131 2 is_stmt 1 view .LVU104
	.loc 1 132 1 is_stmt 0 view .LVU105
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L49
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	%ebx, %eax
.LVL37:
	.loc 1 132 1 view .LVU106
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.LVL38:
.L49:
	.cfi_restore_state
	.loc 1 132 1 view .LVU107
	call	__stack_chk_fail@PLT
.LVL39:
	.loc 1 132 1 view .LVU108
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	main.cold, @function
main.cold:
.LFSB25:
.L47:
	.cfi_def_cfa_offset 64
	.cfi_offset 3, -24
	.cfi_offset 6, -16
	.loc 1 122 3 is_stmt 1 view .LVU64
	.loc 1 122 3 view .LVU110
	call	__errno_location@PLT
.LVL40:
	.loc 1 122 3 is_stmt 0 discriminator 1 view .LVU111
	leaq	.LC11(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 122 3 is_stmt 1 discriminator 1 view .LVU112
	call	perror@PLT
.LVL41:
	jmp	.L34
.LVL42:
.L46:
	.loc 1 119 3 view .LVU113
	.loc 1 119 3 view .LVU114
	call	__errno_location@PLT
.LVL43:
	.loc 1 119 3 is_stmt 0 discriminator 1 view .LVU115
	leaq	.LC11(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 119 3 is_stmt 1 discriminator 1 view .LVU116
	call	perror@PLT
.LVL44:
	jmp	.L33
.LVL45:
.L45:
	.loc 1 110 3 view .LVU117
	.loc 1 110 3 view .LVU118
	call	__errno_location@PLT
.LVL46:
	.loc 1 110 3 is_stmt 0 discriminator 1 view .LVU119
	leaq	.LC10(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 110 3 is_stmt 1 discriminator 1 view .LVU120
	call	perror@PLT
.LVL47:
	.loc 1 110 3 discriminator 2 view .LVU121
	.loc 1 111 3 view .LVU122
	movl	$1, %edi
	call	exit@PLT
.LVL48:
.L44:
	.loc 1 111 3 is_stmt 0 view .LVU123
	movl	%eax, %ebx
	.loc 1 105 3 is_stmt 1 view .LVU124
	.loc 1 105 3 view .LVU125
	call	__errno_location@PLT
.LVL49:
	.loc 1 105 3 is_stmt 0 discriminator 1 view .LVU126
	leaq	.LC10(%rip), %rdi
	movl	%ebx, (%rax)
	.loc 1 105 3 is_stmt 1 discriminator 1 view .LVU127
	call	perror@PLT
.LVL50:
	.loc 1 105 3 discriminator 2 view .LVU128
	.loc 1 106 3 view .LVU129
	movl	$1, %edi
	call	exit@PLT
.LVL51:
	.cfi_endproc
.LFE25:
	.section	.text.startup
	.size	main, .-main
	.section	.text.unlikely
	.size	main.cold, .-main.cold
.LCOLDE13:
	.section	.text.startup
.LHOTE13:
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
	.long	0x949
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x19
	.long	.LASF81
	.byte	0x1d
	.long	.LASF0
	.long	.LASF1
	.long	.LLRL13
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
	.uleb128 0xe
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
	.uleb128 0x4
	.long	0x97
	.uleb128 0x6
	.byte	0x1
	.byte	0x6
	.long	.LASF12
	.uleb128 0x14
	.long	0x97
	.uleb128 0xf
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
	.long	.LASF82
	.byte	0x4
	.byte	0x2b
	.byte	0xe
	.uleb128 0x10
	.long	.LASF43
	.uleb128 0x4
	.long	0x23e
	.uleb128 0x4
	.long	0xa3
	.uleb128 0xb
	.long	0x97
	.long	0x25d
	.uleb128 0xc
	.long	0x36
	.byte	0
	.byte	0
	.uleb128 0x4
	.long	0x236
	.uleb128 0x10
	.long	.LASF44
	.uleb128 0x4
	.long	0x262
	.uleb128 0x10
	.long	.LASF45
	.uleb128 0x4
	.long	0x26c
	.uleb128 0xb
	.long	0x97
	.long	0x286
	.uleb128 0xc
	.long	0x36
	.byte	0x13
	.byte	0
	.uleb128 0x4
	.long	0x9e
	.uleb128 0x4
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
	.uleb128 0xf
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
	.uleb128 0x4
	.long	0x2aa
	.uleb128 0x7
	.long	.LASF52
	.byte	0x6
	.byte	0x37
	.byte	0x3
	.long	0x2aa
	.uleb128 0xf
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
	.uleb128 0x14
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
	.uleb128 0x4
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
	.uleb128 0xd
	.long	.LASF69
	.byte	0x9
	.value	0x16b
	.long	0x67
	.long	0x423
	.uleb128 0x5
	.long	0x286
	.uleb128 0x15
	.byte	0
	.uleb128 0x16
	.long	.LASF70
	.byte	0xdb
	.long	0x67
	.long	0x43c
	.uleb128 0x5
	.long	0x359
	.uleb128 0x5
	.long	0x43c
	.byte	0
	.uleb128 0x4
	.long	0x44
	.uleb128 0x22
	.long	.LASF71
	.byte	0xb
	.value	0x2f4
	.byte	0xd
	.long	0x454
	.uleb128 0x5
	.long	0x67
	.byte	0
	.uleb128 0x23
	.long	.LASF83
	.byte	0xc
	.byte	0x25
	.byte	0xd
	.long	0x460
	.uleb128 0x4
	.long	0x67
	.uleb128 0x16
	.long	.LASF72
	.byte	0xca
	.long	0x67
	.long	0x488
	.uleb128 0x5
	.long	0x48d
	.uleb128 0x5
	.long	0x497
	.uleb128 0x5
	.long	0x49c
	.uleb128 0x5
	.long	0x46
	.byte	0
	.uleb128 0x4
	.long	0x359
	.uleb128 0xe
	.long	0x488
	.uleb128 0x4
	.long	0x3a5
	.uleb128 0xe
	.long	0x492
	.uleb128 0x4
	.long	0x4a1
	.uleb128 0x24
	.long	0x44
	.long	0x4b0
	.uleb128 0x5
	.long	0x44
	.byte	0
	.uleb128 0xd
	.long	.LASF73
	.byte	0xa
	.value	0x343
	.long	0x67
	.long	0x4c6
	.uleb128 0x5
	.long	0x4c6
	.byte	0
	.uleb128 0x4
	.long	0x3e5
	.uleb128 0x25
	.long	.LASF84
	.byte	0x9
	.value	0x36e
	.byte	0xd
	.long	0x4de
	.uleb128 0x5
	.long	0x286
	.byte	0
	.uleb128 0xd
	.long	.LASF74
	.byte	0xa
	.value	0x31a
	.long	0x67
	.long	0x4f4
	.uleb128 0x5
	.long	0x4c6
	.byte	0
	.uleb128 0xd
	.long	.LASF75
	.byte	0x9
	.value	0x165
	.long	0x67
	.long	0x510
	.uleb128 0x5
	.long	0x28b
	.uleb128 0x5
	.long	0x286
	.uleb128 0x15
	.byte	0
	.uleb128 0x11
	.long	.LASF78
	.byte	0x5a
	.byte	0x5
	.long	0x67
	.long	.LLRL8
	.uleb128 0x1
	.byte	0x9c
	.long	0x72d
	.uleb128 0x17
	.long	.LASF76
	.byte	0x5a
	.byte	0xe
	.long	0x67
	.long	.LLST9
	.long	.LVUS9
	.uleb128 0x17
	.long	.LASF77
	.byte	0x5a
	.byte	0x1a
	.long	0x3f1
	.long	.LLST10
	.long	.LVUS10
	.uleb128 0x12
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
	.long	.LLST11
	.long	.LVUS11
	.uleb128 0x8
	.string	"ok"
	.byte	0x5c
	.byte	0x10
	.long	0x67
	.long	.LLST12
	.long	.LVUS12
	.uleb128 0x12
	.string	"t1"
	.byte	0x5d
	.byte	0xc
	.long	0x359
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x12
	.string	"t2"
	.byte	0x5d
	.byte	0x10
	.long	0x359
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x3
	.quad	.LVL25
	.long	0x465
	.long	0x5c8
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
	.uleb128 0x3
	.quad	.LVL26
	.long	0x465
	.long	0x5f8
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
	.uleb128 0x3
	.quad	.LVL28
	.long	0x423
	.long	0x60f
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x3
	.quad	.LVL31
	.long	0x423
	.long	0x626
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x1
	.byte	0x30
	.byte	0
	.uleb128 0x3
	.quad	.LVL36
	.long	0x40c
	.long	0x645
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC12
	.byte	0
	.uleb128 0xa
	.quad	.LVL39
	.long	0x938
	.uleb128 0xa
	.quad	.LVL40
	.long	0x454
	.uleb128 0x3
	.quad	.LVL41
	.long	0x4cb
	.long	0x67e
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC11
	.byte	0
	.uleb128 0xa
	.quad	.LVL43
	.long	0x454
	.uleb128 0x3
	.quad	.LVL44
	.long	0x4cb
	.long	0x6aa
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC11
	.byte	0
	.uleb128 0xa
	.quad	.LVL46
	.long	0x454
	.uleb128 0x3
	.quad	.LVL47
	.long	0x4cb
	.long	0x6d6
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.byte	0
	.uleb128 0x3
	.quad	.LVL48
	.long	0x441
	.long	0x6ed
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.uleb128 0xa
	.quad	.LVL49
	.long	0x454
	.uleb128 0x3
	.quad	.LVL50
	.long	0x4cb
	.long	0x719
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC10
	.byte	0
	.uleb128 0x13
	.quad	.LVL51
	.long	0x441
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.byte	0x31
	.byte	0
	.byte	0
	.uleb128 0x11
	.long	.LASF79
	.byte	0x41
	.byte	0x7
	.long	0x44
	.long	.LLRL4
	.uleb128 0x1
	.byte	0x9c
	.long	0x830
	.uleb128 0x18
	.string	"arg"
	.byte	0x41
	.long	0x44
	.long	.LLST5
	.long	.LVUS5
	.uleb128 0x8
	.string	"i"
	.byte	0x43
	.byte	0x6
	.long	0x67
	.long	.LLST6
	.long	.LVUS6
	.uleb128 0x8
	.string	"ip"
	.byte	0x44
	.byte	0x10
	.long	0x830
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x3
	.quad	.LVL14
	.long	0x4f4
	.long	0x79c
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC5
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL15
	.long	0x4de
	.long	0x7b4
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL16
	.long	0x4b0
	.long	0x7cc
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL17
	.long	0x941
	.long	0x7f5
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC6
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
	.uleb128 0x3
	.quad	.LVL20
	.long	0x4cb
	.long	0x814
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC1
	.byte	0
	.uleb128 0x13
	.quad	.LVL21
	.long	0x4cb
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.byte	0
	.byte	0
	.uleb128 0x4
	.long	0x6e
	.uleb128 0x11
	.long	.LASF80
	.byte	0x29
	.byte	0x7
	.long	0x44
	.long	.LLRL0
	.uleb128 0x1
	.byte	0x9c
	.long	0x938
	.uleb128 0x18
	.string	"arg"
	.byte	0x29
	.long	0x44
	.long	.LLST1
	.long	.LVUS1
	.uleb128 0x8
	.string	"i"
	.byte	0x2b
	.byte	0x6
	.long	0x67
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0x8
	.string	"ip"
	.byte	0x2c
	.byte	0x10
	.long	0x830
	.long	.LLST3
	.long	.LVUS3
	.uleb128 0x3
	.quad	.LVL3
	.long	0x4f4
	.long	0x8a4
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x9
	.byte	0x3
	.quad	.LC0
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x51
	.uleb128 0x2
	.byte	0x73
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL4
	.long	0x4de
	.long	0x8bc
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL5
	.long	0x4b0
	.long	0x8d4
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x2
	.byte	0x7c
	.sleb128 0
	.byte	0
	.uleb128 0x3
	.quad	.LVL6
	.long	0x941
	.long	0x8fd
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
	.uleb128 0x3
	.quad	.LVL9
	.long	0x4cb
	.long	0x91c
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC1
	.byte	0
	.uleb128 0x13
	.quad	.LVL10
	.long	0x4cb
	.uleb128 0x2
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x9
	.byte	0x3
	.quad	.LC2
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	.LASF85
	.long	.LASF85
	.uleb128 0x27
	.long	.LASF86
	.long	.LASF87
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
	.uleb128 0x4
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
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
	.uleb128 0xe
	.uleb128 0x37
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
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
	.uleb128 0x10
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
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
	.uleb128 0x12
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
	.uleb128 0x13
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x18
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x16
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
	.uleb128 0x17
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
	.uleb128 0x24
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
	.uleb128 0x25
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
	.uleb128 0x26
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
.LVUS9:
	.uleb128 0
	.uleb128 .LVU74
	.uleb128 .LVU74
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST9:
	.byte	0x6
	.quad	.LVL22
	.byte	0x4
	.uleb128 .LVL22-.LVL22
	.uleb128 .LVL24-.LVL22
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL24-.LVL22
	.uleb128 .LHOTE13-.LVL22
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0x8
	.quad	.LFSB25
	.uleb128 .LCOLDE13-.LFSB25
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS10:
	.uleb128 0
	.uleb128 .LVU67
	.uleb128 .LVU67
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST10:
	.byte	0x6
	.quad	.LVL22
	.byte	0x4
	.uleb128 .LVL22-.LVL22
	.uleb128 .LVL23-.LVL22
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL23-.LVL22
	.uleb128 .LHOTE13-.LVL22
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.byte	0x8
	.quad	.LFSB25
	.uleb128 .LCOLDE13-.LFSB25
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.byte	0
.LVUS11:
	.uleb128 .LVU77
	.uleb128 .LVU81
	.uleb128 .LVU82
	.uleb128 .LVU86
	.uleb128 .LVU86
	.uleb128 .LVU87
	.uleb128 .LVU87
	.uleb128 .LVU89
	.uleb128 .LVU89
	.uleb128 .LVU92
	.uleb128 .LVU92
	.uleb128 .LVU94
	.uleb128 .LVU94
	.uleb128 .LVU97
	.uleb128 .LVU108
	.uleb128 0
	.uleb128 0
	.uleb128 .LVU111
	.uleb128 .LVU111
	.uleb128 .LVU113
	.uleb128 .LVU113
	.uleb128 .LVU115
	.uleb128 .LVU115
	.uleb128 .LVU117
	.uleb128 .LVU117
	.uleb128 .LVU119
	.uleb128 .LVU119
	.uleb128 .LVU123
	.uleb128 .LVU123
	.uleb128 .LVU126
	.uleb128 .LVU126
	.uleb128 0
.LLST11:
	.byte	0x6
	.quad	.LVL25
	.byte	0x4
	.uleb128 .LVL25-.LVL25
	.uleb128 .LVL26-1-.LVL25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL27-.LVL25
	.uleb128 .LVL28-1-.LVL25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL28-1-.LVL25
	.uleb128 .LVL29-.LVL25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL29-.LVL25
	.uleb128 .LVL30-.LVL25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL30-.LVL25
	.uleb128 .LVL32-.LVL25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL32-.LVL25
	.uleb128 .LVL33-.LVL25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL33-.LVL25
	.uleb128 .LVL34-.LVL25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL39-.LVL25
	.uleb128 .LHOTE13-.LVL25
	.uleb128 0x1
	.byte	0x50
	.byte	0x6
	.quad	.LFSB25
	.byte	0x4
	.uleb128 .LFSB25-.LFSB25
	.uleb128 .LVL40-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL40-1-.LFSB25
	.uleb128 .LVL42-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL42-.LFSB25
	.uleb128 .LVL43-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL43-1-.LFSB25
	.uleb128 .LVL45-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL45-.LFSB25
	.uleb128 .LVL46-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL46-1-.LFSB25
	.uleb128 .LVL48-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL48-.LFSB25
	.uleb128 .LVL49-1-.LFSB25
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL49-1-.LFSB25
	.uleb128 .LFE25-.LFSB25
	.uleb128 0x1
	.byte	0x53
	.byte	0
.LVUS12:
	.uleb128 .LVU102
	.uleb128 .LVU106
	.uleb128 .LVU106
	.uleb128 .LVU107
	.uleb128 .LVU107
	.uleb128 .LVU108
.LLST12:
	.byte	0x6
	.quad	.LVL35
	.byte	0x4
	.uleb128 .LVL35-.LVL35
	.uleb128 .LVL37-.LVL35
	.uleb128 0x6
	.byte	0x73
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL37-.LVL35
	.uleb128 .LVL38-.LVL35
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL38-.LVL35
	.uleb128 .LVL39-.LVL35
	.uleb128 0x6
	.byte	0x73
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.byte	0
.LVUS5:
	.uleb128 0
	.uleb128 .LVU39
	.uleb128 .LVU39
	.uleb128 .LVU60
	.uleb128 .LVU60
	.uleb128 .LVU61
	.uleb128 .LVU61
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST5:
	.byte	0x6
	.quad	.LVL11
	.byte	0x4
	.uleb128 .LVL11-.LVL11
	.uleb128 .LVL13-.LVL11
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL13-.LVL11
	.uleb128 .LVL18-.LVL11
	.uleb128 0x1
	.byte	0x56
	.byte	0x4
	.uleb128 .LVL18-.LVL11
	.uleb128 .LVL19-.LVL11
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL19-.LVL11
	.uleb128 .LHOTE7-.LVL11
	.uleb128 0x1
	.byte	0x56
	.byte	0x8
	.quad	.LFSB24
	.uleb128 .LCOLDE7-.LFSB24
	.uleb128 0x1
	.byte	0x56
	.byte	0
.LVUS6:
	.uleb128 .LVU43
	.uleb128 .LVU44
.LLST6:
	.byte	0x8
	.quad	.LVL14
	.uleb128 .LVL14-.LVL14
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS7:
	.uleb128 .LVU38
	.uleb128 .LVU39
	.uleb128 .LVU39
	.uleb128 .LVU60
	.uleb128 .LVU60
	.uleb128 .LVU61
	.uleb128 .LVU61
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST7:
	.byte	0x6
	.quad	.LVL12
	.byte	0x4
	.uleb128 .LVL12-.LVL12
	.uleb128 .LVL13-.LVL12
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL13-.LVL12
	.uleb128 .LVL18-.LVL12
	.uleb128 0x1
	.byte	0x56
	.byte	0x4
	.uleb128 .LVL18-.LVL12
	.uleb128 .LVL19-.LVL12
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL19-.LVL12
	.uleb128 .LHOTE7-.LVL12
	.uleb128 0x1
	.byte	0x56
	.byte	0x8
	.quad	.LFSB24
	.uleb128 .LCOLDE7-.LFSB24
	.uleb128 0x1
	.byte	0x56
	.byte	0
.LVUS1:
	.uleb128 0
	.uleb128 .LVU7
	.uleb128 .LVU7
	.uleb128 .LVU28
	.uleb128 .LVU28
	.uleb128 .LVU29
	.uleb128 .LVU29
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST1:
	.byte	0x6
	.quad	.LVL0
	.byte	0x4
	.uleb128 .LVL0-.LVL0
	.uleb128 .LVL2-.LVL0
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL2-.LVL0
	.uleb128 .LVL7-.LVL0
	.uleb128 0x1
	.byte	0x56
	.byte	0x4
	.uleb128 .LVL7-.LVL0
	.uleb128 .LVL8-.LVL0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL8-.LVL0
	.uleb128 .LHOTE4-.LVL0
	.uleb128 0x1
	.byte	0x56
	.byte	0x8
	.quad	.LFSB23
	.uleb128 .LCOLDE4-.LFSB23
	.uleb128 0x1
	.byte	0x56
	.byte	0
.LVUS2:
	.uleb128 .LVU11
	.uleb128 .LVU12
.LLST2:
	.byte	0x8
	.quad	.LVL3
	.uleb128 .LVL3-.LVL3
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0
.LVUS3:
	.uleb128 .LVU6
	.uleb128 .LVU7
	.uleb128 .LVU7
	.uleb128 .LVU28
	.uleb128 .LVU28
	.uleb128 .LVU29
	.uleb128 .LVU29
	.uleb128 0
	.uleb128 0
	.uleb128 0
.LLST3:
	.byte	0x6
	.quad	.LVL1
	.byte	0x4
	.uleb128 .LVL1-.LVL1
	.uleb128 .LVL2-.LVL1
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL2-.LVL1
	.uleb128 .LVL7-.LVL1
	.uleb128 0x1
	.byte	0x56
	.byte	0x4
	.uleb128 .LVL7-.LVL1
	.uleb128 .LVL8-.LVL1
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL8-.LVL1
	.uleb128 .LHOTE4-.LVL1
	.uleb128 0x1
	.byte	0x56
	.byte	0x8
	.quad	.LFSB23
	.uleb128 .LCOLDE4-.LFSB23
	.uleb128 0x1
	.byte	0x56
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
	.quad	.LHOTE13-.LFB25
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
.LLRL0:
	.byte	0x7
	.quad	.LFB23
	.uleb128 .LHOTE4-.LFB23
	.byte	0x7
	.quad	.LFSB23
	.uleb128 .LCOLDE4-.LFSB23
	.byte	0
.LLRL4:
	.byte	0x7
	.quad	.LFB24
	.uleb128 .LHOTE7-.LFB24
	.byte	0x7
	.quad	.LFSB24
	.uleb128 .LCOLDE7-.LFSB24
	.byte	0
.LLRL8:
	.byte	0x7
	.quad	.LFB25
	.uleb128 .LHOTE13-.LFB25
	.byte	0x7
	.quad	.LFSB25
	.uleb128 .LCOLDE13-.LFSB25
	.byte	0
.LLRL13:
	.byte	0x7
	.quad	.Ltext0
	.uleb128 .Letext0-.Ltext0
	.byte	0x7
	.quad	.Ltext_cold0
	.uleb128 .Letext_cold0-.Ltext_cold0
	.byte	0x7
	.quad	.LFB25
	.uleb128 .LHOTE13-.LFB25
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF83:
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
.LASF74:
	.string	"pthread_mutex_lock"
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
.LASF84:
	.string	"perror"
.LASF75:
	.string	"fprintf"
.LASF59:
	.string	"__spins"
.LASF77:
	.string	"argv"
.LASF71:
	.string	"exit"
.LASF29:
	.string	"_old_offset"
.LASF87:
	.string	"__builtin_fwrite"
.LASF4:
	.string	"unsigned char"
.LASF76:
	.string	"argc"
.LASF6:
	.string	"signed char"
.LASF35:
	.string	"_codecvt"
.LASF47:
	.string	"long long unsigned int"
.LASF79:
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
.LASF78:
	.string	"main"
.LASF36:
	.string	"_wide_data"
.LASF37:
	.string	"_freeres_list"
.LASF81:
	.string	"GNU C17 14.1.1 20240507 -mtune=generic -march=x86-64 -g -O2"
.LASF39:
	.string	"__pad5"
.LASF73:
	.string	"pthread_mutex_unlock"
.LASF54:
	.string	"__lock"
.LASF56:
	.string	"__owner"
.LASF5:
	.string	"short unsigned int"
.LASF80:
	.string	"increase_fn"
.LASF53:
	.string	"__pthread_mutex_s"
.LASF86:
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
.LASF85:
	.string	"__stack_chk_fail"
.LASF65:
	.string	"pthread_attr_t"
.LASF62:
	.string	"pthread_t"
.LASF82:
	.string	"_IO_lock_t"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"simplesync.c"
.LASF1:
	.string	"/home/orion/Desktop/ntua/semester6/operating_systems/lab/OSLab/exercise2/sync"
	.ident	"GCC: (GNU) 14.1.1 20240507"
	.section	.note.GNU-stack,"",@progbits
