.data 
taskbar_points          dd \
70, 10, \
200, 10, \
200, 30, \
70, 30, \
70, 10 
platform_points         dd \
6, 4, \
23, 5, \
21, 21, \
2, 19, \
6, 4 
quad_points             dd \
0, 0, \
0, 0, \
0, 0, \
0, 0, \
0, 0 
platform_bottom         dd \
2, 19, \
21, 21, \
21, 22, \
2, 20, \
2, 19 
platform_right          dd \
23, 5, \
23, 6, \
21, 22, \
21, 21, \
23, 5 
platform_color           dd 0 
platform_bottom_color    dd 0 
platform_right_color     dd 0 
quad_color               dd 0 

.code 

FullWindowPaint proc hWnd:DWORD 
	LOCAL lpp:PAINTSTRUCT 
	LOCAL hdc:DWORD 
	LOCAL hPrevPen:DWORD 
	LOCAL hPrevBrush:DWORD 
	LOCAL hPen:DWORD 
	LOCAL hBrush:DWORD 
	LOCAL hFont:DWORD 
	LOCAL hPrevFont:DWORD 
	LOCAL taskbar_color:DWORD 
	LOCAL taskbar_height:DWORD 
	LOCAL taskbar_border:DWORD 
	LOCAL taskbar_border_color:DWORD 
	LOCAL frame_width:DWORD 
	LOCAL frame_height:DWORD 
	
	RGB 255, 120, 100 
	mov dword ptr [taskbar_color], eax 
	
	RGB 255, 50, 60 
	mov dword ptr [taskbar_border_color], eax 
	
	mov eax, 00BDBDBDh 
	mov dword ptr [platform_color], eax 
	
	mov eax, 00B0B0B0h 
	mov dword ptr [platform_bottom_color], eax 
	
	mov eax, 00A9A9A9h 
	mov dword ptr [platform_right_color], eax 
	
	RGB 255, 255, 0 
	mov dword ptr [quad_color], eax 
	
	mov dword ptr [taskbar_height], 100 
	mov dword ptr [taskbar_border], 2 
	
	mov eax, dword ptr [screen_w] 
	mov dword ptr [frame_width], eax 
	
	mov eax, dword ptr [screen_h] 
	sub eax, dword ptr [taskbar_height] 
	mov dword ptr [frame_height], eax 
	
	invoke BeginPaint, [hWnd], addr lpp 
	mov dword ptr [hdc], eax 
	
	invoke CreatePen, PS_SOLID, [taskbar_border], [taskbar_border_color] 
	mov dword ptr [hPen], eax 
	
	invoke SelectObject, [hdc], [hPen] 
	mov dword ptr [hPrevPen], eax 
	
	invoke CreateSolidBrush, [taskbar_color] 
	mov dword ptr [hBrush], eax 
	
	invoke SelectObject, [hdc], [hBrush] 
	mov dword ptr [hPrevBrush], eax 
	
	lea ebx, taskbar_points 
	mov eax, dword ptr [screen_w] 
	mov dword ptr [ebx+(1*8)+0], eax 
	mov dword ptr [ebx+(2*8)+0], eax 
	xor eax, eax 
	mov dword ptr [ebx+(0*8)+0], eax 
	mov dword ptr [ebx+(3*8)+0], eax 
	mov dword ptr [ebx+(4*8)+0], eax 
	
	mov eax, dword ptr [screen_h] 
	mov dword ptr [ebx+(2*8)+4], eax 
	mov dword ptr [ebx+(3*8)+4], eax 
	sub eax, dword ptr [taskbar_height] 
	mov dword ptr [ebx+(0*8)+4], eax 
	mov dword ptr [ebx+(1*8)+4], eax 
	mov dword ptr [ebx+(4*8)+4], eax 
	
	invoke Polygon, [hdc], offset taskbar_points, 5 
	
	;; Make a new pen and a new brush: 
	
	invoke CreatePen, PS_SOLID, 0, 0 
	mov dword ptr [hPen], eax 
	
	invoke SelectObject, [hdc], eax 
	
	invoke DeleteObject, eax 
	
	invoke CreateSolidBrush, [platform_color] 
	mov dword ptr [hBrush], eax 
	
	invoke SelectObject, [hdc], eax 
	
	invoke DeleteObject, eax 
	
	invoke Polygon, [hdc], offset platform_points, 5 
	
	invoke CreateSolidBrush, [platform_bottom_color] 
	mov dword ptr [hBrush], eax 
	invoke SelectObject, [hdc], eax 
	invoke DeleteObject, eax 
	
	invoke Polygon, [hdc], offset platform_bottom, 5 
	
	invoke CreateSolidBrush, [platform_right_color] 
	mov dword ptr [hBrush], eax 
	invoke SelectObject, [hdc], eax 
	invoke DeleteObject, eax 
	
	invoke Polygon, [hdc], offset platform_right, 5 
	
	
	invoke CreateSolidBrush, [quad_color] 
	mov dword ptr [hBrush], eax 
	invoke SelectObject, [hdc], eax 
	invoke DeleteObject, eax 
	
	push dword ptr [t_b] 
	push dword ptr [t_a] 
	push dword ptr [t_h] 
	push dword ptr [t_w] 
	push dword ptr offset quad_points 
	push dword ptr offset platform_points 
	call GetGridQuad 
	
	mov ebx, offset quad_points 
	mov eax, dword ptr [ebx+0] 
	mov dword ptr [ebx+32], eax 
	mov eax, dword ptr [ebx+4] 
	mov dword ptr [ebx+36], eax 
	
	invoke Polygon, [hdc], offset quad_points, 4 
	
	invoke SelectObject, [hdc], [hPrevPen] 
	invoke SelectObject, [hdc], [hPrevBrush] 
	
	invoke CreateFont, 30, 0, 0, 0, FW_BOLD, 0, 0, 0, OEM_CHARSET, \
	OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH, string("Arial") 
	mov dword ptr [hFont], eax 
	
	invoke SetBkMode, [hdc], TRANSPARENT 
	
	invoke SelectObject, [hdc], eax 
	mov dword ptr [hPrevFont], eax 
	
	mov eax, dword ptr [screen_h] 
	sub eax, dword ptr [taskbar_height] 
	add eax, dword ptr [taskbar_border] 
	add eax, 4 
	mov edx, eax 
	
	mov eax, dword ptr [t_w] 
	dec eax 
	push dword ptr offset string1 
	push eax 
	call i2str 
	
	mov eax, dword ptr [t_h] 
	dec eax 
	push dword ptr offset string2 
	push eax 
	call i2str 
	
	mov eax, string() 
	mov ebx, string("Your Input ", 40, "range for X: 0 through ") 
	call StringCopy 
	mov ebx, offset string1 
	call StringCat 
	mov ebx, string("; range for Y: 0 through ") 
	call StringCat 
	mov ebx, offset string2 
	call StringCat 
	mov ebx, string(59, 41, 58, 32) 
	call StringCat 
	mov ebx, eax 
	call StringLength 
	invoke TextOut, [hdc], 14, edx, ebx, eax 
	
	mov eax, dword ptr [screen_h] 
	sub eax, dword ptr [taskbar_height] 
	add eax, dword ptr [taskbar_border] 
	add eax, 35 
	mov edx, eax 
	
	mov ebx, string("X: ") 
	mov eax, ebx 
	call StringLength 
	invoke TextOut, [hdc], 20, edx, ebx, eax 
	
	mov eax, dword ptr [screen_h] 
	sub eax, dword ptr [taskbar_height] 
	add eax, dword ptr [taskbar_border] 
	add eax, 64 
	mov edx, eax 
	
	mov ebx, string("Y: ") 
	mov eax, ebx 
	call StringLength 
	invoke TextOut, [hdc], 20, edx, ebx, eax 
	
	invoke SelectObject, [hdc], [hPrevFont] 
	
	invoke DeleteObject, [hFont] 
	
	invoke EndPaint, [hWnd], addr lpp 
	invoke DeleteObject, [hPen] 
	invoke DeleteObject, [hBrush] 
	ret 
FullWindowPaint endp 