;вывод графика y=s*sqrt(x)

text segment 'code'
     assume CS:text, DS:data

main:
      mov      ax,data
      mov      ds,ax

      mov      ah,0
      mov      al,10h
      int      10h
      finit
      fild     s
      mov      cx,400
line:
      push     cx
      fild     x
      fsqrt    
      fmul     ST,ST(1)
      fistp    y
      mov      ah,0ch
      mov      al,4
      mov      bh,0
      mov      cx,x
      mov      dx,100
      sub      dx,y
      int      10h
      inc      x
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
      s        dw 4
      y        dw ?
      x        dw 0
data ends

stk  segment stack 'stack'
     dw 128 dup (0)
stk ends
     end main
