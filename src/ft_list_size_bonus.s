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
;       Created: 2020/04/02 17:16:45 by aroque                                 #
;       Updated: 2020/04/05 22:35:34 by aroque                                 #
;                                                                              #
;    _. ._ _   _.      _      o      o | |  _  ._   _     ._ _| o     ._ o  _  #
;   (_| | (_) (_| |_| (/_     | \/\/ | | | (/_ | | _>     | (_| | |_| |  | (_  #
;               |                                              _|              #
; **************************************************************************** #

global	_ft_list_size
section	.text

; int ft_list_size(t_list *begin_list)
; rdi -> *begin_list
; rax -> list_size
_ft_list_size:
	xor	rax, rax			;initialize rax
count:
	cmp	rdi, 0x0			;check if address is null
	je	return		
	inc	rax					;increment rax
	mov	rdi, [rdi + 0x08]	;advance pointer position
	jmp	count
return:
	ret