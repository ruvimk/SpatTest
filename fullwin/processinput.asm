ProcessInput proc 
	
	mov eax, dword ptr [t_a] 
	cmp eax, dword ptr [t_x] 
	jnz input_wrong 
	
	mov eax, dword ptr [t_b] 
	cmp eax, dword ptr [t_y] 
	jnz input_wrong 
	
	call get_milliseconds 
	mov dword ptr [t_time2], eax 
	
	push dword ptr string("yes") 
	call log_test 
	
	inc dword ptr [t_try] 
	
	mov dword ptr [t_attempt], 1 
	
	push dword ptr 0 
	push dword ptr offset ApplicationName 
	push dword ptr string("You got it right!") 
	push dword ptr [hWindow] 
	call MessageBox 
	
	call rand_init 
	
	call reduce_numbers 
	
	push dword ptr 0 
	push dword ptr 0 
	push dword ptr [hWindow] 
	call InvalidateRect 
	
	jmp finish 
	
	input_wrong: 
	call get_milliseconds 
	mov dword ptr [t_time2], eax 
	
	push dword ptr string("no") 
	call log_test 
	
	inc dword ptr [t_attempt] 
	
	push dword ptr 0 
	push dword ptr offset ApplicationName 
	push dword ptr string("You got the answer wrong; try again.") 
	push dword ptr [hWindow] 
	call MessageBox 
	
	jmp finish 
	
	finish: 
	
	call get_milliseconds 
	mov dword ptr [t_time1], eax 
	
	ret 
ProcessInput endp 

reduce_numbers proc 
	
	
	mov eax, dword ptr [t_a] 
	push ebx 
	mov bl, al 
	xor eax, eax 
	mov al, bl 
	pop ebx 
	mov dword ptr [t_a], eax 
	
	mov eax, dword ptr [t_b] 
	push ebx 
	mov bl, al 
	xor eax, eax 
	mov al, bl 
	pop ebx 
	mov dword ptr [t_b], eax 
	
	lp1: 
		mov eax, dword ptr [t_a] 
		cmp eax, dword ptr [t_w] 
		jl lp1s 
		
		sub dword ptr [t_a], 7 
		
		mov eax, dword ptr [t_a] 
		cmp eax, dword ptr [t_w] 
		jl lp1s 
		
		sub dword ptr [t_a], 3 
		
		mov eax, dword ptr [t_a] 
		cmp eax, dword ptr [t_w] 
		jl lp1s 
		
		sub dword ptr [t_a], 9 
		
		jmp lp1 
	lp1s: 
	
	lp2: 
		mov eax, dword ptr [t_b] 
		cmp eax, dword ptr [t_h] 
		jl lp2s 
		
		sub dword ptr [t_b], 7 
		
		mov eax, dword ptr [t_b] 
		cmp eax, dword ptr [t_h] 
		jl lp2s 
		
		sub dword ptr [t_b], 3 
		
		mov eax, dword ptr [t_b] 
		cmp eax, dword ptr [t_h] 
		jl lp2s 
		
		sub dword ptr [t_b], 9 
		
		jmp lp2 
	lp2s: 
	
	ret 
reduce_numbers endp 