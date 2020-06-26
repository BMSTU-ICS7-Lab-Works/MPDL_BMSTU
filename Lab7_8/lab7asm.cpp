#include <iostream>
#include <string>

int my_strlen(char* stri)
{
    int len = 0;
    __asm
    {
        push ECX
        push EDI
        push EAX
        mov ecx, 100
        mov al, 0
        mov EDI, [stri]
        CLD
        REPNE SCASB
        mov eax, 100
        sub eax, ecx
        dec eax
        mov len, eax
        pop ECX
        pop EDI
        pop EAX
    }   
    return len;
}

float dec_asm(float num1, float num2)
{
    float res = 0;
    __asm
    {
        finit
        fld num1
        fsub num2
        fstp res
    }
    return res;
}

extern "C" void CopystrAsm(char* , char* , int);
extern "C" void DecAsm(float, float, float*);

float res;
int main() 
{ 
    int i = 0;
    char str1[100] = "baba yetu";
    std::cout << my_strlen(str1) << std::endl;
    
    char str2[100];
    CopystrAsm(str1, str2, my_strlen(str1));
    std::cout << str2 << std::endl;
    float first = -22;
    float second = 3;
    float res;
    res = dec_asm(first, second);
    std::cout << res << std::endl;
    return 0;
}
