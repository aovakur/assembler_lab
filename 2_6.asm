;чтение из файла с обработкой ошибок

text segment 'code'
     assume CS:text, DS:data

main:
	mov	ax,data
	mov     ds,ax

	mov	ax,3d02h
	mov	dx,offset filename
	int	21h
	jc	error
	mov	handle,ax
	mov	ah,3fh
	mov	bx,handle
	mov	cx,65535
	mov	dx,offset inbuf
	int	21h
	mov	cx,ax
	mov	ah,40
	mov	bx,1
	mov	dx,offset inbuf
	int	21h
exit:
	mov	ax,4c00h
	int	21h
error:
	cmp	ax,02
	je	err1
	cmp	ax,03
	je	err2
	jmp	exit
err1:
	mov	ah,09h
	mov	dx,offset mes1
	int	21h
	jmp	exit
err2:
	mov	ah,09h
	mov	dx,offset mes2
	int	21h
	jmp	exit
text ends

data	segment
	inbuf		db 80 dup (' ')
	handle		dw ?
	filename	db 'C:\data.txt',0
	mes1		db 'File not found$'
	mes2		db 'Directory does not exist$'
data ends

stk	segment stack 'stack'
	dw 128 dup(0)
stk ends
	end main