.nolist
.include "m328pdef.inc"
.list

.dseg

.cseg
.org $000
; init random number generator
	ldi r16 , $3F
	ldi r22 , $05
; init led ports
    ldi r24 , $04
	out DDRB , r24
	ldi r24 , $00
	out PORTB , r24
loop:
; lfsr pseudo random number generator algorithm
	mov  r17 , r16
	andi r17 , $01
	mov  r18 , r16
	andi r18 , $02
	lsr  r18
	eor  r17 , r18
	andi r17 , $01 

	lsl  r17
    lsl  r17
	lsl  r17
	lsl  r17
	lsl  r17  	
	
	lsr  r16
	or   r16 , r17
; end of algorithm data saved in r16

	ldi  r25 , $1E
	cp   r25 , r16
	brge loop

    ldi  r25 , $3C
	cp   r16 , r25
	brge loop  	

; led switching code
	add  r23 , r16
	brbc 3 , skip
    ;PORTB.02 = 0
	ldi r24 , $04
	out PORTB , r24
	rjmp continue
skip : 
    ; PORTB.02 = 1
	ldi r24 , $00
	out PORTB , r24 

continue:
    dec  r22
	brne loop

end: jmp end
   
	 
	   	 
