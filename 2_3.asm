;ввод чисел и преобразование их в символьную строку

text segment 'code'
     
   EXTRN BinToAscDec:proc

	assume CS:text, DS:data	

main:
      mov      ax,data
      mov      ds,ax
      mov      dx,offset ask2msg
      mov      ah,09h
      int      21h
      xor      di,di
ReadCh:
      mov      ah,08h
      int      21h
      cmp      al,13
      je       Done
      cmp      al,'9'
      ja       ReadCh
      cmp      al,'0'
      jb       ReadCh
      mov      ah,02h
      mov      dl,al
      int      21h
      sub      al,'0'
      xor      ah,ah
      mov      cx,ax
      mov      ax,di
      mov      bx,10
      mul      bx
      add      ax,cx
      mov      di,ax
      jmp      ReadCh
Done:
      mov      ax,ds
      mov      es,ax
      mov      ax,di
      mov      number,ax
      mov      cx,1
      mov      di,offset outmsg+19
      call     BinToAscDec
      mov      dx,offset outmsg
      mov      ah,09h
      int      21h
      mov      ah,08h
      int      21h
      mov      ax,4c00h
      int      21h
text ends

data  segment
      number  dw 0
      ask2msg db 'Enter number below 65535 >$'
      outmsg  db 10,13, 'Entered numder :     $'
data ends

stk  segment stack 'stack'
     dw 128 dup (0)
stk ends
     end main