.MODEL FLAT, C 
.STACK 
.DATA 
testQword dq 1234567890ABCDEFh
.CODE 

DecAsm PROC C num1:QWord, num2:QWord, res:Qword
    finit
    fld num1
    fsub num2
    fstp res
    fwait
    ret 
DecAsm ENDP
END