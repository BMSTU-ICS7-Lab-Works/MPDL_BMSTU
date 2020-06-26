EXTERN NUMBER:WORD
PUBLIC OUTPUT_SBIN

CSEG    SEGMENT PUBLIC 'CODE'
	ASSUME CS:CSEG

OUTPUT_SBIN PROC NEAR
	mov ax, SEG NUMBER
	mov ds, ax
	mov bx, NUMBER
	mov ax, 32767
	cmp bx, ax	
	mov cx, 16
	ja sign
	show:
		mov dx, '0'
		shl bx, 1
		adc dl, dh
		mov ah, 2
		int 21h
		loop show
	ret
	sign:
		neg bx
		mov ah, 2
		mov dl, '-'
		int 21h
		jmp show
	ret
OUTPUT_SBIN ENDP
CSEG ENDS
END