EXTERN NUMBER:WORD
PUBLIC OUTPUT_UHEX

CSEG    SEGMENT PUBLIC 'CODE'
	ASSUME CS:CSEG

OUTPUT_UHEX PROC NEAR
	mov ax, SEG NUMBER
	mov ds, ax
	mov dx, NUMBER
	mov bx, dx
	mov cl,	12
	show:
		mov dx, bx
		shr dx, cl
		and dl, 0Fh
		add dl, '0'
		cmp dl, '9'
		jbe num09
		add dl, 'A'-('9'+1)
	num09:
		mov ah, 2
		int 21h
		sub cl, 4
		jnc show
		ret
OUTPUT_UHEX ENDP


CSEG ENDS
END