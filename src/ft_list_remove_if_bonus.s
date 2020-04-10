	global _ft_list_remove_if
	extern	_free
	section .text

;void ft_list_remove_if(t_list **begin_list, void *data_ref,
;						int (*cmp)(), void (*free_fct)(void *));
_ft_list_remove_if:
	push	r12					; R12 and R13 are preserved
	push	r13					;  as per calling convention
	mov		r8, rdi				; [head of the list]
	mov		r9, rdx				; R9 --> cmp function
	mov		r13, rcx			; R13 --> free_fnc function
	xor		r12, r12			; r12 -> stores previous. (starts as 0)
	mov		r11, rsi			; r11 -> data_ref to be compared
	mov		r10, [r8]			; r10 -> (data) pointer
.loop:
	cmp		r10, 0				; check if data pointer is not null.
	je		.end
	mov		rdi, [r10]			; prepares cmp function call
	mov		rsi, r11			;  (value of data pointer vs data_ref)
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
	jne		.skip_swap			;  needed. 
.remove_element:
	push	r11
	mov		r11, [r10 + 8]		; r11 in this case is next elem
			
	push	r8					
	push	r9					; prepares call for free_function to free data of the element
	push	r10					; as the R13 function (CMP) is unknown
	push	r11					;  the registers used by _ft_list_sort must
	mov		rdi, [r10]			;  be preserved
	call	r13					; free_fct function is called
	pop		r11
	pop		r10
	pop		r9
	pop		r8
								
	push	r8					
	push	r9					; prepares call for FREE to release the element itself
	push	r10					; as the Free function is an outside function
	push	r11					;  the registers used by _ft_list_sort must
	mov		rdi, r10			;  be preserved
	call	_free				; free() function is called
	pop		r11
	pop		r10
	pop		r9
	pop		r8

	cmp		r12, 0				; check if the deleted element is the head
	je		.first_element
	mov		[r12],  r11			; if not, the previous element's (->next)		
	jmp		.keep_going			;  will point to the next element.
.first_element:
	mov		[r8],  r11			; if first element was deleted, update the head
.keep_going:
	mov		r10, [r8]			; if a swap was done, start over and loop
	pop		r11					; r11 returns to be used as the data_ref
	jmp		.loop
.skip_swap:						
	mov		r12, r10			; if elem didn't match data_ref del was skipped
	add		r12, 8				; saves the element of the previous pointer
	mov		r10, [r10 + 8]		; 	and point to t_list->next
	jmp		.loop				
.end:
	pop r13
	pop r12
	ret