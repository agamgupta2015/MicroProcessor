
ARRAY1 DB 27H,31H,35H,40H,42H
MOV SI, OFFSET ARRAY1
MOV BP,5H  ; array size
MOV CL,40H

MOV AX,0   ;lower limit
MOV BX,4   ;upper limit

bin:
 CMP AX,BX
 JG exit
 MOV DX,AX
 ADD DX,BX
 SHR DX,1
 MOV DI,SI
 ADD DI,DX
 CMP CL,DS:[DI]
 JE found
 JG greater 
 JMP lesser
found:
 MOV BP,DI ; ans in bp or di
 INC BP
 HLT
greater:
 MOV AX,DX
 INC AX
 JMP bin
lesser:
 MOV BX,DX
 DEC BX
 JMP bin
 
exit:
 HLT