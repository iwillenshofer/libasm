; **************************************************************************** #
;      _  _ ___        _ _                                  _     _            #
;      | || |__ \      | (_)                                | |   | |          #
;      | || |_ ) |   __| |_ ___  __ _ ___ ___  ___ _ __ ___ | |__ | |_   _     #
;      |__   _/ /   / _` | / __|/ _` / __/ __|/ _ \ '_ ` _ \| '_ \| | | | |    #
;         | |/ /_  | (_| | \__ \ (_| \__ \__ \  __/ | | | | | |_) | | |_| |    #
;         |_|____|  \__,_|_|___/\__,_|___/___/\___|_| |_| |_|_.__/|_|\__, |    #
;                                                                     __/ |    #
;       ft_strcpy.s                                                  |___/     #
;       By: iwillens <iwillens@student.42sp.org.br>                            #
;       Created: 2020/04/02 22:33:26 by iwillens                               #
;       Updated: 2020/04/02 22:34:32 by aroque                                 #
;                                                                              #
;    _. ._ _   _.      _      o      o | |  _  ._   _     ._ _| o     ._ o  _  #
;   (_| | (_) (_| |_| (/_     | \/\/ | | | (/_ | | _>     | (_| | |_| |  | (_  #
;               |                                              _|              #
; **************************************************************************** #

; first argument:   rdi
; second argument:  rsi
; third argument:   rdx
; fourth argument:  rcx
; fifth argument:   r8
; sixth argument:   r9

global _ft_strcpy

section .text

_ft_strcpy:
	xor rcx, rcx	; clear counter
	mov rax, rdi	; set dest addres to rax (for return)
	
looping:
	mov	dl, byte[rsi + rcx]	; move rsi current char to rdi
	mov	byte[rdi + rcx], dl	; moving before compare garantees \0 termination
	cmp	byte[rsi + rcx], 0	; check if \0
	je	end
	inc	rcx					; incrementing counter will move to the next char
	jmp	looping

end:
	ret
