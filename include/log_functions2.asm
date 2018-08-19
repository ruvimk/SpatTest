GetSysTimeString proc 
	push ebp 
	mov ebp, esp 
	sub esp, 512 + SIZEOF SYSTEMTIME 
	
	time01                                equ  ebp - (512 + SIZEOF SYSTEMTIME) 
	
	lea eax, [ebp-512] 
	mov ebx, string(0) 
	call StringCopy 
	
	lea eax, [time01] 
	push eax 
	call GetSystemTime 
	
	
	;; The day of week. 
	lea ebx, [time01] 
	xor eax, eax 
	mov ax, word ptr [ebx+4] 
	
	mov ebx, string("Sun", 0, "Mon", 0, "Tue", 0, "Wed", 0, "Thu", 0, "Fri", 0, "Sat", 0) 
	
	mov cx, 4 
	mul cx 
	add ebx, eax 
	
	lea eax, [ebp-512] 
	
	call StringCat 
	
	mov ebx, string(44, 32) 
	call StringCat 
	
	
	;; The day of month. 
	lea ebx, [ebp-512] 
	mov eax, ebx 
	call StringLength 
	add ebx, eax 
	mov edx, ebx 
	
	xor eax, eax 
	lea ebx, [time01] 
	mov ax, word ptr [ebx+6] 
	
	push edx 
	push eax 
	call i2str 
	
	push eax 
	call check_number_1 
	
	lea eax, [ebp-512] 
	mov ebx, string(32) 
	call StringCat 
	
	
	;; The month. 
	xor eax, eax 
	lea ebx, [time01] 
	mov ax, word ptr [ebx+2] 
	
	dec ax   ;; The month origin is at 1. We decrement the number to lower the origin to 0. 
	
	mov ebx, string("Jan", 0, "Feb", 0, "Mar", 0, "Apr", 0, "May", 0, "Jun", 0, "Jul", 0, "Aug", 0, "Sep", 0, "Oct", 0, "Nov", 0, "Dec", 0) 
	
	mov cx, 4 
	mul cx 
	add ebx, eax 
	lea eax, [ebp-512] 
	call StringCat 
	
	mov ebx, string(32) 
	call StringCat 
	
	
	;; The year. 
	lea ebx, [ebp-512] 
	mov eax, ebx 
	call StringLength 
	add eax, ebx 
	mov edx, eax 
	
	xor eax, eax 
	lea ebx, [time01] 
	mov ax, word ptr [ebx+0] 
	
	push edx 
	push eax 
	call i2str 
	
	lea eax, [ebp-512] 
	mov ebx, string(32) 
	call StringCat 
	
	
	;; The hour. 
	lea eax, [ebp-512] 
	mov ebx, eax 
	call StringLength 
	add eax, ebx 
	mov edx, eax 
	
	xor eax, eax 
	lea ebx, [time01] 
	mov ax, word ptr [ebx+8] 
	
	push edx 
	push eax 
	call i2str 
	
	push eax 
	call check_number_1 
	
	lea eax, [ebp-512] 
	mov ebx, string(58) 
	call StringCat 
	
	
	;; The minute. 
	lea eax, [ebp-512] 
	mov ebx, eax 
	call StringLength 
	add eax, ebx 
	mov edx, eax 
	
	xor eax, eax 
	lea ebx, [time01] 
	mov ax, word ptr [ebx+10] 
	
	push edx 
	push eax 
	call i2str 
	
	push eax 
	call check_number_1 
	
	lea eax, [ebp-512] 
	mov ebx, string(58) 
	call StringCat 
	
	
	;; The second. 
	lea eax, [ebp-512] 
	mov ebx, eax 
	call StringLength 
	add eax, ebx 
	mov edx, eax 
	
	xor eax, eax 
	lea ebx, [time01] 
	mov ax, word ptr [ebx+12] 
	
	push edx 
	push eax 
	call i2str 
	
	push eax 
	call check_number_1 
	
	lea eax, [ebp-512] 
	mov ebx, string(32) 
	call StringCat 
	
	
	mov ebx, string("GMT") 
	call StringCat 
	
	
	mov ebx, eax 
	mov eax, string() 
	call StringCopy 
	
	
	mov esp, ebp 
	pop ebp 
	ret 
	check_number_1: 
		ret 4 
		mov eax, dword ptr [esp+4] 
		mov ebx, eax 
		call StringLength 
		cmp eax, 2 
		jl @F 
			xor eax, eax 
			
			ret 4 
		@@: 
		
		mov eax, ebx 
		mov ebx, string(48) 
		call SquishString 
		
		push eax 
		call check_number_1 
		
		ret 4 
GetSysTimeString endp 

app_log proc 
	push ebp 
	mov ebp, esp 
	sub esp, 8 
	
	push dword ptr 2 
	push dword ptr space(SIZEOF OFSTRUCT) 
	push dword ptr offset log_filename 
	call OpenFile 
	mov dword ptr [ebp-4], eax 
	
	cmp eax, 0 
	jnz continue001 
	
	push dword ptr 2 or 1000h 
	push dword ptr space(SIZEOF OFSTRUCT) 
	push dword ptr offset log_filename 
	call OpenFile 
	mov dword ptr [ebp-4], eax 
	
	cmp eax, 0 
	jz app_log_err 
	
	continue001: 
	
	push dword ptr FILE_END 
	push dword ptr 0 
	push dword ptr 0 
	push dword ptr [ebp-4] 
	call SetFilePointer 
	
	mov eax, dword ptr [ebp+8] 
	call StringLength 
	mov ecx, eax 
	push eax  ;; save len 
	
	lea eax, [ebp-8] 
	push dword ptr 0 
	push eax 
	push ecx 
	push dword ptr [ebp+8] 
	push dword ptr [ebp-4] 
	call WriteFile 
	cmp eax, 0 
	jz app_log_err 
	
	push dword ptr [ebp-4] 
	call CloseHandle 
	
	@@: 
	
	pop eax  ;; load len 
	cmp eax, dword ptr [ebp-8] 
	jnz app_log_err 
	
	xor eax, eax 
	leave 
	ret 4 
	
	app_log_err: 
	call GetLastError 
	leave 
	ret 
app_log endp 