MessageProcess proc msg:DWORD, return_value:DWORD 
	invoke GetMessage, [msg], 0, 0, 0 
	cmp eax, 0 
	jz ExitMessageLoop 
	invoke TranslateMessage, [msg] 
	invoke DispatchMessage, [msg] 
	cmp dword ptr [param], 0 
	jnz win_service 
	jmp MessageLoop 
	win_service: 
		mov eax, dword ptr [param] 
		jmp service_default 
		service_default: 
			jmp service_finish 
		service_finish: 
		mov dword ptr [param], 0 
		jmp MessageLoop 
	ExitMessageLoop: 
	xor eax, eax 
	jmp finish 
	MessageLoop: 
	or eax, -1 
	jmp finish 
	finish: 
	ret 
MessageProcess endp 