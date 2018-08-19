main_init proc 
	enter 16, 0 
	; LOCAL taskbar_height:DWORD 
	; LOCAL taskbar_border:DWORD 
	; LOCAL frame_width:DWORD 
	; LOCAL frame_height:DWORD 
	
	mov dword ptr [ebp-4], 100 
	mov dword ptr [ebp-8], 2 
	
	mov eax, dword ptr [screen_w] 
	mov dword ptr [ebp-12], eax 
	
	mov eax, dword ptr [screen_h] 
	sub eax, dword ptr [ebp-4] 
	mov dword ptr [ebp-16], eax 
	
	mov dword ptr [t_w], 10 
	mov dword ptr [t_h], 10 
	
	
	;; The WM_PAINT setup: 
	
	push dword ptr [ebp-16] 
	push dword ptr [ebp-12] 
	push dword ptr 25 
	push dword ptr 25 
	push dword ptr offset platform_points 
	call ScaleQuad 
	
	lea ebx, [platform_points] 
	mov eax, dword ptr [ebx+0] 
	mov dword ptr [ebx+32], eax 
	mov eax, dword ptr [ebx+4] 
	mov dword ptr [ebx+36], eax 
	
	push dword ptr [ebp-16] 
	push dword ptr [ebp-12] 
	push dword ptr 25 
	push dword ptr 25 
	push dword ptr offset platform_bottom 
	call ScaleQuad 
	
	lea ebx, [platform_bottom] 
	mov eax, dword ptr [ebx+0] 
	mov dword ptr [ebx+32], eax 
	mov eax, dword ptr [ebx+4] 
	mov dword ptr [ebx+36], eax 
	
	push dword ptr [ebp-16] 
	push dword ptr [ebp-12] 
	push dword ptr 25 
	push dword ptr 25 
	push dword ptr offset platform_right 
	call ScaleQuad 
	
	lea ebx, [platform_right] 
	mov eax, dword ptr [ebx+0] 
	mov dword ptr [ebx+32], eax 
	mov eax, dword ptr [ebx+4] 
	mov dword ptr [ebx+36], eax 
	
	
	mov eax, offset test_log 
	mov ebx, string("test_log.txt") 
	call StringCopy 
	
	
	;; Now initialize the random numbers: 
	
	call rand_init 
	
	
	call get_milliseconds 
	mov dword ptr [t_time1], eax 
	
	
	mov dword ptr [t_taker], 0 
	
	
	leave 
	ret 0 
main_init endp 

rand_init proc 
	LOCAL i01:DWORD 
	
	push dword ptr offset time 
	call GetSystemTime 
	
	xor eax, eax 
	mov ax, word ptr [time.wSecond] 
	mov ecx, 1000 
	mul ecx 
	mov cx, word ptr [time.wMilliseconds] 
	add eax, ecx 
	
	mov dword ptr [last_rand], eax 
	
	mov dword ptr [i01], 0 
	lp1: 
		mov eax, dword ptr [i01] 
		cmp eax, dword ptr [last_rand] 
		jnl lp1s 
		
		push dword ptr [t_w] 
		call nrandom 
		
		add dword ptr [i01], 103 
		jmp lp1 
	lp1s: 
	
	mov dword ptr [i01], 0 
	lp2: 
		mov eax, dword ptr [i01] 
		cmp eax, dword ptr [time.wMilliseconds] 
		jnl lp2s 
		
		push dword ptr [t_w] 
		call nrandom 
		
		add dword ptr [i01], 17 
		jmp lp2 
	lp2s: 
	
	push dword ptr [t_w] 
	call nrandom 
	mov dword ptr [t_a], eax 
	
	push dword ptr [t_h] 
	call nrandom 
	mov dword ptr [t_b], eax 
	
	call reduce_numbers 
	
	ret 
rand_init endp 