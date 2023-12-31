; **************************************************************************** #
;      _  _ ___        _ _                                  _     _            #
;      | || |__ \      | (_)                                | |   | |          #
;      | || |_ ) |   __| |_ ___  __ _ ___ ___  ___ _ __ ___ | |__ | |_   _     #
;      |__   _/ /   / _` | / __|/ _` / __/ __|/ _ \ '_ ` _ \| '_ \| | | | |    #
;         | |/ /_  | (_| | \__ \ (_| \__ \__ \  __/ | | | | | |_) | | |_| |    #
;         |_|____|  \__,_|_|___/\__,_|___/___/\___|_| |_| |_|_.__/|_|\__, |    #
;                                                                     __/ |    #
;       ft_write.s                                                   |___/     #
;       By: iwillens <iwillens@student.42sp.org.br>                            #
;       Created: 2020/04/02 14:55:05 by iwillens                               #
;       Updated: 2020/04/02 22:37:16 by aroque                                 #
;                                                                              #
;    _. ._ _   _.      _      o      o | |  _  ._   _     ._ _| o     ._ o  _  #
;   (_| | (_) (_| |_| (/_     | \/\/ | | | (/_ | | _>     | (_| | |_| |  | (_  #
;               |                                              _|              #
; **************************************************************************** #

global	ft_write
extern	__errno_location

section	.text

; first argument:	rdi
; second argument:	rsi
; third argument:	rdx
; fourth argument:	rcx
; fifth argument:	r8
; sixth argument:	r9

ft_write:
	push	rsp	
	mov	rax, 0x1		; write
	syscall				; the arguments are already set in place
	cmp rax, 0x0
	jl	error_handling	; check if Carry Flag is on (error)
	jmp return

error_handling:
	imul	rax, -1
	mov		rdx, rax
	call	__errno_location
	mov		qword[rax], rdx
	mov		rax, -1
	
return:
	pop		rsp
	ret
