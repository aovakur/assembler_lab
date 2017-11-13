;рисование горизонтальной, вертикальной и наклонной линий

text segment 'code'
     assume CS:text, DS:data

draw  proc
      mov      ah,0ch
      mov      al,color
      mov      bh,vpage
      mov      cx,x
      mov      dx,y
      int      10h
      ret
draw  endp

main  proc
      mov      ax,data
      mov      ds,ax
      mov      ah,00h
      mov      al,10h
      int      10h
      mov      cx,100
;line:
;      push     cx
;      call     draw
;      inc      x
;      pop      cx
;      loop     line
;      mov      x,10
;      mov      cx,350
line1:
      push     cx
      push     x
      pop      y
      call     draw
      inc      x
      pop      cx
      loop     line1
      mov      cx,100
      mov      x,10
      mov      y,10
      mov      cx,100
line3:
      push     cx
      call     draw
      inc      y
      pop      cx
      loop     line3
      mov      cx,100
      mov      x,110
      mov      y,110
      mov      cx,100
line2:
      push     cx
      call     draw
      dec      y
      pop      cx
      loop     line2
      mov      ah,08h
      int      21h
      mov      ah,00h
      mov      al,03h
      int      10h
      mov      ax,4c00h
      int      21h
main endp

text ends

data  segment
      x       dw 10
      y       dw 10
      color   db 14
      vpage   db 0
data ends

stk  segment stack 'stack'
     dw 128 dup (0)
stk  ends
     end main
