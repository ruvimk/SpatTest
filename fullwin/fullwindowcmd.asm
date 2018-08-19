FullWindowCmd proc hWnd:DWORD, wParam:DWORD, lParam:DWORD 
	
	mov eax, dword ptr [wParam] 
	cmp eax, 3 
	jz cmd_btn1 
	jmp cmd_default 
	
	cmd_btn1: 
		shr eax, 16 
		cmp ax, BN_CLICKED 
		jnz cmd_finish 
		
		push dword ptr 512 
		push dword ptr offset string1 
		push dword ptr [f_edit1] 
		call GetWindowText 
		
		push dword ptr 512 
		push dword ptr offset string2 
		push dword ptr [f_edit2] 
		call GetWindowText 
		
		push dword ptr offset string1 
		call str2i 
		mov dword ptr [t_x], eax 
		
		push dword ptr offset string2 
		call str2i 
		mov dword ptr [t_y], eax 
		
		call ProcessInput 
		
		jmp cmd_finish 
	cmd_default: 
		
		jmp cmd_finish 
	cmd_finish: 
	
	ret 
FullWindowCmd endp 

include processinput.asm 