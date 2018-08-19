FullWindowClick proc hWnd:DWORD, xy:DWORD 
	LOCAL taskbar_height:DWORD 
	LOCAL taskbar_border:DWORD 
	LOCAL the_x:DWORD 
	LOCAL the_y:DWORD 
	
	mov dword ptr [taskbar_height], 100 
	mov dword ptr [taskbar_border], 2 
	
	;; eax= x; ecx= y; 
	mov eax, dword ptr [xy] 
	push ax 
	shr eax, 16 
	mov ecx, eax 
	pop ax 
	
	;; ecx= x; edx= y; 
	mov edx, ecx 
	mov ecx, eax 
	
	;; the_x= x; the_y= y; 
	mov eax, ecx 
	mov dword ptr [the_x], eax 
	mov eax, edx 
	mov dword ptr [the_y], eax 
	
	push dword ptr 0 
	call SetFocus 
	
	
	ret 
FullWindowClick endp 