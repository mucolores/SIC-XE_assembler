COPY	START	0
FIRST	STL	RETADR
CLOOP	JSUB	RDREC
	LDA	LENGTH
	COMP	#0
	JEQ	ENDFIL
	JSUB	WRREC
	J	CLOOP
ENDFIL	LDA	='EOF'
	STA	BUFFER
	LDA	#3
	STA	LENGTH
	JSUB	WRREC
	LDL	@RETADR
	USE	CDATA
RETADR	RESW	1
LENGTH	RESW	1
	USE	CBLK
BUFFER	RESB	4096
BUFEND	EQU	*
MAXLEN	EQU	BUFEND-BUFFER
	USE
DEDEC	CLEAR	X
	CLEAR	A
	CLEAR	S
	+LDT	#MAXLEN
RLOOP	TD	INPUT
	JEQ	RLOOP
	RD	INPUT
	COMPR	A,S
	JEQ	EXIT
	STCH	BUFFER,X
	TIX	T
	JLT	RLOOP
EXIT	STX	LENGHTH
	RSUB
	USE	CDATA
INPUT	BYTE	X'F1'
	USE
WRREC	CLEAR	X
	LDT	LENGTH
WLOOP	TD	=X'05'
	JEQ	WLOOP
	LDCH	BUFFER,X
	WD	=X'05'
	TIX	T
	JLT	WLOOP
	RSUB
	USE	CDATA
	LTORG
	END	FIRST
