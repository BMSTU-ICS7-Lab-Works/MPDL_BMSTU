StkSeg  SEGMENT PARA STACK 'STACK'
        DB      100h DUP (0)
StkSeg  ENDS

DataS   SEGMENT WORD 'DATA' 
RowsMessage    DB   13 
		DB   10         
		DB   'Enter number of rows: '
		DB   '$'
ColsMessage    DB   13 
		DB   10         
		DB   'Enter number of cols: '
		DB   '$'
EnterMessage    DB   13 
		DB   10         
		DB   'Enter symbol: '
		DB   '$'
DefmatrMessage  DB   13 
		DB   10         
		DB   'Default matrix: '
		DB   '$'
ProcmatrMessage  DB   13 
		DB   10         
		DB   'Processed matrix: '
		DB   '$'
Rows	DB   ?
Cols    DB	 ?
Currows DB   ?
Maxvalue DB  'A'
Maxindi  DW   -1
Maxindj  DW   -1
Minvalue DB  'Z'
Minindi  DW   -1
Minindj  DW   -1
Matr    DB   9 DUP (9 DUP(0))        
DataS   ENDS

Code    SEGMENT WORD 'CODE'         
	ASSUME  CS:Code, DS:DataS 
Main:  
	mov   ax,DataS
	mov   DS,ax
	call  Matrinput
	mov	  DX,Offset DefmatrMessage
	mov   AH,9
	int   21h
	call  Matrshow
	call  Matrprocess
	mov	  DX,Offset ProcmatrMessage
	mov   AH,9
	int   21h
	call  Matrshow
	mov   AH,4Ch
	int   21h	
Matrinput:
	mov	  DX,Offset RowsMessage
	mov   AH,9
	int   21h
	
	mov	  AH,1
	int   21h
	sub   AL,'0'
	mov   Rows,AL
	
	mov	  DX,Offset ColsMessage
	mov   AH,9
	int   21h
	
	mov	  AH,1
	int   21h
	sub   AL,'0'
	mov   Cols,AL
	mov   AL,Rows
	mov   BX,0
	Rowsloop:
		
		mov   CL,Cols
		mov   SI,0
		mov   AL,9
		
		mov   Currows, BL
		mul   BL
		mov   BX,AX
		Colsloop:
			mov	  DX,Offset EnterMessage
			mov   AH,9
			int   21h
			
			mov	  AH,1
			int   21h
			
			mov   Matr[BX][SI],AL
			inc   SI
			loop  Colsloop
		mov   BL,Currows
		inc   BX
		cmp   BL,Rows
		jne   Rowsloop
	ret
	
Matrshow:
		
	mov   BX,0
	Rowsloop2:
		
		mov   CL,Cols
		mov   SI,0
		mov   AL,9
		mov   Currows, BL
		mul   BL
		mov   BX,AX
		
		mov   DL,13
		mov	  AH,2
		int   21h
		mov   DL,10
		int   21h

		Colsloop2:	
			mov   DL,Matr[BX][SI]
			int   21h
			mov   DL,' '
			int   21h
			inc   SI
			loop  Colsloop2
		mov   BL,Currows
		inc   BX
		cmp   BL,Rows
		jne   Rowsloop2
	ret
	
Matrprocess:
	mov   BX,0
	Rowsloop3:
		mov   Minindi,-1
		mov   Minindj,-1
		mov   Maxindi,-1
		mov   Maxindj,-1
		mov   Minvalue,'Z'
		mov   Maxvalue,'A'
		
		mov   CL,Cols
		mov   SI,0
		mov   AL,9
		mov   Currows, BL
		mul   BL
		mov   BX,AX
		

		Colsloop3:	
			mov   DL,Matr[BX][SI]			
			cmp   DL,Minvalue
			jna   Findmin
			retpointmin:
			cmp   DL,Maxvalue
			jnb   Findmax
			retpointmax:
			inc   SI
			loop  Colsloop3
		cmp   Minindi,-1
		jne   swap
		retpointswap:
		mov   BL,Currows
		inc   BX
		cmp   BL,Rows
		jne   Rowsloop3
	ret

	
Findmin:
	cmp DL,'A'
	jb  exitmin  
	mov	Minvalue,DL
	mov Minindi,BX
	mov Minindj,SI
	exitmin:
	jmp retpointmin
	
Findmax:
    cmp DL,'Z'
	ja  exitmax
	mov	Maxvalue,DL
	mov Maxindi,BX
	mov Maxindj,SI
	exitmax:
	jmp retpointmax
	
swap:
	mov BX,Minindi
	mov SI,Minindj
	mov DL,Maxvalue
	mov Matr[BX][SI],DL
	mov BX,Maxindi
	mov SI,Maxindj
	mov DL,Minvalue
	mov Matr[BX][SI],DL
	jmp retpointswap
	
Code    ENDS         
	END   Main