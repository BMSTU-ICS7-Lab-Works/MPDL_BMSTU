StkSeg  SEGMENT PARA STACK 'STACK'
        DB      100h DUP (0)
StkSeg  ENDS

DataS   SEGMENT WORD 'DATA' 
Num1    DB   ? 
Num2	DB   ?        
DataS   ENDS

Code    SEGMENT WORD 'CODE'         
	ASSUME  CS:Code, DS:DataS 
DispMsg:   
	mov   ax,DataS
	mov   DS,ax
	mov	  AH,7
	int   21h
	mov   DS:Num1,AL
	mov	  AH,7
	int   21h
	mov   DS:Num2,AL	
	mov	  Dl, ' '
	mov   AH,02h
	int   21h
	mov   DL,DS:Num1
	add	  DL,DS:Num2
	sub   DL,'0'
	mov   AH,02h
	int   21h
	mov   AH,4Ch
	int   21h	
Code    ENDS         
	END   DispMsg 