.code 

FullWindow proc 
	LOCAL hwnd:DWORD 
	LOCAL msg:MSG 
	LOCAL hbg:DWORD 
	
	call FullWindow_Init 
	
	RGB 150, 150, 255 
	push eax 
	call CreateSolidBrush 
	mov dword ptr [hbg], eax 
	push eax 
	push dword ptr offset FullWindowProcess 
	call WindowClass1 
	
	push dword ptr 0 
	push dword ptr [hInstance] 
	push dword ptr 0 
	push dword ptr 0 
	push dword ptr [fullwin_h] 
	push dword ptr [fullwin_w] 
	push dword ptr [fullwin_y] 
	push dword ptr [fullwin_x] 
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
	
	invoke SetWindowLong, [hwnd], GWL_STYLE, WS_MAXIMIZE                  ;; Make the window full-screen. 
	invoke SetWindowLong, [hwnd], GWL_EXSTYLE, 0 
	
	push dword ptr SW_MAXIMIZE 
	push dword ptr [hwnd] 
	call ShowWindow 
	
	push dword ptr [hwnd] 
	call UpdateWindow 
	
	mov eax, dword ptr [hwnd] 
	mov dword ptr [f_window], eax 
	
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
	
	push dword ptr [hbg] 
	call DeleteObject 
	
	mov eax, WINDOW_START 
	ret 
FullWindow endp 

FullWindowProcess proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD 
	
	mov eax, dword ptr [uMsg] 
	cmp eax, WM_DESTROY 
	jz window_destroy 
	cmp eax, WM_CREATE 
	jz window_new 
	cmp eax, WM_COMMAND 
	jz window_cmd 
	cmp eax, WM_LBUTTONUP 
	jz window_click 
	cmp eax, WM_KEYUP 
	jz window_keyup 
	cmp eax, WM_PAINT 
	jz window_paint 
	cmp eax, WM_HOTKEY 
	jz window_hotkey 
	jmp window_default 
	
	window_destroy: 
		invoke DestroyWindow, [f_edit1] 
		invoke DestroyWindow, [f_edit2] 
		invoke DestroyWindow, [f_button1] 
		invoke PostQuitMessage, 0 
		mov dword ptr [rWindow], WINDOW_START 
		jmp window_finish 
	window_new: 
		push dword ptr [hWnd] 
		call FullWindowNew 
		jmp window_finish 
	window_cmd: 
		push dword ptr [lParam] 
		push dword ptr [wParam] 
		push dword ptr [hWnd] 
		call FullWindowCmd 
		jmp window_finish 
	window_click: 
		push dword ptr [hWnd] 
		call FullWindowClick 
		jmp window_finish 
	window_keyup: 
		mov eax, dword ptr [wParam] 
		cmp eax, 1Bh 
		jz keyup_escape 
		jmp w_keyup_finish 
		keyup_escape: 
			push dword ptr [hWnd] 
			call DestroyWindow 
			jmp w_keyup_finish 
		w_keyup_finish: 
		jmp window_finish 
	window_paint: 
		push dword ptr [lParam] 
		push dword ptr [hWnd] 
		call FullWindowPaint 
		jmp window_finish 
	window_hotkey: 
		mov eax, dword ptr [lParam] 
		shr eax, 16 
		push eax 
		push dword ptr [hWnd] 
		call FullWindowHotkey 
		cmp eax, 0 
		jnz window_default 
		
		jmp window_finish 
	window_default: 
		invoke DefWindowProc, [hWnd], [uMsg], [wParam], [lParam] 
		ret 
		jmp window_finish 
	window_finish: 
	
	xor eax, eax 
	ret 
FullWindowProcess endp 

include fullwin\fullwindowpaint.asm 
include fullwin\fullwindownew.asm 
include fullwin\fullwindowcmd.asm 
include fullwin\fullwindowclick.asm 
include fullwin\fullwindowhotkey.asm 
include fullwin\fullwindow_init.asm 