thread1 proc 
	enter 8, 0 
	
	mov dword ptr [ebp-4], 0 
	
	lp1: 
		mov eax, dword ptr [rWindow] 
		cmp eax, dword ptr [ebp-4] 
		jz lp1 
		
		push dword ptr string() 
		push eax 
		call i2str 
		push dword ptr string(13, 10) 
		push eax 
		push dword ptr string(9, "rWindow= ") 
		call GetSysTimeString 
		push eax 
		push dword ptr string("rWindow_log.txt") 
		call set_log 
		mov dword ptr [ebp-8], eax 
		call app_log 
		call app_log 
		call app_log 
		call app_log 
		push dword ptr [ebp-8] 
		call set_log 
		
		cmp dword ptr [rWindow], WINDOW_EXIT 
		jnz lp1 
	lp1s: 
	
	leave 
	ret 
thread1 endp 