ORG 100H
NUM1 DD 12457213H
NUM2 DD 98751465H
PRO DD 00000000H
    
 MOV PRO+4,0000H
 MOV PRO+6,0000H
    
 MOV AX,NUM1          ;ax = A_low
 MUL NUM2       ;dx:ax = A_low * B_low
 MOV PRO,AX
 MOV PRO+2,DX       ;Result = A_low * B_low

 MOV AX,NUM1+2        ;ax = A_high
 MUL NUM2       ;dx:ax = A_high * B_low
 ADD PRO+2,AX
 ADC PRO+4,DX       ;Result = A_low * B_low
                                     ; + (A_high * B_low) << 16

 MOV AX,NUM1          ;ax = A_low
 MUL NUM2+2     ;dx:ax = A_low * B_high
 ADD PRO+2,AX
 ADC PRO+4,DX       ;Result = A_low * B_low
                                     ; + (A_high * B_low) << 16
                                     ; + (A_low * B_high) << 16
 ADC PRO+6, 0   ; carry could propagate into the top chunk

 MOV AX,NUM1+2        ;ax = A_high
 MUL NUM2+2     ;dx:ax = A_high * B_high
 ADD PRO+4,AX
 ADC PRO+6,DX       ;Result = A_low * B_low
                                     ; + (A_high * B_low) << 16
                                     ; + (A_low * B_high) << 16
                                     ; + (A_high * B_high) << 32
 HLT