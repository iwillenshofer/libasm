; **************************************************************************** #
;      _  _ ___        _ _                                  _     _            #
;      | || |__ \      | (_)                                | |   | |          #
;      | || |_ ) |   __| |_ ___  __ _ ___ ___  ___ _ __ ___ | |__ | |_   _     #
;      |__   _/ /   / _` | / __|/ _` / __/ __|/ _ \ '_ ` _ \| '_ \| | | | |    #
;         | |/ /_  | (_| | \__ \ (_| \__ \__ \  __/ | | | | | |_) | | |_| |    #
;         |_|____|  \__,_|_|___/\__,_|___/___/\___|_| |_| |_|_.__/|_|\__, |    #
;                                                                     __/ |    #
;       ft_strdup.s                                                  |___/     #
;       By: aroque <aroque@student.42sp.org.br>                                #
;       Created: 2020/04/02 15:47:34 by aroque                                 #
;       Updated: 2020/04/02 22:22:29 by aroque                                 #
;                                                                              #
;    _. ._ _   _.      _      o      o | |  _  ._   _     ._ _| o     ._ o  _  #
;   (_| | (_) (_| |_| (/_     | \/\/ | | | (/_ | | _>     | (_| | |_| |  | (_  #
;               |                                              _|              #
; **************************************************************************** #

extern	malloc
extern	ft_strlen
extern	ft_strcpy
extern	___error
global	ft_strdup

section	.text

ft_strdup:
	xor		rax, rax

mem_alloc:
	call	ft_strlen		; ft_strlen(rdi)
	push	rdi				; save input address on stack
	mov		rdi, rax		; copy result of ft_strlen to counter
	inc		rdi				; increment counter (\0 allocation)
	call	malloc			; malloc(rdi)
	pop		rdi				; remove input address from stack
	cmp		rax, 0x0		; protect malloc
	jne		copy			; jump to copy if malloc not zero

treat_error:
	call	___error		; error treatment: ___error returns
	mov		qword[rax], 12	;  the address of errno. We set the value
	mov		rax, 0			;  of errno to ENOMEM (12), and then return 0.
	jmp		return

copy:
	mov		rsi, rdi		; copy destination to source
	mov		rdi, rax		; copy malloc return address to rdi
	call	ft_strcpy		; ft_strcpy(rdi, rsi)
	jmp		return

return:
	ret