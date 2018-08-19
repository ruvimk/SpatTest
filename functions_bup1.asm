option prologue:none 
option epilogue:none 

GetGridQuadrilateral proc      ;; big_quad:DWORD, pts:DWORD, grid_w:DWORD, grid_h:DWORD, quad_x:DWORD, quad_y:DWORD 
	;; GetGridQuadrilateral(pointer to grid quadrilateral points array, pointer to output quadrilateral points array, 
	;;     grid X coordinate count, grid Y coordinate count, the X grid position for the new quadrilateral, 
	;;     the Y grid position for the quadrilateral); 
	enter 32, 0 
	
	mov eax, dword ptr [ebp+8] 
	mov edx, eax 
	lea ebx, [ebp-32] 
	
	mov eax, dword ptr [edx+0] 
	mov word ptr [ebx+0], ax 
	mov eax, dword ptr [edx+4] 
	mov word ptr [ebx+2], ax 
	
	mov eax, dword ptr [edx+8] 
	mov word ptr [ebx+4], ax 
	mov eax, dword ptr [edx+12] 
	mov word ptr [ebx+6], ax 
	
	mov eax, dword ptr [edx+16] 
	mov word ptr [ebx+8], ax 
	mov eax, dword ptr [edx+20] 
	mov word ptr [ebx+10], ax 
	
	mov eax, dword ptr [edx+24] 
	mov word ptr [ebx+12], ax 
	mov eax, dword ptr [edx+28] 
	mov word ptr [ebx+14], ax 
	
	call f1 
	
	mov eax, dword ptr [ebp+24] 
	xchg eax, dword ptr [ebp+28] 
	mov dword ptr [ebp+24], eax 
	
	push dword ptr [ebp-32] 
	
	mov eax, dword ptr [ebp-28] 
	mov dword ptr [ebp-32], eax 
	
	mov eax, dword ptr [ebp-24] 
	mov dword ptr [ebp-28], eax 
	
	mov eax, dword ptr [ebp-20] 
	mov dword ptr [ebp-24], eax 
	
	pop dword ptr [ebp-20] 
	
	call f2 
	
	call f1 
	
	push dword ptr [ebp-32] 
	
	mov eax, dword ptr [ebp-20] 
	mov dword ptr [ebp-32], eax 
	
	mov eax, dword ptr [ebp-24] 
	mov dword ptr [ebp-20], eax 
	
	mov eax, dword ptr [ebp-28] 
	mov dword ptr [ebp-24], eax 
	
	pop dword ptr [ebp-28] 
	
	call f2 
	
	mov eax, dword ptr [ebp+12] 
	mov ebx, eax 
	lea edx, [ebp-32] 
	xor eax, eax 
	
	mov ax, word ptr [edx+0] 
	mov dword ptr [ebx+0], eax 
	mov ax, word ptr [edx+2] 
	mov dword ptr [ebx+4], eax 
	mov ax, word ptr [edx+4] 
	mov dword ptr [ebx+8], eax 
	mov ax, word ptr [edx+6] 
	mov dword ptr [ebx+12], eax 
	mov ax, word ptr [edx+8] 
	mov dword ptr [ebx+16], eax 
	mov ax, word ptr [edx+10] 
	mov dword ptr [ebx+20], eax 
	mov ax, word ptr [edx+12] 
	mov dword ptr [ebx+24], eax 
	mov ax, word ptr [edx+14] 
	mov dword ptr [ebx+28], eax 
	mov ax, word ptr [edx+16] 
	mov dword ptr [ebx+32], eax 
	
	leave 
	ret 24 
	f1: 
		mov eax, dword ptr [ebp-32] 
		mov dword ptr [ebp-16], eax 
		
		mov eax, dword ptr [ebp-28] 
		mov dword ptr [ebp-12], eax 
		
		mov eax, dword ptr [ebp-24] 
		mov dword ptr [ebp-8], eax 
		
		mov eax, dword ptr [ebp-20] 
		mov dword ptr [ebp-4], eax 
		
		call f01 
		mov word ptr [ebp-32], ax 
		call f02 
		mov word ptr [ebp-30], ax 
		
		call b1  ;;;;;;;;;;;;;;;;;;;;;; 
		
		call f03 
		mov word ptr [ebp-28], ax 
		call f04 
		mov word ptr [ebp-26], ax 
		
		call b1  ;;;;;;;;;;;;;;;;;;;;;; 
		
		call f05 
		mov word ptr [ebp-24], ax 
		call f06 
		mov word ptr [ebp-22], ax 
		
		call b1  ;;;;;;;;;;;;;;;;;;;;;; 
		
		call f07 
		mov word ptr [ebp-20], ax 
		call f08 
		mov word ptr [ebp-18], ax 
		
		call b1  ;;;;;;;;;;;;;;;;;;;;;; 
		
		jmp finish_f1 
			f01: 
				call f01a 
				mov ecx, eax 
				mov eax, dword ptr [ebp+24] 
				imul ecx 
				mov ecx, dword ptr [ebp+20] 
				idiv ecx 
				mov ecx, eax 
				xor eax, eax 
				mov ax, word ptr [ebp-16] 
				add eax, ecx 
			ret 
			f01a: 
				;; p.x - m.x 
				push ebx 
				xor eax, eax 
				xor ebx, ebx 
				mov ax, word ptr [ebp-4] 
				mov bx, word ptr [ebp-16] 
				sub eax, ebx 
				pop ebx 
			ret 
			f01b: 
				;; o.x - n.x 
				push ebx 
				xor eax, eax 
				xor ebx, ebx 
				mov ax, word ptr [ebp-8] 
				mov bx, word ptr [ebp-12] 
				sub eax, ebx 
				pop ebx 
			ret 
			f01c: 
				;; p.y - m.y 
				push ebx 
				xor eax, eax 
				xor ebx, ebx 
				mov ax, word ptr [ebp-2] 
				mov bx, word ptr [ebp-14] 
				sub eax, ebx 
				pop ebx 
			ret 
			f01d: 
				;; o.y - n.y 
				push ebx 
				xor eax, eax 
				xor ebx, ebx 
				mov ax, word ptr [ebp-6] 
				mov bx, word ptr [ebp-10] 
				sub eax, ebx 
				pop ebx 
			ret 
			f02: 
				call f01c 
				mov ecx, eax 
				mov eax, dword ptr [ebp+28] 
				imul ecx 
				mov ecx, dword ptr [ebp+16] 
				idiv ecx 
				mov ecx, eax 
				xor eax, eax 
				mov ax, word ptr [ebp-14] 
				add eax, ecx 
			ret 
			f03: 
				call f01b 
				mov ecx, eax 
				mov eax, dword ptr [ebp+24] 
				imul ecx 
				mov ecx, dword ptr [ebp+20] 
				idiv ecx 
				mov ecx, eax 
				xor eax, eax 
				mov ax, word ptr [ebp-12] 
				add eax, ecx 
			ret 
			f04: 
				call f01d 
				mov ecx, eax 
				mov eax, dword ptr [ebp+28] 
				imul ecx 
				mov ecx, dword ptr [ebp+16] 
				mov ecx, eax 
				xor eax, eax 
				mov ax, word ptr [ebp-10] 
				add eax, ecx 
			ret 
			f05: 
				call f01b 
				mov ecx, eax 
				mov eax, dword ptr [ebp+24] 
				inc eax 
				imul ecx 
				mov ecx, dword ptr [ebp+20] 
				idiv ecx 
				mov ecx, eax 
				xor eax, eax 
				mov ax, word ptr [ebp-12] 
				add eax, ecx 
			ret 
			f06: 
				call f01d 
				mov ecx, eax 
				mov eax, dword ptr [ebp+28] 
				inc eax 
				imul ecx 
				mov ecx, dword ptr [ebp+16] 
				mov ecx, eax 
				xor eax, eax 
				mov ax, word ptr [ebp-10] 
				add eax, ecx 
			ret 
			f07: 
				call f01a 
				mov ecx, eax 
				mov eax, dword ptr [ebp+24] 
				inc eax 
				imul ecx 
				mov ecx, dword ptr [ebp+20] 
				idiv ecx 
				mov ecx, eax 
				xor eax, eax 
				mov ax, word ptr [ebp-16] 
				add eax, ecx 
			ret 
			f08: 
				call f01c 
				mov ecx, eax 
				mov eax, dword ptr [ebp+28] 
				imul ecx 
				mov ecx, dword ptr [ebp+16] 
				idiv ecx 
				mov ecx, eax 
				xor eax, eax 
				mov ax, word ptr [ebp-14] 
				add eax, ecx 
			ret 
		finish_f1: 
	jmp finish_f2 
	f2: 
		mov eax, dword ptr [ebp-32] 
		call f2a 
		mov dword ptr [ebp-32], eax 
		
		mov eax, dword ptr [ebp-28] 
		call f2a 
		mov dword ptr [ebp-28], eax 
		
		mov eax, dword ptr [ebp-24] 
		call f2a 
		mov dword ptr [ebp-24], eax 
		
		mov eax, dword ptr [ebp-20] 
		call f2a 
		mov dword ptr [ebp-20], eax 
		
		jmp finish_f2 
		
		f2a: 
			;; Task: swap low-order and high-order words in the extended accumulator register. 
			push bx 
			push ax 
			shr eax, 16 
			mov bx, ax 
			pop ax 
			shl eax, 16 
			mov ax, bx 
			pop bx 
		ret 
		finish_f2: 
		ret 
		b1: 
			push dword ptr string("var inf: ") 
			call app_log 
			
			lea ebx, [ebp-32] 
			call b03 
			
			lea ebx, [ebp-28] 
			call b03 
			
			lea ebx, [ebp-24] 
			call b03 
			
			lea ebx, [ebp-20] 
			call b03 
			
			push dword ptr string("null", 13, 10) 
			call app_log 
			
			jmp finish_b03 
			b01: 
				xor eax, eax 
				mov ax, word ptr [ebx] 
				push dword ptr string() 
				push eax 
				call i2str 
				push eax 
				call app_log 
			ret 
			b02: 
				push dword ptr string(44) 
				call app_log 
			ret 
			b03: 
				push ebx 
				call b01 
				call b02 
				pop ebx 
				add ebx, 2 
				call b01 
				call b02 
				push dword ptr string(9) 
				call app_log 
			ret 
			finish_b03: 
		ret 
		finish_b1: 
GetGridQuadrilateral endp 

GetGridQuad: jmp GetGridQuadrilateral 

ExpandQuadrilateral proc                ;; ExpandQuadrilateral(the_quad, now_x, now_y, target_x, target_y); 
	enter 4, 0 
	
	mov dword ptr [ebp-4], 0 
	
	mov eax, dword ptr [ebp+8] 
	mov ebx, eax 
	
	lp1: 
		mov eax, dword ptr [ebp-4] 
		cmp eax, 4 
		jnl lp1s 
		
		mov eax, dword ptr [ebx+0] 
		mov ecx, dword ptr [ebp+20] 
		imul ecx 
		mov ecx, dword ptr [ebp+12] 
		idiv ecx 
		mov dword ptr [ebx+0], eax 
		
		mov eax, dword ptr [ebx+4] 
		mov ecx, dword ptr [ebp+24] 
		imul ecx 
		mov ecx, dword ptr [ebp+16] 
		idiv ecx 
		mov dword ptr [ebx+4], eax 
		
		add ebx, 8 
		
		inc dword ptr [ebp-4] 
		jmp lp1 
	lp1s: 
	
	leave 
	ret 20 
ExpandQuadrilateral endp 

ExpandQuad: jmp ExpandQuadrilateral 