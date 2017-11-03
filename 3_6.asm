;управление курсором с помощью клавиатуры

text	segment 'code'
	assume CS:text, DS:data

cursor	proc			; рисуется крестик
	mov	cx,16		; 16 точек для первой линии
	mov	si,curx		; загрузка координаты по х
line1:				; рисование горизонтальной линии
	push	cx		; сохранение счетчика
	mov	ah,0ch		; рисование точки
	mov	al,color	
	mov	bh,0
	mov	cx,si
	sub	cx,8		; курсор рисуется в цетре
	mov	dx,cury	
	int	10h
	inc	si		; увелечение координаты на 1
	pop	cx		; восстановление счетчика
	loop	line1		
	
	mov	cx,16
	mov	si,cury
line2:				; рисование вертикальной линии
	push	cx		;сохранение счетчика
	mov	ah,0ch
	mov	al,color
	mov	bh,0
	mov	cx,curx
	mov	dx,si
	sub	dx,8
	int	10h
	inc	si		;увеоичение на 1
	pop	cx
	loop	line2
	ret
cursor	endp

main	proc
	mov	ax,data
	mov	ds,ax

	mov	ah,00h
	mov	al,10h
	int	10h

	mov	curx,600	;установка начальных координат 
	mov	cury,300
	call	cursor		;вызов процидуры рисования курсора
readkey:
	mov	ah,08h    	;считывает код нажатой клавиши
	int	21h		;запуск
	cmp	al,4bh		;стрелка в лево
	je	left
	cmp	al,4dh		;стрелка вправо 
	je	right
	cmp	al,48h   	;стрелка вверх
	je	up
	cmp	al,50h		;стрелка вниз 
	je	down
	cmp	al,27		;нажатие эскейпа
	jne	readkey		;
exit:
	mov	ah,00h
	mov	al,03h
	int	10h
	mov	ax,4c00h
	int	21h
left:	
	mov	color,0		;черный цвет
	call	cursor		;вызов процед курсор 
	cmp	curx,8		;сравниваем с 8
	je	nocorr
	dec	curx		; уменьшаем на 1
nocorr:
	mov	color,4
	call	cursor		; рисуется новый курсор
	jmp	readkey
right:
	mov	color,0		; 
	call	cursor
	cmp	curx,630	; граничная координатаыы
	je	nocorr
	inc	curx		; увелечение координаты
nocorr1:
	mov	color,4
	call	cursor
	jmp	readkey

up:
	mov	color,0
	call	cursor
	cmp	cury,8
	je	nocorr2
	dec	cury
nocorr2:
	mov	color,4
	call	cursor
	jmp	readkey
down:
	mov	color,0
	call	cursor
	cmp	cury,300
	je	nocorr3
	inc	cury
nocorr3:
	mov	color,4
	call	cursor
	jmp	readkey
main	endp
text ends

data	segment
	curx	dw ?
	cury	dw ?
	color	db 4
data ends

stk	segment stack 'stack'
	dw 128 dup(0)
stk ends
     end main