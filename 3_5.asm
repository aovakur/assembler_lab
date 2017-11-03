;вывод звукового сигнала на PC speaker

text	segment 'code'
	assume CS:text, DS:data

begin:
	mov	ax,data
	mov	ds,ax

	mov	al,0B6h		; выполнение процедуры включения динамика
	out	43h,al		
	in	al,61h
	or	al,3
	out	61h,al

	mov	cx,50		; установка счетчика для цикла
snd:				; метка начала цикла
	push	cx		; сохранение считчика
	mov	ax,tone		; загрузка частоты
	out	42h,al		; вывод сигнала в звуковой порт
	mov	al,ah		
	out	42h,al
	mov	cx,15		; установк авторого счетчика
delay:				; начало второго цикла
	push	cx		; сохранение счетчика
	mov	cx,65535	; два пустых цикла для задержки
	loop	$
	mov	cx,65535
	loop	$		
	pop	cx		; восстановление счетчика
	loop	delay		; закрытие вложенного цикла
	pop	cx		; восстановление внешнегго счетчика
	add	tone,50		; частооту увеличить
	loop	snd		; закрытие основного цикла

	in	al,61h		; выключение динамика
	and	al,0FCh		
	out	61h,al

	mov	ax,4c00h	; выход из программы
	int	21h
text ends

data	segment
	tone dw 3000
data ends

stk	segment stack 'stack'
stk ends
    end begin
	