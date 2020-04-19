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
;       Created: 2020/04/02 15:17:43 by rdjuric                                #
;       Updated: 2020/04/02 22:41:42 by aroque                                 #
;                                                                              #
;    _. ._ _   _.      _      o      o | |  _  ._   _     ._ _| o     ._ o  _  #
;   (_| | (_) (_| |_| (/_     | \/\/ | | | (/_ | | _>     | (_| | |_| |  | (_  #
;               |                                              _|              #
; **************************************************************************** #

; Para o syscall					Recebendo da chamada
; rdi -> fd							rdi -> fd
; rsi -> buff						rsi -> buff
; rdx -> bytes						rdx -> bytes
; rax -> opcode

		global      ft_read
		extern		__errno_location
		section     .text
ft_read:
		push		rsp
		mov			rax, 0x0		; read opcode
		syscall						; calls read, if error sets flags
		cmp			rax, 0x0
		jl			err				; check for errors in flags, if found jump to err
		jmp			return			; if no errors, rax has the return value of read syscall 

err:
		imul		rax, -1
		mov			rdx, rax
		call		__errno_location
		mov			qword[rax], rdx	; if error is found, we set rax to -1
		mov			rax, -1			; return  rax

return:
		pop			rsp
		ret