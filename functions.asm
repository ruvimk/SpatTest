option prologue:none 
option epilogue:none 

GetGridQuadrilateral proc      ;; big_quad:DWORD, pts:DWORD, grid_w:DWORD, grid_h:DWORD, quad_x:DWORD, quad_y:DWORD 
	;; GetGridQuadrilateral(pointer to grid quadrilateral points array, pointer to output quadrilateral points array, 
	;;     grid X coordinate count, grid Y coordinate count, the X grid position for the new quadrilateral, 
	;;     the Y grid position for the quadrilateral); 
	enter 32, 0 
	
	big_quad                          equ  ebp + 8 
	pts                               equ  ebp + 12 
	grid_w                            equ  ebp + 16 
	grid_h                            equ  ebp + 20 
	quad_x                            equ  ebp + 24 
	quad_y                            equ  ebp + 28 
	
	mov dword ptr [ebp-8], space(32) 
	
	mov esi, space(32) 
	
	mov eax, dword ptr [big_quad] 
	mov ebx, eax 
	
	mov eax, dword ptr [ebx+4] 
	sub eax, dword ptr [ebx+28] 
	neg eax 
	mov dword ptr [ebp-4], eax 
	
	mov ecx, dword ptr [quad_y] 
	imul ecx 
	mov ecx, dword ptr [grid_h] 
	idiv ecx 
	add eax, dword ptr [ebx+4] 
	mov dword ptr [ebp-12], eax 
	
	mov eax, dword ptr [ebp-4] 
	mov ecx, dword ptr [quad_y] 
	inc ecx 
	imul ecx 
	mov ecx, dword ptr [grid_h] 
	idiv ecx 
	add eax, dword ptr [ebx+4] 
	mov dword ptr [ebp-16], eax 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	mov eax, dword ptr [ebp-12] 
	mov dword ptr [ebx+4], eax 
	mov eax, dword ptr [ebp-16] 
	mov dword ptr [ebx+12], eax 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	mov eax, dword ptr [ebx+0] 
	sub eax, dword ptr [ebx+24] 
	neg eax 
	mov dword ptr [ebp-4], eax 
	
	mov ecx, dword ptr [quad_y] 
	imul ecx 
	mov ecx, dword ptr [grid_h] 
	idiv ecx 
	add eax, dword ptr [ebx+0] 
	mov dword ptr [ebp-12], eax 
	
	mov eax, dword ptr [ebp-4] 
	mov ecx, dword ptr [quad_y] 
	inc ecx 
	imul ecx 
	mov ecx, dword ptr [grid_h] 
	idiv ecx 
	add eax, dword ptr [ebx+0] 
	mov dword ptr [ebp-16], eax 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	mov eax, dword ptr [ebp-12] 
	mov dword ptr [ebx+0], eax 
	mov eax, dword ptr [ebp-16] 
	mov dword ptr [ebx+8], eax 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	;; Now do the same thing to the other side. 
	
	mov eax, dword ptr [ebx+12] 
	sub eax, dword ptr [ebx+20] 
	neg eax 
	mov dword ptr [ebp-4], eax 
	
	mov ecx, dword ptr [quad_y] 
	imul ecx 
	mov ecx, dword ptr [grid_h] 
	idiv ecx 
	add eax, dword ptr [ebx+12] 
	mov dword ptr [ebp-12], eax 
	
	mov eax, dword ptr [ebp-4] 
	mov ecx, dword ptr [quad_y] 
	inc ecx 
	imul ecx 
	mov ecx, dword ptr [grid_h] 
	idiv ecx 
	add eax, dword ptr [ebx+12] 
	mov dword ptr [ebp-16], eax 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	mov eax, dword ptr [ebp-12] 
	mov dword ptr [ebx+20], eax 
	mov eax, dword ptr [ebp-16] 
	mov dword ptr [ebx+28], eax 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	mov eax, dword ptr [ebx+8] 
	sub eax, dword ptr [ebx+16] 
	neg eax 
	mov dword ptr [ebp-4], eax 
	
	mov ecx, dword ptr [quad_y] 
	imul ecx 
	mov ecx, dword ptr [grid_h] 
	idiv ecx 
	add eax, dword ptr [ebx+8] 
	mov dword ptr [ebp-12], eax 
	
	mov eax, dword ptr [ebp-4] 
	mov ecx, dword ptr [quad_y] 
	inc ecx 
	imul ecx 
	mov ecx, dword ptr [grid_h] 
	idiv ecx 
	add eax, dword ptr [ebx+8] 
	mov dword ptr [ebp-16], eax 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	mov eax, dword ptr [ebp-12] 
	mov dword ptr [ebx+16], eax 
	mov eax, dword ptr [ebp-16] 
	mov dword ptr [ebx+24], eax 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	;; Now we have the four points for the row that we need. 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	mov eax, dword ptr [ebx+4] 
	sub eax, dword ptr [ebx+20] 
	neg eax 
	mov dword ptr [ebp-4], eax 
	
	mov ecx, dword ptr [quad_x] 
	imul ecx 
	mov ecx, dword ptr [grid_w] 
	idiv ecx 
	add eax, dword ptr [ebx+4] 
	
	xchg ebx, esi 
	mov dword ptr [ebx+4], eax 
	xchg ebx, esi 
	
	mov eax, dword ptr [ebp-4] 
	mov ecx, dword ptr [quad_x] 
	inc ecx 
	imul ecx 
	mov ecx, dword ptr [grid_w] 
	idiv ecx 
	add eax, dword ptr [ebx+4] 
	
	xchg ebx, esi 
	mov dword ptr [ebx+12], eax 
	xchg ebx, esi 
	
	mov eax, dword ptr [ebx+0] 
	sub eax, dword ptr [ebx+16] 
	neg eax 
	mov dword ptr [ebp-4], eax 
	
	mov ecx, dword ptr [quad_x] 
	imul ecx 
	mov ecx, dword ptr [grid_w] 
	idiv ecx 
	add eax, dword ptr [ebx+0] 
	
	xchg ebx, esi 
	mov dword ptr [ebx+0], eax 
	xchg ebx, esi 
	
	mov eax, dword ptr [ebp-4] 
	mov ecx, dword ptr [quad_x] 
	inc ecx 
	imul ecx 
	mov ecx, dword ptr [grid_w] 
	idiv ecx 
	add eax, dword ptr [ebx+0] 
	
	xchg ebx, esi 
	mov dword ptr [ebx+8], eax 
	xchg ebx, esi 
	
	;; Now do the same thing to the bottom of the quadrilateral. 
	
	mov eax, dword ptr [ebx+12] 
	sub eax, dword ptr [ebx+28] 
	neg eax 
	mov dword ptr [ebp-4], eax 
	
	mov ecx, dword ptr [quad_x] 
	imul ecx 
	mov ecx, dword ptr [grid_w] 
	idiv ecx 
	add eax, dword ptr [ebx+12] 
	
	xchg ebx, esi 
	mov dword ptr [ebx+20], eax 
	xchg ebx, esi 
	
	mov eax, dword ptr [ebp-4] 
	mov ecx, dword ptr [quad_x] 
	inc ecx 
	imul ecx 
	mov ecx, dword ptr [grid_w] 
	idiv ecx 
	add eax, dword ptr [ebx+12] 
	
	xchg ebx, esi 
	mov dword ptr [ebx+28], eax 
	xchg ebx, esi 
	
	;; Now do that for the X values. 
	
	mov eax, dword ptr [ebx+8] 
	sub eax, dword ptr [ebx+24] 
	neg eax 
	mov dword ptr [ebp-4], eax 
	
	mov ecx, dword ptr [quad_x] 
	imul ecx 
	mov ecx, dword ptr [grid_w] 
	idiv ecx 
	add eax, dword ptr [ebx+8] 
	
	xchg ebx, esi 
	mov dword ptr [ebx+16], eax 
	xchg ebx, esi 
	
	mov eax, dword ptr [ebp-4] 
	mov ecx, dword ptr [quad_x] 
	inc ecx 
	imul ecx 
	mov ecx, dword ptr [grid_w] 
	idiv ecx 
	add eax, dword ptr [ebx+8] 
	
	xchg ebx, esi 
	mov dword ptr [ebx+24], eax 
	xchg ebx, esi 
	
	;; At this point we have the four coordinates that we want. 
	
	mov eax, ebx 
	xchg eax, dword ptr [ebp-8] 
	mov ebx, eax 
	
	;; Now we just have to copy them where they need to be. 
	
	mov eax, dword ptr [pts] 
	mov ebx, eax 
	
	xchg ebx, esi 
	mov eax, dword ptr [ebx+0] 
	xchg ebx, esi 
	mov dword ptr [ebx+0], eax 
	
	xchg ebx, esi 
	mov eax, dword ptr [ebx+4] 
	xchg ebx, esi 
	mov dword ptr [ebx+4], eax 
	
	xchg ebx, esi 
	mov eax, dword ptr [ebx+8] 
	xchg ebx, esi 
	mov dword ptr [ebx+8], eax 
	
	xchg ebx, esi 
	mov eax, dword ptr [ebx+12] 
	xchg ebx, esi 
	mov dword ptr [ebx+12], eax 
	
	xchg ebx, esi 
	mov eax, dword ptr [ebx+16] 
	xchg ebx, esi 
	mov dword ptr [ebx+24], eax 
	
	xchg ebx, esi 
	mov eax, dword ptr [ebx+20] 
	xchg ebx, esi 
	mov dword ptr [ebx+28], eax 
	
	xchg ebx, esi 
	mov eax, dword ptr [ebx+24] 
	xchg ebx, esi 
	mov dword ptr [ebx+16], eax 
	
	xchg ebx, esi 
	mov eax, dword ptr [ebx+28] 
	xchg ebx, esi 
	mov dword ptr [ebx+20], eax 
	
	
	leave 
	ret 24 
GetGridQuadrilateral endp 

GetGridQuad: jmp GetGridQuadrilateral 

ScaleQuadrilateral proc                ;; ExpandQuadrilateral(the_quad, now_x, now_y, target_x, target_y); 
	enter 4, 0 
	
	mov dword ptr [ebp-4], 0 
	
	mov eax, dword ptr [ebp+8] 
	mov ebx, eax 
	
	lp1: 
		mov eax, dword ptr [ebp-4] 
		cmp eax, 4 
		jnl lp1s 
		
		mov eax, dword ptr [ebx+0] 
		mov ecx, dword ptr [ebp+20] 
		imul ecx 
		mov ecx, dword ptr [ebp+12] 
		idiv ecx 
		mov dword ptr [ebx+0], eax 
		
		mov eax, dword ptr [ebx+4] 
		mov ecx, dword ptr [ebp+24] 
		imul ecx 
		mov ecx, dword ptr [ebp+16] 
		idiv ecx 
		mov dword ptr [ebx+4], eax 
		
		add ebx, 8 
		
		inc dword ptr [ebp-4] 
		jmp lp1 
	lp1s: 
	
	leave 
	ret 20 
ScaleQuadrilateral endp 

ScaleQuad: jmp ScaleQuadrilateral 