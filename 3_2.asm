text	segment 'code'
	assume CS:text, DS:data

main:
	mov	ax,data
	mov	ds,ax

	mov	ah,00h
	mov	al,00h	; установка графического режима № 10
	int	10h
	finit		; расчет координат линии
	fild	ix1
	fild	dv
	fdiv	
	fstp	x1
	fild	ix2
	fild	dv
	fdiv
	fstp	x2
	fild	iy1
	fild	dv
	fdiv
	fstp	y1
	fild	iy2
	fild	dv
	fdiv
	fstp	y2
	
	fld	x1
	fld	y2
	fmul	ST,ST(1)
	fstp	x1y2
	fld	x2
	fld	y1
	fmul	ST,ST(1)
	fstp	x2y1
	fld	x1y2
	fsub
	fstp	x1y2mx2y1
	fld	x1
	fld	x2
	fsub
	fstp	x1mx2
	fld	x1
	fld	x2
	fsub
	fstp	x1y2mx2y1
	fld	x1
	fld	x2
	fsub
	fstp	x1mx2
	fld	y1
	fld	y2
	fsub
	fstp	y1my2
	fld	x1y2mx2y1
	fld	x1mx2
	fdiv
	fstp	bm100
	fld	bm100
	fild	dv
	fmul
	fstp	b

	fld	y1my2
	fld	x1mx2
	fdiv
	fstp	k

	mov	ax,ix1
	mov	bx,ix2
	cmp	ax,bx
	ja	l1
	sub	bx,ax
	mov	cycx,bx
	jmp	cont
l1:
	sub	ax,bx
	mov	cycx,ax
cont:
	mov	ax,iy1
	mov	bx,iy2
	cmp	ax,bx
	ja	l2
	sub	bx,ax
	mov	cycy,bx
	jmp	cont1
l2:
	sub	ax,bx
	mov	cycy,ax
cont1:
	mov	ax,cycx
	mov	bx,cycy
	cmp	ax,bx
	ja	l3
	mov	cx,cycy
	jmp	liney
l3:
	mov	cx,cycx
linex:
	push	cx
	mov	ah,0ch
	mov	al,4
	mov	bh,0
	mov	cx,ix1

	fild	ix1
	fld	k
	fmul
	fstp	kx
	fld	kx
	fld	b
	fadd
	fistp	ly
	fild	ly
	fild	ly
	fmul
	fsqrt
	fistp	ly
	
	mov	dx,ly
	int	10h
	cmp	cx,ix2
	ja	decc
	inc	ix1
	jmp	OK1
decc:
	dec	ix1
OK1:
	pop	cx
	loop	linex
	jmp	exit
liney:
	push	cx
	mov	ah,0ch
	mov	al,4
	mov	bh,0
	fild	iy1
	fld	b
	fsub
	fstp	ymb
	fld	ymb
	fld	k
	fdiv
	fistp	lx
	fild	lx
	fild	lx
	fmul
	fsqrt
	fistp	lx
	
	mov	cx,lx
	mov	dx,iy1
	int	10h
	cmp	dx,iy2
	ja	decc1
	inc	iy1
	jmp	OK2
decc1:
	dec	iy1
OK2:
	pop	cx
	loop	liney
exit:
	mov	ah,08h
	int	21h
	mov	ah,00h
	mov	al,03h
	int	10h
	mov	ax,4c00h
	int	21h
text ends

data	segment
	k		dd ?
	bm100		dd ?
	b		dd ?
	x1y2		dd ?
	x2y1		dd ?
	x1mx2		dd ?
	y1my2		dd ?
	x1y2mx2y1	dd ?
	y1		dd ?
	x1		dd ?
	x2		dd ?
	y2		dd ?
	ymb		dd ?
	kx		dd ?
	ix1		dw 600
	iy1		dw 100
	ix2		dw 120
	iy2		dw 300
	dv		dw 100
	cycx		dw ?
	cycy		dw ?
	lx		dw ?
	ly		dw ?
data ends

stk	segment stack 'stack'
	dw 128 dup(0)
stk ends
	end main
