;��������� 1_4
;����� ���������������� ������ �� ����� � ��������������� ��� ��������
 
text	segment 'code'						; ������ �������� �������� ������
	assume CS:text, DS:text					; ������ ������������� ���������� ���������

begin:								; ����� ������ ���������
	mov	ax,data						; �������� ������� �������� ������ � ������� ds ����� ax. �� ax � ds 
	mov	ds,ax						; ^
	mov	ah,09h						; �������� ������ ������� ��� ������ ������ �� �����. 09 ������� 
	mov	dx,offset message				; �������� ���������� ��� ������ 
	int	21h						; ���������� �������
	mov	ax,4c00h					; �������� ������ ������� ������ �� ���������
	int	21h						; ���������� ������� 4�
text ends							; ����� �������� �������� ������
	
	data segment						; ������ �������� �������� ������
		message db 80*25 dump(' '),10,13		; ������ 80*25 ��� ������� ������
			db 9,'Hello world!',10,13		; 9-���������. db-��������� ����������
			db 9,'Welcome fellas',10,13		; 1 ������� ����� 5 ������� ������.
			db 9,'This is a multiline',10,13	; ������ ����������� ���������� � ��������� �� ����� �������
			db 9,'formated text',10,13		; 10,13-������� �� ����� �������.
			db 9,'diplaying program$'		; ���������� ���������� message. $-����� ������
	data ends						; ����� �������� �������� ������

	stk 	segment stack 'stack'				; ������ �������� �������� �����
		dw 128 dup(0)					; ��������� ������ 128 ����� ���� "����". ��� ������ ��������� �����
	stk ends						; ����� �������� �������� �����
		end begin					; �������� ����� ����� ���������
