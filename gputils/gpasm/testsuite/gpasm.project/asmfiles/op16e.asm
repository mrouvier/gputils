	processor 18f2420

; The mpasmx indicates this error: "Error[126]  : Argument out of range (must be less than 32768)"
;	__maxrom 0xfffff

opfa8	macro i
	;; Low access memory
	i	0
	i	0,0
	i	0,1
	;; Non access memory
	i	100
	i	100,0
	i	100,1
	;; High access memory
	i	0FFF
	i	0FFF,0
	i	0FFF,1
	;; Variable defined before instruction (access)
	i	d1
	i	d1,0
	i	d1,1
	;; Variable defined after instruction (f-register)
	i	d2
	i	d2,0
	i	d2,1
	;; $ is not really good for f-register address
	i	$
	i	$,0
	i	$,1
	i	$+1
	i	$+1,0
	i	$+1,1
	i	$-1
	i	$-1,0
	i	$-1,1
	i	$-$
	i	c1-$
	i	$-c1
	i	c2-$
	i	$-c2
	i	d1-d1b
	i	d1b-d1
	i	d1+1
	i	d2-1
	endm

opwfa8	macro i
	;; Low access memory
	i	0
	i	0,1
	;; Destination "F" and "W" without being defined
	i	0,F
	i	0,F,0
	i	0,F,1
	i	0,0
	i	0,W
	i	0,W,0
	i	0,W,1
	;; Non access memory
	i	100
	i	100,1
	i	100,F
	i	100,F,0
	i	100,F,1
	i	100,0
	i	100,W
	i	100,W,0
	i	100,W,1
	;; High access memory
	i	0FFF
	i	0FFF,F
	i	0FFF,F,0
	i	0FFF,F,1
	i	0FFF,F
	i	0FFF,W,0
	i	0FFF,W,1
	i	d1
	i	d1,F
	i	d1,F,0
	i	d1,F,1
	i	d1,W
	i	d1,W,0
	i	d1,W,1
	i	d2
	i	d2,F
	i	d2,F,0
	i	d2,F,1
	i	d2,W
	i	d2,W,0
	i	d2,W,1
	i	$
	i	$,F
	i	$,F,0
	i	$,F,1
	i	$,W
	i	$,W,0
	i	$,W,1
	i	$+1
	i	$+1,F
	i	$+1,F,0
	i	$+1,F,1
	i	$+1,W
	i	$+1,W,0
	i	$+1,W,1
	i	$-1
	i	$-1,F
	i	$-1,F,0
	i	$-1,F,1
	i	$-1,W
	i	$-1,W,0
	i	$-1,W,1
	i	$-$
	i	c1-$
	i	$-c1
	i	c2-$
	i	$-c2
	i	d1-d1b
	i	d1b-d1
	i	d1+1
	i	d2-1
	endm

ba8	macro i
	i	0,0
	i	0,0,0
	i	0,0,1
	i	0,1
	i	0,1,0
	i	0,1,1
	i	0,2
	i	0,2,0
	i	0,2,1
	i	0,3
	i	0,3,0
	i	0,3,1
	i	0,4
	i	0,4,0
	i	0,4,1
	i	0,5
	i	0,5,0
	i	0,5,1
	i	0,6
	i	0,6,0
	i	0,6,1
	i	0,7
	i	0,7,0
	i	0,7,1
	;; Non access memory
	i	100,0
	i	100,0,0
	i	100,0,1
	i	0FFF,0
	i	0FFF,0,0
	i	0FFF,0,1
	i	d1,0
	i	d1,0,0
	i	d1,0,1
	i	d2,0
	i	d2,0,0
	i	d2,0,1
	i	$,0
	i	$,0,0
	i	$,0,1
	;i	$-$,1
	endm

lit8	macro i
	i	0
	i	'A'
	i	"A"
	i	0FF
	i	low $
	i	high $
	i	upper $
	i	low c1
	i	high c1
	i	upper c1
	i	low c2
	i	high c2
	i	upper c2
	i	$
	i	$+1
	i	$-1
	i	$-$
	i	c1-$
	i	$-c1
	i	c2-$
	i	$-c2
	i	d1-d1b
	i	d1b-d1
	endm

addr	macro i
	i	0
; The mpasmx indicates this error: "Error[126]  : Argument out of range (0000 not between 0000 and 3FFF)"
;	i	0x80000
	i	c1
	i	c2
	i	$
	i	$+2
	i	$-2
	endm

rbra8	macro i
	local	m1,m2
	i	m2
m1	i	$
	i	$-2
	i	$+2
	i	$-0xFE
	i	$+0x100
m2	i	m1
	endm

rbra11	macro i
	local	m1,m2
	i	m2
m1	i	$
	i	$-2
	i	$+2
	i	$-0x7FE
	i	$+0x800
m2	i	m1
	endm

	cblock 0x11
	d1
	d1b
	endc

	org 0x20
	nop
c1

	BC	0
	BN	0
	BNC	0
	BNN	0
	BNOV	0
	BNZ	0
	BOV	0
	BRA	0
	BZ	0
	RCALL	0

	BC	100
	BN	100
	BNC	100
	BNN	100
	BNOV	100
	BNZ	100
	BOV	100
	BRA	100
	BZ	100
	RCALL	100

	BC	c1
	BN	c1
	BNC	c1
	BNN	c1
	BNOV	c1
	BNZ	c1
	BOV	c1
	BRA	c1
	BZ	c1
	RCALL	c1

	;; Required to allow branches to $-0x7fe
	org	0x800

	lit8	ADDLW
	opwfa8	ADDWF
	opwfa8	ADDWFC
	lit8	ANDLW
	opwfa8	ANDWF
	rbra8	BC
	ba8	BCF
	rbra8	BN
	rbra8	BNC
	rbra8	BNN
	rbra8	BNOV
	rbra8	BNZ
	rbra8	BOV
	rbra11	BRA
	ba8	BSF
	ba8	BTFSC
	ba8	BTFSS
	ba8	BTG
	rbra8	BZ
	addr	CALL
; The mpasmx indicates this error: "Error[126]  : Argument out of range (2346 not between 0000 and 3FFF)"
;	CALL	0x12346,0
; The mpasmx indicates this error: "Error[126]  : Argument out of range (2346 not between 0000 and 3FFF)"
;	CALL	0x12346,1
	opfa8	CLRF
	CLRWDT     
	opwfa8	COMF
	opfa8	CPFSEQ
	opfa8	CPFSGT
	opfa8	CPFSLT
	DAW
	opwfa8	DECF
	opwfa8	DECFSZ
	opwfa8	DCFSNZ
	addr	GOTO
	opwfa8	INCF
	opwfa8	INCFSZ
	opwfa8	INFSNZ
	lit8	IORLW
	opwfa8	IORWF

	LFSR    0,0
	LFSR    0,0FFF
	LFSR    0,d1
	LFSR    0,d2
	LFSR    1,0
	LFSR    1,d1
	LFSR    1,d2
	LFSR    1,0FFF
	LFSR    2,0
	LFSR    2,d1
	LFSR    2,d2
	LFSR    2,0FFF

	opwfa8	MOVF

	MOVFF	0, 0
	MOVFF	0FFF, 0
	MOVFF	0FFF, d1
	MOVFF	d1, d2
	MOVFF	d2, d1
	MOVFF	$, d1
	MOVFF	$, d2
	MOVFF	$+1, d1
	MOVFF	$-1, d1
	MOVFF	$, $
;        MOVFF   0,0FFF               ;;Illegal operations on this device (movff TOS[U | H | L])  
;        MOVFF   0FFF,0FFF

	MOVLB   0
	MOVLB   0F                ;40
	MOVLB	d1
	MOVLB	d2
	
	lit8	MOVLW
	opfa8	MOVWF
	lit8	MULLW
	opfa8	MULWF
	opfa8	NEGF

	NOP
	POP
	PUSH

	rbra11	RCALL

	RESET
	RETFIE
	RETFIE	0
	RETFIE	1

	lit8	RETLW

	RETURN
	RETURN	0
	RETURN	1

	opwfa8	RLCF
	opwfa8	RLNCF
	opwfa8	RRCF
	opwfa8	RRNCF
	opfa8	SETF

	SLEEP

	lit8	SUBLW
	opwfa8	SUBFWB
	opwfa8	SUBWF
	opwfa8	SUBWFB
	opwfa8	SWAPF

	TBLRD *  
	TBLRD *+ 
	TBLRD *- 
	TBLRD +* 

	TBLWT *  
	TBLWT *+ 
	TBLWT *- 
	TBLWT +* 

	opfa8	TSTFSZ
	lit8	XORLW
	opwfa8	XORWF

	BC	c2
	BN	c2
	BNC	c2
	BNN	c2
	BNOV	c2
	BNZ	c2
	BOV	c2
	BRA	c2
	BZ	c2
	RCALL	c2
	
	banksel	d1
	banksel	d2

	pagesel	c1
	pagesel c2

	DW	c1,c2

c2

	cblock 0x101
	d2
	endc

	END
