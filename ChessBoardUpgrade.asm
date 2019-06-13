TITLE	CHESS BOARD UPGRADE
; Transforms chess board into a party
; ready battle of wits

INCLUDE Irvine32.inc
.data

ChessBoard PROTO,squareSize:BYTE,boardSize:BYTE,boardColor:DWORD
LineHandler PROTO,squareSize:BYTE,boardSize:BYTE,boardColor:DWORD
DrawLine1 PROTO,squareSize:BYTE,boardSize:BYTE,boardColor:DWORD
DrawLine2 PROTO,squareSize:BYTE,boardSize:BYTE,boardColor:DWORD


.code
main PROC

	mov		eax,500	; strobe delay
	mov		ecx,16	; times to repeat (used for color)
	L1:
		invoke	ChessBoard,6,8,ecx	; Draw board
		call	Delay				; Wait a sec
		Loop	L1					;

exit
main ENDP

;---------------------------------------------------------------;
ChessBoard PROC,squareSize	:BYTE,
				boardSize	:BYTE,
				boardColor	:DWORD
;					Description:	The main for chess board	;
;								drawing							;
;																;
;---------------------------------------------------------------;
	pushad;

	mov		dh,0	; Row 
	mov		dl,0	; Column 
	call	GotoXY	; goto row,column
	movzx	ecx,boardSize	; desired size x size
	shr		ecx,1			; Divide by 2 (2 drawing functions)

	L1:	push	ecx											; Controls amount of lines
		invoke	LineHandler,squareSize,boardSize,boardColor	;
		pop		ecx											; restore outside counter
		Loop	L1											;


	popad;
	ret
ChessBoard	ENDP

;---------------------------------------------------------------;
LineHandler PROC,squareSize	:BYTE,
				boardSize	:BYTE,
				boardColor	:DWORD
;					Description:	Handles the interaction of	;
;								Two line drawing functions		;
;																;
;---------------------------------------------------------------;
	
	movzx	ecx,squareSize	; Number of dots before color change
	shr		ecx,1			; Divide by 2 (2 drawing functions) 
	push	ecx				; Save the goods for drawline2	

	L1:	push	ecx											;
		invoke	DrawLine1,squareSize,boardSize,boardColor	;
		pop		ecx											;
		Loop	L1											;
	
	pop	ecx	; All the specifications saved for drawline2 come back
	
	L2:	push	ecx											;
		invoke	DrawLine2,squareSize,boardSize,boardColor	;
		pop		ecx											;
		Loop	L2											;


	ret
LineHandler	ENDP

;---------------------------------------------------------------;
DrawLine1 PROC,squareSize	:BYTE,
				boardSize	:BYTE,
				boardColor	:DWORD									
;					Description:	Draws in a checkerboard		;
;								pattern							;
;																;
;---------------------------------------------------------------;

	movzx	ecx,boardSize	; how many lines should it draw?
	mov		eax,219			; Needs this square symbol
	mov		edi,2			; what do mod by
	
	L1:	push	ecx				; Save
		push	edi				; Save
		push	eax				; Save
		mov		edx,0			; Clear to hold mod
		mov		eax,edi			; Mov to eax to divide
		mov		edi,2			; Mod by this number
		div		edi				; Mod is stored in edx
		mov		eax,edx			; Move mod to eax for color setting
		cmp		eax,0			; is it 0?
		mov		eax,boardColor	; Assume it is
		jne		NotZero			;
		mov		eax,15			; It was 0, so it has to be 15 now
		NotZero:
		call	SetTextColor	; Change the scenery
		pop		eax				; Loaded back up
		movzx	ecx,squareSize	; Determines the size of the square
		L2:	call	WriteChar		; Spits out character x times
			Loop	L2				;
		pop		edi				; Loaded back
		pop		ecx				; Loaded back
		inc		edi				; Makes it checkerboard
		Loop	L1				;

		Call	Crlf		; Move a line down

	ret
DrawLine1	ENDP

;---------------------------------------------------------------;
DrawLine2 PROC,squareSize	:BYTE,
				boardSize	:BYTE,
				boardColor	:DWORD							
;					Description:	Same as DrawLine1 but offset;
;								For checkerboarding reasons		;
;																;
;---------------------------------------------------------------;

	movzx	ecx,boardSize	; how many lines should it draw?
	mov		eax,219			; Needs this square symbol
	mov		edi,1			; what do mod by
	
	L1:	push	ecx				; Save
		push	edi				; Save
		push	eax				; Save
		mov		edx,0			; Clear to hold mod
		mov		eax,edi			; Mov to eax to divide
		mov		edi,2			; Mod by this number
		div		edi				; Mod is stored in edx
		mov		eax,edx			; Move mod to eax for color setting
		cmp		eax,0			; is it 0?
		mov		eax,boardColor	; Assume it is
		jne		NotZero			;
		mov		eax,15			; It was 0, so it has to be 15 now
		NotZero:
		call	SetTextColor	; Change the scenery
		pop		eax				; Loaded back up
		movzx	ecx,squareSize	; Determines the size of the square
		L2:	call	WriteChar		; Spits out character x times
			Loop	L2				;
		pop		edi				; Loaded back
		pop		ecx				; Loaded back
		inc		edi				; Makes it checkerboard
		Loop	L1				;

		Call	Crlf		; Move a line down

	ret
DrawLine2	ENDP

END main