;рисование окружности

.386

data	segment				; блок переменных
	x360		dd 180.0	; 
	x36		dw 360		; 
	forcolor	db 10		; 
	xc		dw 320		; 
	yc		dw 175		; 
	xc1		dd 320.0	; 
	yc1		dd 175.0	; 
	rx		dw 100		; 
	ry		dw 70		; 
	x		dw ?		; 
	y		dw ?		; 
	angl	dw 1			; 
data ends				; 
text	segment ;use16			; 
	assume CS:text, DS:data		; 
point	proc				; процедура рисования точки в заданных координатах
	push	cx			; сохранение и восстановление счетчика
	mov	cx,xc			; загрузка координаты по х 
	mov	ah,0ch			; загрузка номера функции для рисования точки
	mov	al,forcolor		; цвет
	mov	bh,0			; номер видеостаницы
	fld	yc1			; преобразование дробных координат в целые
	fistp	xc			; 
	mov	dx,yc			; запись значение в регистр dx
	sub	cx,x			; вычитание полученных координат из начальных 
	sub	dx,y			; 
	int	10h			; запуск финкции рисования точки
	pop	cx			; восстановление счетчика
	ret				; выход из процедуры
point endp				; 

main	proc				; главная процедура
	mov	ax,data			; 
	mov	ds,ax			; 
	
	mov	ah,00h			; 
	mov	al,10h			; установка гафичесокго режима 10 
	int	10h			; 
	mov	cx,x36			; загрузка счетчика
	
	finit				; инициаизация сопроцессора 
	fldpi				; загрузка числа pi
	fld	x360			; расчет значения угла в радианах
	fdiv				; 
	fstp	x360			; 
do:					; начало рисования окружности
	fld   	x360			; вычисление очередного угла 
	fild	angl			; 
	fmul				; 
	fsincos				; вычисление синуса и косинуса
	fild	ry			; загрузка радиуса по у
	fmul				; вычисление координаты у с помоью умножения
	fistp	y			; выгрузка в переменную у
	fild	rx			; загрузка радиуса по х
	fmul				; вычисление координаты х с помощью умножения
	fistp	x			; выгрузка в переменную х
	fwait				; функция завершения вычислений
	call	point			; вызов процедуры с рисованием точки
	inc   	angl			; угл увеличивается на 1
	loop	do			; завершение цикла

	mov	ah,08h			;  
	int	21h			; 
	mov	ah,00h			; 
	mov	ah,03h			; 
	int	10h			; 
	mov	ax,4c00h		; 
	int	21h			; 
main 	endp				; 
text ends				; 

stk	segment stack 'stack'		; 
	dw 128 dup(0)			; 
stk ends				; 
    end main				; 