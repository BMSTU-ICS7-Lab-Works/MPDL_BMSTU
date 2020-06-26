.686 
.MODEL FLAT, C 
.STACK 
.CODE 

CopystrAsm PROC C str1:dword, str2:dword, n:dword 
    mov ESI, str1
    mov EDI, str2
    pushf
    pusha
    cmp ESI, EDI
    jg fend
    fbeg:      
        CLD
        jmp toret 
    fend:
        add ESI, n
        add EDI, n
        STD 
    toret:
        mov ECX, n
        inc ECX
        REP MOVSB
        popa
        popf
        ret 
CopystrAsm ENDP
END