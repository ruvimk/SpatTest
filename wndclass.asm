WindowClass1 proc window_process:DWORD, window_bg:DWORD 
	LOCAL wc:WNDCLASSEX 
	
	mov dword ptr [wc.cbSize], SIZEOF WNDCLASSEX 
	mov dword ptr [wc.style], CS_HREDRAW or CS_VREDRAW 
	mov eax, dword ptr [window_process] 
	mov dword ptr [wc.lpfnWndProc], eax 
	mov dword ptr [wc.cbClsExtra], 0 
	mov dword ptr [wc.cbWndExtra], 0 
	mov eax, dword ptr [hInstance] 
	mov dword ptr [wc.hInstance], eax 
	invoke LoadIcon, 0, IDI_APPLICATION 
	mov dword ptr [wc.hIcon], eax 
	mov dword ptr [wc.hIconSm], eax 
	invoke LoadCursor, 0, IDC_ARROW 
	mov dword ptr [wc.hCursor], eax 
	mov eax, dword ptr [window_bg] 
	mov dword ptr [wc.hbrBackground], eax 
	mov dword ptr [wc.lpszMenuName], 0 
	mov dword ptr [wc.lpszClassName], offset ClassName 
	
	lea ebx, wc 
	mov edx, offset window_class_1 
	xor ecx, ecx 
	lp1: 
		cmp ecx, SIZEOF WNDCLASSEX 
		jnl lp1s 
		mov al, byte ptr [ebx+ecx] 
		xchg ebx, edx 
		mov byte ptr [ebx+ecx], al 
		xchg ebx, edx 
		inc ecx 
		jmp lp1 
	lp1s: 
	
	push dword ptr offset window_class_1 
	call RegisterClassEx 
	mov ebx, string("Error:  Window class registration failed. ") 
	cmp eax, 0 
	jnz @F 
		push dword ptr 0 
		push dword ptr offset ApplicationName 
		push ebx 
		push dword ptr 0 
		call MessageBox 
	@@: 
	
	ret 
WindowClass1 endp 