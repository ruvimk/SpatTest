WindowService proc service_id:DWORD, service_param:DWORD 
	mov eax, dword ptr [service_id] 
	cmp eax, WINDOW_SETRETURN 
	jz service_setreturn 
	cmp eax, WINDOW_SWITCH 
	jz service_win_switch 
	jmp service_default 
	service_setreturn: 
		mov eax, dword ptr [service_param] 
		mov dword ptr [rWindow], eax 
		jmp service_finish 
	service_win_switch: 
		invoke DestroyWindow, [hWindow] 
		jmp service_finish 
	service_default: 
		
		jmp service_finish 
	service_finish: 
	
	xor eax, eax 
	ret 
WindowService endp 