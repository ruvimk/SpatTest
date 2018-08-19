.code 

StartWindow proc 
	LOCAL hwnd:DWORD 
	LOCAL msg:MSG 
	
	push dword ptr COLOR_WINDOW + 1 
	push dword ptr offset StartWindowProcess 
	call WindowClass1 
	
	mov eax, dword ptr [startwin_h] 
	cmp eax, 150 
	jnl @F 
		mov dword ptr [startwin_h], 150 
	@@: 
	
	mov eax, dword ptr [startwin_w] 
	cmp eax, 300 
	jnl @F 
		mov dword ptr [startwin_w], 300 
	@@: 
	
	push dword ptr 0 
	push dword ptr [hInstance] 
	push dword ptr 0 
	push dword ptr 0 
	push dword ptr [startwin_h] 
	push dword ptr [startwin_w] 
	push dword ptr [startwin_y] 
	push dword ptr [startwin_x] 
	push dword ptr WS_OVERLAPPEDWINDOW 
	push dword ptr offset ApplicationName 
	push dword ptr offset ClassName 
	push dword ptr WS_EX_CLIENTEDGE 
	call CreateWindowEx 
	mov dword ptr [hwnd], eax 
	mov dword ptr [rWindow], WINDOW_ERROR 
	cmp eax, 0 
	jz ExitMessageLoop2 
	
	mov dword ptr [hWindow], eax 
	
	push dword ptr SW_SHOWDEFAULT 
	push dword ptr [hwnd] 
	call ShowWindow 
	
	push dword ptr [hwnd] 
	call UpdateWindow 
	
	mov eax, dword ptr [hwnd] 
	mov dword ptr [s_window], eax 
	
	MessageLoop: 
		mov eax, dword ptr [msg.wParam] 
		mov dword ptr [rWindow], eax 
		lea eax, rWindow 
		push eax 
		lea eax, msg 
		push eax 
		call MessageProcess 
		cmp eax, 0 
		jz ExitMessageLoop 
		jmp MessageLoop 
	ExitMessageLoop: 
		
		jmp ExitMessageLoop2 
	ExitMessageLoop2: 
	
	call GetLastError 
	push dword ptr string() 
	push eax 
	call i2str 
	push dword ptr string(13, 10) 
	push eax 
	push dword ptr string(9, "Last Error: ") 
	call GetSysTimeString 
	push eax 
	call app_log 
	call app_log 
	call app_log 
	call app_log 
	
	cmp dword ptr [main_run], 0 
	jnz @F 
		mov eax, WINDOW_EXIT 
		jmp finish 
	@@: 
	
	mov eax, WINDOW_FULL 
	
	finish: 
	
	ret 
StartWindow endp 

StartWindowProcess proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD 
	
	mov eax, dword ptr [uMsg] 
	cmp eax, WM_DESTROY 
	jz window_destroy 
	cmp eax, WM_CREATE 
	jz window_new 
	cmp eax, WM_COMMAND 
	jz window_cmd 
	cmp eax, WM_LBUTTONUP 
	jz window_click 
	cmp eax, WM_CLOSE 
	jz window_close 
	cmp eax, WM_MOVE 
	jz window_move 
	cmp eax, WM_SIZE 
	jz window_size 
	jmp window_default 
	
	window_destroy: 
		invoke DestroyWindow, [s_button1] 
		invoke DestroyWindow, [s_button2] 
		invoke PostQuitMessage, 0 
		jmp window_finish 
	window_new: 
		push dword ptr 0 
		push dword ptr [hInstance] 
		push dword ptr 1 
		push dword ptr [hWnd] 
		push dword ptr 30 
		push dword ptr 300 - 30 
		push dword ptr 8 + 30 + 5 
		push dword ptr 10 
		push dword ptr WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON 
		push dword ptr string("New Log") 
		push dword ptr offset clsButton 
		push dword ptr WS_TABSTOP 
		call CreateWindowEx 
		mov dword ptr [s_button1], eax 
		
		push dword ptr 0 
		push dword ptr [hInstance] 
		push dword ptr 2 
		push dword ptr [hWnd] 
		push dword ptr 30 
		push dword ptr 300 - 30 
		push dword ptr 8 
		push dword ptr 10 
		push dword ptr WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON 
		push dword ptr string("View Log") 
		push dword ptr offset clsButton 
		push dword ptr WS_TABSTOP 
		call CreateWindowEx 
		mov dword ptr [s_button2], eax 
		
		push dword ptr 0 
		push dword ptr [hInstance] 
		push dword ptr 3 
		push dword ptr [hWnd] 
		push dword ptr 30 
		push dword ptr 300 - 30 
		push dword ptr 8 + 30 + 5 + 30 + 5 
		push dword ptr 10 
		push dword ptr WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON 
		push dword ptr string("New Test") 
		push dword ptr offset clsButton 
		push dword ptr WS_TABSTOP 
		call CreateWindowEx 
		mov dword ptr [s_button3], eax 
		
		
		
		jmp window_finish 
	window_cmd: 
		mov eax, dword ptr [wParam] 
		cmp eax, 1 
		jz cmd_btn1 
		cmp eax, 2 
		jz cmd_btn2 
		cmp eax, 3 
		jz cmd_btn3 
		cmp eax, 4 
		jz cmd_btn4 
		jmp cmd_default 
		cmd_btn1: 
			shr eax, 16 
			cmp eax, BN_CLICKED 
			jnz cmd_finish 
			
			push dword ptr 0 
			push dword ptr FILE_ATTRIBUTE_NORMAL 
			push dword ptr CREATE_NEW 
			push dword ptr 0 
			push dword ptr 1 or 2 or 4 
			push dword ptr GENERIC_READ or GENERIC_WRITE 
			push dword ptr offset test_log 
			call CreateFile 
			
			cmp eax, 0 
			jz btn1_0 
			
			push eax 
			call CloseHandle 
			
			jmp cmd_finish 
			btn1_0: 
				call GetLastError 
				cmp eax, ERROR_FILE_EXISTS 
				jz btn1_e 
				push dword ptr 0 
				push dword ptr offset ApplicationName 
				push dword ptr string("Error in making the new log file. ") 
				push dword ptr [hWindow] 
				call MessageBox 
				jmp cmd_finish 
				btn1_e: 
					push dword ptr 0 
					push dword ptr offset ApplicationName 
					push dword ptr string("Error. The log file already exists. ") 
					push dword ptr [hWindow] 
					call MessageBox 
				jmp cmd_finish 
		cmd_btn2: 
			shr eax, 16 
			cmp eax, BN_CLICKED 
			jnz cmd_finish 
			
			mov eax, string() 
			mov ebx, string("notepad.exe ") 
			call StringCopy 
			mov ebx, offset test_log 
			call StringCat 
			
			invoke WinExec, eax, SW_SHOWNORMAL 
			
			jmp cmd_finish 
		cmd_btn3: 
			shr eax, 16 
			cmp eax, BN_CLICKED 
			jnz cmd_finish 
			
			mov dword ptr [rWindow], WINDOW_FULL 
			push dword ptr [hWindow] 
			call DestroyWindow 
			
			jmp cmd_finish 
		cmd_btn4: 
			shr eax, 16 
			cmp eax, BN_CLICKED 
			jnz cmd_finish 
			
			mov dword ptr [rWindow], WINDOW_SETTINGS 
			push dword ptr [hWindow] 
			call DestroyWindow 
			
			jmp cmd_finish 
		cmd_default: 
			
			jmp window_default 
		cmd_finish: 
		jmp window_finish 
	window_close: 
		mov dword ptr [main_run], 0 
		push dword ptr [hWnd] 
		call DestroyWindow 
		jmp window_finish 
	window_click: 
		
		
		jmp window_finish 
	window_move: 
		mov eax, dword ptr [lParam] 
		push ax 
		shr eax, 16 
		mov dword ptr [startwin_y], eax 
		pop ax 
		mov dword ptr [startwin_x], eax 
		jmp window_finish 
	window_size: 
		mov eax, dword ptr [lParam] 
		push ax 
		shr eax, 16 
		mov dword ptr [startwin_h], eax 
		pop ax 
		mov dword ptr [startwin_w], eax 
		jmp window_finish 
	window_default: 
		invoke DefWindowProc, [hWnd], [uMsg], [wParam], [lParam] 
		ret 
		jmp window_finish 
	window_finish: 
	
	xor eax, eax 
	ret 
StartWindowProcess endp 