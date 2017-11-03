.386

data	segment
	x360		dd 180.0
	x36		dw 360
	del		dd 0.9985
	delx		dd 1.0000004
	dely		dd 0.999997
	forcolor	db 9
	xc1		dd 320.0
	yc1		dd 175.0
	xc		dw 320
	yc		dw 175
	rx		dd 100.0
	ry		dd 70.0
	x		dw ?
	y		dw ?
	angl		dw 1
data ends

text	segment use16
	assume	CS:text, DS:data

coord	proc
	fld	rx
	fmul	del
	fstp	rx
	fld	ry
	fmul	del
	fstp	ry
	fild	xc1
	fmul	delx
	fistp	xc1
	fild	yc1
	fmul	dely
	fistp	yc1
	ret
coord endp

point	proc
	push	cx
	mov	cx,xc
	mov	ah,0ch
	mov	al,forcolor
	mov	bh,0
	fld	yc1
	fistp	yc
	mov	dx,yc
	fld	xc1
	fistp	xc
	mov	cx,xc
	sub	cx,x
	sub	dx,y
	int	10h
	pop	cx
	ret
point endp

main	proc
	mov	ax,data
	mov	ds,ax

	mov	ah,00h
	mov	al,10h
	int	10h
	mov	cx,x36

	finit
	fldpi
	fld	x360
	fdiv
	fstp	x360
do:
	fld	x360
	fild	angl
	fmul
	fsincos
	fld	ry
	fmul
	fistp	y
	fld	rx
	fmul
	fistp	y
	fld	rx
	fmul
	fistp	x
	fwait
	call	point
	inc	angl
	call	coord
	loop	do

	mov	ah,08h
	int	21h
	mov	ah,00h
	mov	al,03h
	int	10h
	mov	ax,4c00h
	int	21h
main endp
text ends

stk	segment stack 'stack'
	dw 128 dup(0)
stk ends
    end main