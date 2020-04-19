; **************************************************************************** #
;      _  _ ___        _ _                                  _     _            #
;      | || |__ \      | (_)                                | |   | |          #
;      | || |_ ) |   __| |_ ___  __ _ ___ ___  ___ _ __ ___ | |__ | |_   _     #
;      |__   _/ /   / _` | / __|/ _` / __/ __|/ _ \ '_ ` _ \| '_ \| | | | |    #
;         | |/ /_  | (_| | \__ \ (_| \__ \__ \  __/ | | | | | |_) | | |_| |    #
;         |_|____|  \__,_|_|___/\__,_|___/___/\___|_| |_| |_|_.__/|_|\__, |    #
;                                                                     __/ |    #
;       ft_strcmp.s                                                  |___/     #
;       By: iwillens <aroque@student.42sp.org.br>                              #
;       Created: 2020/04/02 17:16:45 by iwillens                               #
;       Updated: 2020/04/05 22:35:34 by iwillens                               #
;                                                                              #
;    _. ._ _   _.      _      o      o | |  _  ._   _     ._ _| o     ._ o  _  #
;   (_| | (_) (_| |_| (/_     | \/\/ | | | (/_ | | _>     | (_| | |_| |  | (_  #
;               |                                              _|              #
; **************************************************************************** #

global ft_list_sort
section .text

; void _ft_swap(void *rdi, void *rsi);
_ft_swap:
	mov	rdx, [rdi]
	mov	rcx, [rsi]
	mov [rdi], rcx
	mov [rsi], rdx
	ret

; void ft_list_sort(t_list **begin_list, int (*cmp)());
ft_list_sort:
	mov	r8, rdi					; [head of the list]
	mov	r9, rsi					; cmp function will be called at R9
	mov r10, [r8]				; r10 -> (data) pointer
	cmp		r10, 0				; check if data pointer is not null.
	je		.end
.loop:
	mov		r11, [r10 + 8]		; r11 -> next pointer
	cmp		r11, 0				; if r11 is null END was reached
	je		.end
	mov		rdi, [r10]			; prepares cmp function call
	mov		rsi, [r11]
	push	r8					; as the R9 function (CMP) is unknown
	push	r9					;  the registers used by _ft_list_sort must
	push	r10					;  be preserved
	push	r11
	call	r9					; cmp function is called
	pop		r11
	pop		r10
	pop		r9
	pop		r8
	cmp		rax, 0				; compares result to determine if swap is
	jle		.skip_swap			;  needed. 
	mov		rdi, r10			; prepares swap if cmp value is greater than
	mov		rsi, r11			;  zero
	call	_ft_swap
	mov		r10, [r8]			; if a swap was done, start over and loop
	jmp		.loop
.skip_swap:
	mov		r10, [r10 + 8]		; if a swap wasn't done, go to next element
	jmp		.loop				;  and loop
.end:
	ret