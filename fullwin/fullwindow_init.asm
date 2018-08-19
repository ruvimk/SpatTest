FullWindow_Init proc 
	
	push dword ptr MB_YESNO 
	push dword ptr offset ApplicationName 
	push dword ptr string("Are you a male or a female? (Click 'Yes' if you are a male and click 'No' if you are a female.) ") 
	push dword ptr 0 
	call MessageBox 
	mov ebx, string("M") 
	cmp eax, IDYES 
	jz @F 
		mov ebx, string("F") 
	@@: 
	mov eax, offset t_gender 
	call StringCopy 
	
	
	mov dword ptr [t_try], 1 
	
	mov dword ptr [t_attempt], 1 
	
	call get_milliseconds 
	mov dword ptr [t_time1], eax 
	
	inc dword ptr [t_taker] 
	
	
	call rand_init 
	
	
	ret 
FullWindow_Init endp 

get_milliseconds proc 
	
	
	call GetTickCount 
	
	ret 
get_milliseconds endp 