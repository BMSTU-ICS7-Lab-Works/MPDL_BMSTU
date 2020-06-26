EXTRN INPUT_UDEC : NEAR
EXTRN OUTPUT_UDEC : NEAR
EXTRN OUTPUT_SDEC : NEAR
EXTRN OUTPUT_SBIN : NEAR
EXTRN OUTPUT_UHEX : NEAR
PUBLIC NUMBER

DSEG SEGMENT PUBLIC 'DATA'
	FUNC DW INPUT_UDEC, OUTPUT_UDEC, OUTPUT_SDEC, OUTPUT_SBIN, OUTPUT_UHEX, EXIT
	MENU DB	10, 13, 'MENU:', 10, 13
		DB	'   0. Input number in unsigned dec', 10, 13
		DB  '   1. Output number in unsigned dec', 10, 13
		DB  '   2. Output number in signed dec', 10, 13
		DB	'   3. Output number in signed bin', 10, 13
		DB	'   4. Output number in unsigned hex', 10, 13
		DB	'   5. Exit', 10, 13
		DB  'Your choice: '
		DB  '$'
	NUMBER DW 0
DSEG ENDS

CSEG SEGMENT PUBLIC 'CODE'
	ASSUME CS:CSEG, DS:DSEG
MAIN:
	MOV AX, DSEG
	MOV DS, AX
	TRUE:
		MOV DX, OFFSET MENU
		MOV AH, 9
		INT 21h
		
		MOV AH, 1
		INT 21h
		
		SUB AL, '0'
		MOV BL, 2
		MUL BL
		MOV BX, AX
		
		MOV DL, 10
		MOV AH, 2
		INT 21h
		CALL FUNC[BX]
		MOV DL, 10
		MOV AH, 2
		INT 21h
		JMP TRUE

EXIT PROC NEAR
	MOV AH, 4Ch
	INT 21h
EXIT ENDP

CSEG ENDS
END MAIN

	