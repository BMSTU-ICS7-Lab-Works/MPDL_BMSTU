PUBLIC INPUT_UDEC
PUBLIC OUTPUT_UDEC
PUBLIC OUTPUT_SDEC
EXTERN NUMBER:WORD

CSEG    SEGMENT PUBLIC 'CODE'
	ASSUME CS:CSEG
	
INPUT_UDEC PROC NEAR
	mov ax, seg NUMBER
	mov ds, ax
	mov bx, 10
	mov cx, 0
	input:
		mov ah, 1
		int 21h
		cmp al, 'e'
		je finish
		mov ah, 0
		sub al, '0'
		xchg ax, cx
		mul bx
		add cx, ax
		jmp input
	finish:
		mov number, cx
		ret
INPUT_UDEC ENDP

OUTPUT_UDEC PROC NEAR
	mov ax, SEG NUMBER
	mov ds, ax
	mov ax, number
	mov bx, 10
	mov cx, 0
	count_num:
		xor dx, dx
		div bx
		add dl, '0'
		push dx
		inc cx
		test ax, ax
		jnz count_num
	show_num:
		mov ah, 2
		pop dx
		int 21h
		loop show_num
	ret
	
OUTPUT_UDEC ENDP

OUTPUT_SDEC PROC NEAR
	mov ax, SEG NUMBER
	mov ds, ax
	mov ax, number
	mov bx, 32767
	cmp ax, bx
	ja sign
	show:
		mov bx, 10
		mov cx, 0
		count_num:
			xor dx, dx
			div bx
			add dl, '0'
			push dx
			inc cx
			test ax, ax
			jnz count_num
		show_num:
			mov ah, 2
			pop dx
			int 21h
			loop show_num
		ret
	sign:
		neg ax
		mov bx, ax
		mov ah, 2
		mov dl, '-'
		int 21h
		mov ax, bx
		jmp show
	ret
OUTPUT_SDEC ENDP



CSEG ENDS
END