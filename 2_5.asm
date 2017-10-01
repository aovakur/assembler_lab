;чтение из файл

text segment 'code'
     assume CS:text, DS:data

main:
      mov      ax,data
      mov      ds,ax

      mov      ah,3ch
      mov      al,2
      mov      dx,offset filename
      int      21h
      mov      handle,ax
      mov      ah,3fh
      mov      bx,handle
      mov      cx,65535
      mov      dx,offset inbuf
      int      21h
      mov      cx,ax
      mov      ah,40h
      mov      bx,1
      mov      dx,offset inbuf
      int      21h
      mov      ax,4c00h
      int      21h
text ends

data  segment
      inbuf    db 80 dup (' ')
      handle   dw ?
      filename db 'C:\tasm\data.txt',0
data ends

stk  segment stack 'stack'
     dw 128 dup (0)
stk  ends
     end main