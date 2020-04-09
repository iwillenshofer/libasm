; **************************************************************************** #
;      _  _ ___        _ _                                  _     _            #
;      | || |__ \      | (_)                                | |   | |          #
;      | || |_ ) |   __| |_ ___  __ _ ___ ___  ___ _ __ ___ | |__ | |_   _     #
;      |__   _/ /   / _` | / __|/ _` / __/ __|/ _ \ '_ ` _ \| '_ \| | | | |    #
;         | |/ /_  | (_| | \__ \ (_| \__ \__ \  __/ | | | | | |_) | | |_| |    #
;         |_|____|  \__,_|_|___/\__,_|___/___/\___|_| |_| |_|_.__/|_|\__, |    #
;                                                                     __/ |    #
;       ft_strcmp.s                                                  |___/     #
;       By: aroque <aroque@student.42sp.org.br>                                #
;       Created: 2020/04/01 17:16:45 by aroque                                 #
;       Updated: 2020/04/02 22:35:34 by aroque                                 #
;                                                                              #
;    _. ._ _   _.      _      o      o | |  _  ._   _     ._ _| o     ._ o  _  #
;   (_| | (_) (_| |_| (/_     | \/\/ | | | (/_ | | _>     | (_| | |_| |  | (_  #
;               |                                              _|              #
; **************************************************************************** #

global	_ft_strcmp

section	.text

; rax	-> accumulator register (return), 64 bits
; eax	-> accumulator register (return), 32 bits
; ax	-> accumulator register (return), 16 bits
; al	-> accumulator register (return), 8 bits

; rdi	-> destination index register - function 1st parameter (const char *s1)
; rsi	-> source index register - function 2nd parameter (const char *s2)
; rdx	-> data register
; dl	-> data register (last 8 bits)

_ft_strcmp:
	xor	rcx, rcx				; clear the variables
	xor	rax, rax
	xor	rdx, rdx

compare:
	mov	al, byte [rdi + rcx]	; move last byte from dest to al
	mov	dl, byte [rsi + rcx]	; and from source to dl for comparison
	cmp	al, dl
	jne	subtraction				; if not equal, subtract and return

	cmp	al, 0x0
	je	subtraction

	inc	rcx						; otherwise, increment and loop
	jmp	compare

subtraction:
	sub	rax, rdx
	ret
