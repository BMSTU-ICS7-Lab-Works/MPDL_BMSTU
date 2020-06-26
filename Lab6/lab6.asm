code segment

assume cs:code,ds:code

org 100h         ;загрузочная часть программы

f10: jmp start      ;область  данных  резидентной  части.

key dw 5555h

print db ' 00:00:00 '

oldvect dd 0

decode  proc        
	db 0D4h,10h	
	add ax,'00'	
	mov     print[bx + 1],  ah
	mov     print[bx + 2],  al
	add     bx,  3      
	ret                              
decode  endp                            


newvect:

push es
push bx
push cx
push dx
push si
push di


cmp ah, 0

je proceed

cmp ah, 10h

jne exit1

proceed:          ;вызов стандартного обработчика
pushf
call cs:oldvect
cmp ax, 1400h

jne exit

mov di, ax
mov ah,3
mov bh,0
int 10h
mov si, dx

;mov     ah,  2                   
;int     1Ah                      

;xor     bx,  bx                  
;mov     al,  ch                  
;call    decode                  
;mov     al,  cl                
;call    decode                   
;mov     al,  dh                 
;call    decode

mov cx,10
mov bx,offset print
m1:mov ah,0eh
mov al,cs:[bx]
int 10h
inc bx
loop m1     


mov ah, 0
int 1ah
mov bx, dx
add bx, 50
m2:  mov ah, 0
int 1ah
cmp bx, dx
ja m2

;Восстановление позиции курсора
mov dx, si
mov ah,2
mov bh,0
int 10h       

;стирание надписи

mov   ah,0ah
mov   al,' '
mov   cx,10
mov   bh,0
int 10h

mov ax, di       ; восстанавление кода клавиши

exit:


pop di
pop si
pop dx
pop cx
pop bx
pop es        

iret    ;возвращение управления фоновой программе

;возвращение управления стандартному обработчику

exit1:

pop di
pop si
pop dx
pop cx
pop bx
pop es

jmp cs:oldvect


start:


mov ah,35h
mov al, 16h
int 21h


cmp word ptr es:[103h],5555h

jz inst


mov word ptr oldvect,bx
mov word ptr oldvect+2,es


mov dx,offset newvect
mov ah,25h
mov al, 16h
int 21h


mov dx,offset start
int 27h


inst:
mov ah,9
mov dx,offset print2
int 21h
mov ah,4ch
int 21h


print2 db 'Program is already installed$'

code ends

end f10