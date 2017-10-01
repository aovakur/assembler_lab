;рисование горизонтальной линии

text segment 'code'
     assume CS:text, DS:data

begin:
      mov      ax,data
      mov      ds,ax

      mov      ah,00h
      mov      al,10h
      int      10h
      mov      si,150
line:
      push     cx
      mov      ah,0ch
      mov      al,4
      mov      bh,0
      mov      cx,si
      mov      dx,175
      int      10h
      inc      si
      pop      cx
      loop     line
      mov      ah,08h
      int      21h
      mov      ah,00h
      mov      al,03h
      int      10h
      mov      ax,4c00h
      int      21h
text ends

data  segment
      sting db 80 dup (?)
data ends

stk  segment stack 'stack'
     dw 128 dup (0)
stk ends
     end begin