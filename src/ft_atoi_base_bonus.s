; *************************************************************************** #
;                                                                             #
;                                                        :::      ::::::::    #
;   ft_atoi_base_bonus.s                               :+:      :+:    :+:    #
;                                                    +:+ +:+         +:+      #
;   By: iw <iw@student.42.fr>                      +#+  +:+       +#+         #
;                                                +#+#+#+#+#+   +#+            #
;   Created: 2020/04/03 12:10:00 by iwillens          #+#    #+#              #
;   Updated: 2020/04/05 09:41:00 by iwillens         ###   ########.fr        #
;                                                                             #
; *************************************************************************** #

	global _ft_atoi_base
	extern _ft_strlen
	section .text


; *****************************************************************************
; *** ---> static int _ft_is_space(char rdi)
; *****************************************************************************
; *** RDI: char to check if it is space. 
; Description: loops through the string 'space' (spaces db ` \n\v\f\r\t\0`)
; 				and matches against a char sent by function _ft_count_spaces,
;				until it finds a "not space"
; Changed registers: RCX, RAX, RSI, RDX
; Return:	RAX-> 0 if space is not found; 1 if found.
_ft_is_space:
	xor	rax, rax
	xor rcx, rcx
	mov rsi, spaces	
.compare:
	xor rdx, rdx
	mov dl, byte[rsi + rcx]
	cmp rdx, 0					; checks if the spaces string reached end
	je .zero					; 	which means char is not a space
	inc rcx						; increase rcx for the next comparison
	cmp dl, dil					; check if current 'space' matches our char
	je	.one					;	if it does, char is a space and must return
	jne .compare				;	if not, keep looping
.zero:
	xor rax, rax
	ret
.one:
	mov	rax, 1
	ret


; *****************************************************************************
; *** ---> static int _ft_count_spaces(char *rdi)
; *****************************************************************************
; *** RDI: chars to loop through while there's a apace. 
; Description: loops through the string and calls ft_is_space for each one
;				until it finds a "not space"
; Changed registers: RCX, RAX, RDX.  RDI is pushed and popped
; Return:	RAX-> space count
_ft_count_spaces:
	xor rcx, rcx
	xor rax, rax
.loop:
	push	rcx
	push	rdi
	mov		rdx, rdi			; uses rdx as helper for the string
	xor		rdi, rdi			; moves do rdi 1 byte of rdx at the counter
	mov		dil, byte[rdx + rcx]; 	position. ie: the char
	call	_ft_is_space		; check if that char is a space
	pop		rdi
	pop		rcx
	add		rcx, rax			; if so, add one to the counter
	cmp		rax, 1				; 	and keeps looping to the next char
	je		.loop
	mov		rax, rcx			; otherwise returns the function with the
	ret							;	current count


; *****************************************************************************
; *** ---> static int _ft_get_signal(char *rdi, int rsi)
; *****************************************************************************
; *** RDI: chars to loop through while there's a sign. 
; *** RSI: offset. (after spaces). When rdi should start. 
; Description: loops through a string while its char is '+' or '-', returning
;				the count of '+' and '-' multiplied by 1 if the number of 
;				'minus' is even or 0, and -1 if it is odd
; Changed registers: RCX, RAX
; Note: RCX is not zeroed and is kept changed at
; 	the end. It may be used by the caller function to
; 	keep increasing the position on the array.
; Return:	RAX-> returns offset (last signal), negative or positive 
;				   according to signal
_ft_get_signal:
	mov	rcx, rsi
	mov rax, 1
.looping:
	cmp byte[rdi + rcx], '+'
	je .found_plus
	cmp byte[rdi + rcx], '-'
	je .found_minus
	mul	rcx
	ret
.found_minus:
	imul	rax, -1		; invert the minus flag and passes
.found_plus:			;  through to increase counter
	inc rcx				; just increase counter. 
	jmp .looping


; *****************************************************************************
; *** ---> static int ft_is_base(char rdi, char *rsi)
; *****************************************************************************
; *** RDI: char to find in base
; *** RSI: char* with base characters
; Description: loops through the base and checks char position, returning it.
; Changed registers: RCX, RAX
; Return:	RAX-> Position if found or -1 if not found
_ft_is_base:
	xor		rcx, rcx			; sets counter to zero
.compare:						; start of the loop
	cmp		byte[rsi + rcx], 0	; check if the the base reach '/0'
	je		.minus_one			; 	in which case it will return -1
	cmp		dil, byte[rsi + rcx]; check if char (dil) was found in
	je		.found				;	the base. If so, return the pos.
	inc		rcx					; if not yet found, increase counter
	jmp		.compare			;	and loops again
.found: 
	mov		rax, rcx
	ret
.minus_one:
	mov		rax, -1
	ret


; *****************************************************************************
; *** ---> static int ft_get_numbers(char *rdi, char *rsi)
; *****************************************************************************
; *** RDI: char* to find in base (the actual 'numbers')
; *** RSI: char* with base characters
; Description: loops through the string while the chars are found in the base
;				multiplying them by the base len and returning their value in
;				decimal.
; Changed registers: RCX, RAX.  R8, R9, RDI and RDX are preserved
; Return:	RAX-> decimal value of the converted number
; Internal function Reference:
; **** RDX is position of number in base
; **** RCX is position of number at left side
; **** R9 is store
; **** R8 is base size
_ft_get_numbers:
	xor		rcx, rcx		; rcx is the counter (which position we are in rdi)
	push	r8				; r8 will store base size and r9, the end result. 
	push	r9				; as convention, both R8 AND R9 should be preserved
	xor		r8, r8			; both r8 and r9 are initialized to zero.
	xor		r9, r9
	push	rdi				; this section sets rsi to rdi to get the size of 
	mov		rdi, rsi		; the base calling strlen function
	call	_ft_strlen		;  (base size is the len of the original rsi)
	mov		r8, rax			; the base size is stored in R8.
	pop		rdi				; now rdi and rsi are in its original state.
.looping:
	push	rdi				; this segment gets the position of the number
	push	rcx				;  at the base. It prepares the function call by 
	xor		rdx, rdx		;  setting rdi accordingly (rsi is alrdy. in place)
	mov		dl, byte[rdi + rcx]	; as it is inside a loop, rdi and and rcx
	xor		rdi, rdi		;  must be preserved by push and pop.
	mov		dil, dl			; the final result of this call is the position
	call	_ft_is_base		;  of the current number in the base set to RDX.
	mov		rdx, rax		; if that position is -1, it means we found a
	pop		rcx				;  number not in the base and the function must end
	pop		rdi						
	cmp		rdx, -1
	je		.end
	mov		rax, r8			; this section multiplies the stored number (r9
	push	rdx				;  which is zero on the first run) by the base 
	push	rcx				;  and sums to it the position of the current
	mul		r9				;  number (rdx), setting the result back to r9.
	pop		rcx
	pop		rdx
	add		rax, rdx
	mov		r9, rax
	inc		rcx				; at last, increments rcx and loops, moving to
	jmp		.looping		;  the next number (char) in the array (rdi).
.end:
mov		rax, r9				; returns the stored number in r9.	
pop		r9
pop		r8
ret


; *****************************************************************************
; *** ---> static int find_n_str(char *rdi, char sil, int rdx)
; *****************************************************************************
; *** RDI: char* with base characters
; *** RSI: char to find
; *** RDX: max position to find
; Description: loops through the base and checks for char position up to a
; 				maximum defined position.
; Changed registers: RCX, RAX
; Return:	RAX-> 0 if not found. 1 if found (which means, a duplicate)
_find_n_str:
	xor		rax, rax
	xor		rcx, rcx
.loop:
	cmp		sil, 0			; checks if the number being checked is 0
	je		.end			;  or if the max pos has already been reached.
	cmp		rcx, rdx		;  or if we've been through all bytes of the base
	je		.end			; in all those cases we end returning a zero.
	cmp		byte[rdi + rcx], 0
	je		.end
	cmp		sil, byte[rdi + rcx]; if RSI matches the current byte of the base
	je		.found_dup		;  1 is returned, as a dup has been found.
	inc		rcx				;  otherwise, increase counter and keep looping
jmp	.loop
.found_dup:
mov rax, 1
ret
.end:
ret

; *****************************************************************************
; *** ---> static int find_duplicate(char *rdi)
; *****************************************************************************
; *** RDI: char* with base characters
; Description: loops through the base and checks for duplicates with the help
;  				of find_n_str.
; Changed registers: RCX, RAX, RSI.
; Return:	RAX-> 0 if not found. 1 if found (which means, a duplicate)
_find_duplicate:
	xor		rax, rax
	xor		rcx, rcx
	xor		rsi, rsi
.loop:
	cmp		byte[rdi + rcx], 0	; checks if end of RDI hasn't been reached yet
	je		.end
	mov		sil, byte[rdi + rcx]; prepares RSI and RDX for calling _find_n_str
	push	rcx					;  as RDI is already in place.
	mov		rdx, rcx			; rcx is preserved as it is changed by the
	call	_find_n_str			;  function call.
	pop		rcx					; if a duplicate is found, the function returns
	cmp		rax, 1					
	je		.end
	inc		rcx
	jmp		.loop
.end:							; the return of this function preserves the rax
	ret							;  of _find_n_str. 1 for found, 0 for not found


; *****************************************************************************
; *** ---> static int _check_base(char *rdi)
; *****************************************************************************
; *** RDI: char* with base characters
; Description: checks if base is valid. Must be greater than 1 character, must
;				not have any duplicates. mus not have spaces, plus and minus
; Changed registers: RCX, RAX, RDI, RSI, RDX.
; Return:	RAX-> 0 if valid. 1 if invalid
_check_base:
	xor		rax, rax
	mov		rdi, rsi
	call	_ft_strlen		; checks if base len is <= 1, in which case it is
	cmp		rax, 1			;  invalid. if not, copy len to the 3rd argument 
	jle		.invalid		;  (rcx), which will be used in all _find_n_str
	mov		rdx, rax		;  function call.
	mov		rsi, '-'		; this section looks for '+' and '-'
	call	_find_n_str		;  if found, it will end the function (jumping to
	cmp		rax, 1			;  .invalid).
	je		.invalid
	mov		rsi, '+'
	call	_find_n_str
	cmp		rax, 1
	je		.invalid
	call	_find_duplicate	; this section searches for a duplicade on the 
	cmp		rax, 1			;  base jumping to .invalid if  found.
	je		.invalid		;  the base was previously set to rdi
	xor		rdx, rdx
	xor		rcx, rcx		; RCX is a counter (must be pushed in the loop) to
	mov		rdx, spaces		;  avoid being changed. RDX is a helper for spaces
.loop_spaces:				; this sections loops through each char of
	xor		rsi, rsi		;  spaces string, puts its value to RSI and
	mov		sil, byte[rdx + rcx];  calls _find_n_str to check if any matches
	push	rcx
	call	_find_n_str		; if any of the spaces chars is found
	pop		rcx				;  jump to invalid and ends function. Otherwise
	cmp		rax, 1			;  keep looping until (rdx + r9) reached \0
	je		.invalid		;  (last char in 'spaces' string)
	inc		rcx					
	cmp		byte[rdx + rcx], 0
	jne		.loop_spaces
	mov		rax, 0			; if the loop is over and there was no .invalid
	ret						;  return this function indicating a valid base.
.invalid:
	mov rax, 1
	ret


; *****************************************************************************
; *** ---> int _ft_atoi_base(char *rdi, char *rsi)
; *****************************************************************************
; *** RSI: char* with 'number characters
; *** RDI: char* with base characters
; Description: Validates base, and loops through the string skipping whitespace
;				 characters, calculates signs, converts the numbers according
;				 to base and applies the correct signal. Stops converting when
;				 any character outside the base is found.
; Changed registers: RCX, RAX, RDX.
; Return:	RAX-> Decimal representation of the converted number
_ft_atoi_base:
	cmp		rsi, 0			; Checks if the char* pointers passed to our
	je		.invalid_args	;  function are not null
	cmp		rdi, 0
	je		.invalid_args
	push	rdi
	push	rsi
	mov		rdi, rsi
	call	_check_base			
	pop		rsi				; rsi and rdi are constantly pushed and popped in
	pop		rdi				;  and from the stack to ensure they aren't changed
	cmp		rax, 1
	je		.invalid_args
	push	rsi
	push	rdi
	xor		rcx, rcx		; count spaces and adds to RCX, the
	call	_ft_count_spaces;  'counter' or offset.
	mov		rcx, rax
	pop		rdi
	mov		rsi, rcx		; sets second argument to counter start
	call	_ft_get_signal	;  (after space) and calls function.
	mov		rdx, 1			; as the function returns the offset as
	cmp		rax, 0			;  well as the sign in RAX, we separate
	jge		.positive_skip	;  both. Sign goes to RDX, offset (count)
	mov		rdx, -1			;  goes to RCX, right after we multipying RAX
	push	rdx				;  by -1 if negative. RDX is preserved as it
	mul		rdx				;  is changed by MUL.
	pop		rdx	
.positive_skip:			; Then, we set signal to rdx for later
	mov		rcx, rax
	pop		rsi
	push	rdi
	push	rdx
	add		rdi, rcx		; RCX (offset) is added to RDI to pass the pointer
	call	_ft_get_numbers	;  to the first position of our number
	pop		rdx				;  (without spaces) or signs.
	pop		rdi
	mul		rdx
	ret
.invalid_args:
	mov		rax, 0
	ret

section .data
spaces db ` \n\v\f\r\t\0` ; ascii spaces