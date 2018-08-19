FullWindowHotkey proc hWnd:DWORD, key:DWORD 
	
	;; I don't know for what reason, but for some reason these hot-keys don't really work the way they're expected to. 
	
	mov eax, dword ptr [key] 
	cmp eax, VK_ESCAPE 
	jz hk_esc 
	cmp eax, VK_TAB 
	jz hk_tab 
	cmp eax, 57h 
	jz hk_w 
	cmp eax, 54h 
	jz hk_t 
	cmp eax, 53h 
	jz hk_s 
	jmp hk_default 
	
	hk_esc: 
		push dword ptr [hWnd] 
		call DestroyWindow 
		
		xor eax, eax 
		jmp hk_finish 
	hk_tab: 
		call GetFocus 
		lea ebx, f_window 
		add ebx, 4 
		lea ecx, f_finish 
		sub ecx, ebx 
		t_lp1: 
			cmp eax, dword ptr [ebx] 
			jz t_lp1s 
			add ebx, 4 
			jmp t_lp1 
		t_lp1s: 
		add ebx, 4 
		cmp ebx, offset f_finish 
		jnz @F 
			mov ebx, offset f_window + 4 
		@@: 
		push dword ptr [ebx] 
		call SetFocus 
		
		xor eax, eax 
		jmp hk_finish 
	hk_skip: 
		push dword ptr [t_w] 
		call nrandom 
		mov dword ptr [t_a], eax 
		
		push dword ptr [t_h] 
		call nrandom 
		mov dword ptr [t_b], eax 
		
		call reduce_numbers 
		
		push dword ptr 0 
		push dword ptr 0 
		push dword ptr [hWnd] 
		call InvalidateRect 
		
		jmp hk_finish 
	hk_s: 
		jmp hk_skip 
	hk_w: 
		jmp hk_esc 
	hk_t: 
		jmp hk_tab 
	hk_default: 
		;; Just return -1. 
		
		mov eax, -1 
		jmp hk_finish 
	hk_finish: 
	
	ret 
FullWindowHotkey endp 

log_test proc r_o_w:DWORD 
	LOCAL prevS:DWORD 
	
	mov dword ptr [prevS], string() 
	
	mov eax, dword ptr [prevS] 
	mov ebx, offset log_filename 
	call StringCopy 
	
	mov eax, ebx 
	mov ebx, offset test_log 
	call StringCopy 
	
	call GetSysTimeString 
	push eax 
	call app_log 
	
	push dword ptr string(9, "Test-Taker Number: ") 
	call app_log 
	push dword ptr offset string1 
	push dword ptr [t_taker] 
	call i2str 
	push eax 
	call app_log 
	
	push dword ptr string("; Test-Taker Gender: ") 
	call app_log 
	push dword ptr offset t_gender 
	call app_log 
	
	push dword ptr string("; Try Number: ") 
	call app_log 
	push dword ptr offset string1 
	push dword ptr [t_try] 
	call i2str 
	push eax 
	call app_log 
	push dword ptr string("; Attempt Number: ") 
	call app_log 
	push dword ptr offset string1 
	push dword ptr [t_attempt] 
	call i2str 
	push eax 
	call app_log 
	
	push dword ptr string("; Answer Right?: ") 
	call app_log 
	push dword ptr [r_o_w] 
	call app_log 
	
	push dword ptr string("; Attempt Profile (in milliseconds): ") 
	call app_log 
	mov eax, dword ptr [t_time2] 
	sub eax, dword ptr [t_time1] 
	push dword ptr offset string1 
	push eax 
	call i2str 
	push eax 
	call app_log 
	
	push dword ptr string(59, 13, 10) 
	call app_log 
	
	
	mov eax, dword ptr [prevS] 
	mov ebx, offset log_filename 
	xchg eax, ebx 
	call StringCopy 
	
	ret 
log_test endp 