FullWindowNew proc hWnd:DWORD 
	LOCAL taskbar_height:DWORD 
	LOCAL taskbar_border:DWORD 
	
	mov dword ptr [taskbar_height], 100 
	mov dword ptr [taskbar_border], 2 
	
	mov eax, dword ptr [screen_h] 
	sub eax, dword ptr [taskbar_height] 
	add eax, dword ptr [taskbar_border] 
	add eax, 35 
	push dword ptr 0 
	push dword ptr [hInstance] 
	push dword ptr 1 
	push dword ptr [hWnd] 
	push dword ptr 25 
	push dword ptr 200 
	push eax 
	push dword ptr 50 
	push dword ptr WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or ES_AUTOHSCROLL 
	push dword ptr 0 
	push dword ptr offset clsEdit 
	push dword ptr WS_EX_CLIENTEDGE or WS_TABSTOP 
	call CreateWindowEx 
	mov dword ptr [f_edit1], eax 
	
	mov eax, dword ptr [screen_h] 
	sub eax, dword ptr [taskbar_height] 
	add eax, dword ptr [taskbar_border] 
	add eax, 64 
	push dword ptr 0 
	push dword ptr [hInstance] 
	push dword ptr 2 
	push dword ptr [hWnd] 
	push dword ptr 25 
	push dword ptr 200 
	push eax 
	push dword ptr 50 
	push dword ptr WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or ES_AUTOHSCROLL 
	push dword ptr 0 
	push dword ptr offset clsEdit 
	push dword ptr WS_EX_CLIENTEDGE or WS_TABSTOP 
	call CreateWindowEx 
	mov dword ptr [f_edit2], eax 
	
	mov eax, dword ptr [screen_h] 
	sub eax, dword ptr [taskbar_height] 
	add eax, dword ptr [taskbar_border] 
	add eax, 35 
	push dword ptr 0 
	push dword ptr [hInstance] 
	push dword ptr 3 
	push dword ptr [hWnd] 
	push dword ptr 55 
	push dword ptr 100 
	push eax 
	push dword ptr 200 + 50 + 5 
	push dword ptr WS_CHILD or WS_VISIBLE or BS_DEFPUSHBUTTON 
	push dword ptr string("Enter")                                     ;; Button text. 
	push dword ptr offset clsButton 
	push dword ptr WS_TABSTOP 
	call CreateWindowEx 
	mov dword ptr [f_button1], eax 
	
	push dword ptr [f_edit1] 
	call SetFocus 
	
	push dword ptr VK_ESCAPE 
	push dword ptr 4000h         ;; MOD_NOREPEAT 
	push dword ptr WM_USER + WINDOW_ID + WINDOW_EXIT 
	push dword ptr [hWnd] 
	call RegisterHotKey 
	
	push dword ptr VK_TAB 
	push dword ptr 4000h         ;; MOD_NOREPEAT 
	push dword ptr WM_USER + WINDOW_ID + 1 
	push dword ptr [hWnd] 
	call RegisterHotKey 
	
	push dword ptr 57h 
	push dword ptr 4002h 
	push dword ptr WM_USER + WINDOW_ID + WINDOW_EXIT + 2 
	push dword ptr [hWnd] 
	call RegisterHotKey 
	
	push dword ptr 54h 
	push dword ptr 4002h 
	push dword ptr WM_USER + WINDOW_ID + 3 
	push dword ptr [hWnd] 
	call RegisterHotKey 
	
	push dword ptr 57h 
	push dword ptr 4001h 
	push dword ptr WM_USER + WINDOW_ID + WINDOW_EXIT + 4 
	push dword ptr [hWnd] 
	call RegisterHotKey 
	
	push dword ptr 54h 
	push dword ptr 4001h 
	push dword ptr WM_USER + WINDOW_ID + 5 
	push dword ptr [hWnd] 
	call RegisterHotKey 
	
	push dword ptr 53h 
	push dword ptr 4003h 
	push dword ptr WM_USER + WINDOW_ID + 6 
	push dword ptr [hWnd] 
	call RegisterHotKey 
	
	
	ret 
FullWindowNew endp 