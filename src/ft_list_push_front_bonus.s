; **************************************************************************** #
;      _  _ ___        _ _                                  _     _            #
;      | || |__ \      | (_)                                | |   | |          #
;      | || |_ ) |   __| |_ ___  __ _ ___ ___  ___ _ __ ___ | |__ | |_   _     #
;      |__   _/ /   / _` | / __|/ _` / __/ __|/ _ \ '_ ` _ \| '_ \| | | | |    #
;         | |/ /_  | (_| | \__ \ (_| \__ \__ \  __/ | | | | | |_) | | |_| |    #
;         |_|____|  \__,_|_|___/\__,_|___/___/\___|_| |_| |_|_.__/|_|\__, |    #
;                                                                     __/ |    #
;       ft_strcmp.s                                                  |___/     #
;       By: iwillens <iwillens@student.42sp.org.br>                            #
;       Created: 2020/04/05 17:16:45 by iwillens                               #
;       Updated: 2020/04/08 22:35:34 by aroque                                 #
;                                                                              #
;    _. ._ _   _.      _      o      o | |  _  ._   _     ._ _| o     ._ o  _  #
;   (_| | (_) (_| |_| (/_     | \/\/ | | | (/_ | | _>     | (_| | |_| |  | (_  #
;               |                                              _|              #
; **************************************************************************** #

global ft_list_push_front
extern	malloc

section .text

; t_list *ft_create_elem(void *data);
_ft_create_elem:
xor		rcx, rcx
push	rdi
mov		rdi, 16				; sets rdi to 16 bytes to create malloc
call	malloc;
pop		rdi
cmp		rax, 0
je		.malloc_error
mov		[rax], rdi
mov		[rax + 8], rcx
.malloc_error:
ret

; void ft_list_push_front(t_list **begin_list, void *data);
_ft_list_push_front:
push	rdi
mov		rdi, rsi
call	ft_create_elem		; rax is the new elem created with malloc
pop		rdi
mov		rdx, [rdi]			; rdx is tmp for first elem
mov		[rax + 8], rdx
mov		[rdi], rax			; rdi is elem passed by malloc
.return:
ret

