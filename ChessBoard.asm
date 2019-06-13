TITLE	CHESS BOARD
; Program description

INCLUDE Irvine32.inc
.data

ChessBoard PROTO,squareSize:BYTE,boardLength:BYTE
LineHandler PROTO,squareSize:BYTE
DrawLine1 PROTO,squareSize:BYTE
DrawLine2 PROTO,squareSize:BYTE


.code
main PROC

	invoke	ChessBoard,6,8;

exit
main ENDP

;---------------------------------------------------------------;
ChessBoard PROC,squareSize:BYTE,
				boardLength:BYTE
;					Description:								;
;																;
;---------------------------------------------------------------;
	pushad;

	movzx	ecx,boardLength	;
	shr		ecx,1			;

	L1:	push	ecx						;
		invoke	LineHandler,squareSize	;
		pop		ecx						;
		Loop	L1						;


	popad;
	ret
ChessBoard	ENDP

;---------------------------------------------------------------;
LineHandler PROC,squareSize:BYTE								;
;					Description:								;
;																;
;---------------------------------------------------------------;
	
	movzx	ecx,squareSize	;
	shr		ecx,1			;

	L1:	push	ecx						;
		invoke	DrawLine1,squareSize	;
		pop		ecx						;
		Loop	L1						;
	
	movzx	ecx,squareSize	;
	shr		ecx,1			;
	
	L2:	push	ecx						;
		invoke	DrawLine2,squareSize	;
		pop		ecx						;
		Loop	L2						;



	ret
LineHandler	ENDP

;---------------------------------------------------------------;
DrawLine1 PROC,squareSize:BYTE									;
;					Description:								;
;																;
;---------------------------------------------------------------;

	mov	ecx,8		;
	mov		eax,219	;
	mov		edi,1	;
	
	L1:	push	ecx				;
		push	edi				;
		push	eax				;
		mov		edx,0			;
		mov		eax,edi			;
		cmp		eax,0			;
		mov		edi,2			;
		div		edi				;
		mov		eax,edx			;
		cmp		eax,0
		je		Zero			;
		mov		eax,15			;
		Zero:
		call	SetTextColor	;
		pop		eax				;
		movzx	ecx,squareSize;
		L2:	call	WriteChar;
			Loop	L2			;
		pop		edi				;
		pop		ecx				;
		inc		edi				;
		Loop	L1				;

		Call	Crlf;

	ret
DrawLine1	ENDP

;---------------------------------------------------------------;
DrawLine2 PROC,squareSize:BYTE									;
;					Description:								;
;																;
;---------------------------------------------------------------;

	mov	ecx,8		;
	mov		eax,219	;
	mov		edi,2	;
	
	L1:	push	ecx				;
		push	edi				;
		push	eax				;
		mov		edx,0			;
		mov		eax,edi			;
		cmp		eax,0			;
		mov		edi,2			;
		div		edi				;
		mov		eax,edx			;
		cmp		eax,0
		je		Zero			;
		mov		eax,15			;
		Zero:
		call	SetTextColor	;
		pop		eax				;
		movzx	ecx,squareSize;
		L2:	call	WriteChar;
			Loop	L2			;
		pop		edi				;
		pop		ecx				;
		inc		edi				;
		Loop	L1				;

		Call	Crlf;

	ret
DrawLine2	ENDP
END main