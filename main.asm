.386 
.387 
.model flat, stdcall 
option casemap:none 
include include\include.inc 
include include\rslib.inc 
include include\i2str.asm 
include include\str2i.asm 
includelib lib\str.lib 
includelib lib\rslib.lib 
.data 
include data.asm 
.data? 
include bss.asm 
.const 
WINDOW_MAIN        equ  2 
WINDOW_START       equ  1 
WINDOW_FULL        equ  4 
WINDOW_EXIT        equ  0 
WINDOW_CLOSE       equ  0 
WINDOW_ERROR       equ  -1 
WINDOW_ERR         equ  -1 
WINDOW_SWITCH      equ  16 
WINDOW_SETRETURN   equ  8 
WINDOW_SETTINGS    equ  32 
WINDOW_COMMANDS    equ  WINDOW_SWITCH 
WINDOW_ID          equ  122425                          ;; Just the program identifier. 
RGB macro red, green, blue 
	xor eax, eax 
	mov ah, blue 
	shl eax, 8 
	mov ah, green 
	mov al, red 
endm 
.code 
start: 

mov dword ptr [main_run], 1 

push dword ptr SM_CXSCREEN 
call GetSystemMetrics 
mov dword ptr [screen_w], eax 
push dword ptr SM_CYSCREEN 
call GetSystemMetrics 
mov dword ptr [screen_h], eax 

push dword ptr 0 
call GetModuleHandle 
mov dword ptr [hInstance], eax 
call GetCommandLine 
mov dword ptr [CommandLine], eax 

call main 

invoke ExitProcess, eax 

include startwin.asm 
include fullwin.asm 
include settingswindow.asm 
include msgproc.asm 
include wndclass.asm 
include main_init.asm 

option prologue:none 
option epilogue:none 

include functions.asm 

include include\log_functions2.asm 

main proc 
	enter 4, 0 
	
	mov eax, offset log_filename 
	mov ebx, string("log1.txt") 
	call StringCopy 
	
	call main_init 
	
	mov eax, WINDOW_START 
	lp1: 
		mov dword ptr [ebp-4], eax 
			push dword ptr [hInstance] 
			push dword ptr offset ClassName 
			call UnregisterClass 
		mov eax, dword ptr [ebp-4] 
		cmp eax, WINDOW_EXIT 
		jz lp1s 
		cmp eax, WINDOW_START 
		jnz lp1_over1 
			call StartWindow 
			jmp lp1 
		lp1_over1: 
		cmp eax, WINDOW_FULL 
		jnz lp1_over2 
			call FullWindow 
			jmp lp1 
		lp1_over2: 
		cmp eax, WINDOW_MAIN 
		jnz lp1_over3 
			mov eax, WINDOW_START 
			jmp lp1 
		lp1_over3: 
		cmp eax, WINDOW_SETTINGS 
		jnz lp1_over4 
			call SettingsWindow 
			jmp lp1 
		lp1_over4: 
		call GetLastError 
		jmp lp1s 
	lp1s: 
	
	leave 
	ret 
main endp 

end start 