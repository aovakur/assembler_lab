;запись в файл

text segment 'code'
     assume CS:text, DS:data

main:
      mov      ax,data
      mov      ds,ax
      mov      ah,3ch
      mov      cx,0
      mov      dx,offset filename
      int      21h
      mov      handle,ax
      mov      ah,40h
      mov      bx,handle
      mov      cx,buflen
      mov      dx,offset buf
      int      21h
      mov      ah,3eh
      mov      bx,handle
      int      21h
      mov      ax,4c00h
      int      21h
text ends

data  segment
      buf      db '<<String writed to file>>'
      buflen   equ $-buf
      handle   dw ?
      filename db 'C:\data.text',0
data ends

stk  segment stack 'stack'
     dw 128 dup (0)
stk ends
     end main