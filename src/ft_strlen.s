; **************************************************************************** #
;      _  _ ___        _ _                                  _     _            #
;      | || |__ \      | (_)                                | |   | |          #
;      | || |_ ) |   __| |_ ___  __ _ ___ ___  ___ _ __ ___ | |__ | |_   _     #
;      |__   _/ /   / _` | / __|/ _` / __/ __|/ _ \ '_ ` _ \| '_ \| | | | |    #
;         | |/ /_  | (_| | \__ \ (_| \__ \__ \  __/ | | | | | |_) | | |_| |    #
;         |_|____|  \__,_|_|___/\__,_|___/___/\___|_| |_| |_|_.__/|_|\__, |    #
;                                                                     __/ |    #
;       ft_read.s                                                    |___/     #
;       By: rdjuric <rdjuric@student.42sp.org.br>                              #
;       Created: 2020/04/01 15:00:00 by rdjuric                                #
;       Updated: 2020/04/02 22:41:42 by aroque                                 #
;                                                                              #
;    _. ._ _   _.      _      o      o | |  _  ._   _     ._ _| o     ._ o  _  #
;   (_| | (_) (_| |_| (/_     | \/\/ | | | (/_ | | _>     | (_| | |_| |  | (_  #
;               |                                              _|              #
; **************************************************************************** #

; first argument:	rdi
; second argument:	rsi
; third argument:	rdx
; fourth argument:	rcx
; fifth argument:	r8
; sixth argument:	r9

global		ft_strlen

section		.text

ft_strlen:
			mov		rax, rdi

comparison:
			cmp		byte [rax], 0
			je		finish
			inc		rax
			jne		comparison

finish:
			sub		rax, rdi
			ret
