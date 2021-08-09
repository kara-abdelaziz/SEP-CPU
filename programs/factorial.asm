; assembled on https://hlorenzi.github.io/customasm/web/

#bits 8   ; 8 bit memory layout

#ruledef  ; CPU instructions set definition
{
	
    ; definition of the 21 instructions of the SEP cpu
	
	ld   {value:i8}     => 0x08 @ value`8
	ld   ({address:u8}) => 0x04 @ address`8
	str  ({address:u8}) => 0x0b @ address`8
	add  {value:i8}     => 0x13 @ value`8
	add  ({address:u8}) => 0x0f @ address`8
	sub  {value:i8}     => 0x1a @ value`8
	sub  ({address:u8}) => 0x16 @ address`8
	nand {value:i8}     => 0x21 @ value`8
	nand ({address:u8}) => 0x1d @ address`8
	lsr                 => 0x24
	nop                 => 0x25
	jmp  {address:u8}   => 0x26 @ address`8
	jmp  ({address:u8}) => 0x28 @ address`8
	jsr  {address:u8}   => 0x2b @ address`8
	rts                 => 0x32
	push                => 0x35
	pop                 => 0x38
	cmp  {value:i8}     => 0x3f @ value`8
	cmp  ({address:u8}) => 0x3b @ address`8
	blt  {address:u8}   => 0x42 @ address`8
	bge  {address:u8}   => 0x46 @ address`8
	beq  {address:u8}   => 0x4a @ address`8
	bne  {address:u8}   => 0x4e @ address`8
	out                 => 0x52
	in                  => 0x53
	tas                 => 0x55
	tsa                 => 0x56
}

; Factorial program, calculates the factorial.
; this program is fancier in the sense that it
; uses the functions and stack mechanisms.

; passing arguments using the stack is implemented
; in the multiplication function.


#bankdef text  ; program section definition
{
    #addr 0x10
    #size 0xf0
    #outp 0x10 * 8
}

#bankdef data ; variables section definition
{
    #addr 0x00
    #size 0x10
    #outp 0x00
}

n_var:      ; n_var declaration
	#res 1

fact:       ; fact declaration
	#res 1
	
; n_var and fact are global variables for the program

a_var:      ; a_var declaration
	#res 1

b_var:      ; b_var declaration
	#res 1
	
mul_var:    ; mul_var declaration
	#res 1
	
; a_var, b_var and mul_var are local variables inside the multiplication function
 
#bank text ; program beginning

; initializations

	ld   1            ;
	str  (fact)       ; fact <- 1
	
	ld   0xff         ;
	tas               ; stack initialization
	
main:        ; main function
	
	JSR  read         ; calling read function
	
	str  (n_var)      ; n_var <- in

.loop:                ; main loop
	
	ld   (n_var)      ; passing the first argument to the 
	push              ; multiplication function through the stack

	ld   (fact)       ; passing the second argument to the 
	push	          ; multiplication function through the stack
	
	JSR  mult         ; multiplication function call
	
	pop               ; retriving the multiplication result
	pop               ; from the stack, the repetition is due
	                  ; to the empty cell in the stack	

	str  (fact)       ; fact <- fact * n_var
	
	ld   (n_var)
	sub  1
	str  (n_var)      ; n_var--

	cmp  1
	bne  .loop        ;  loop while (n_var != 1)
	
	ld   (fact)       ; calling write function
	JSR  write        ; to write the result 

end:
	in
	jmp  end 	     ;end of the program
	
read:        ; read function	

	in               ; read the keyboard
	rts              ; return
	
write:       ; write function

	out              ; display
	rts              ; return
	
mult:        ; multiplication function

	ld   0
	str  (mul_var)   ; mul_var <- 0
	
	tsa
	add  1           ; reduce the stack pointer by 1
	tas              ; to access the 2 arguments
	
	pop
	str  (b_var)     ; retriving argument 2 from the stack
	
	pop
	str  (a_var)     ; retriving argument 1 from the stack	

.loop:

	ld   (mul_var)
	add  (b_var)
	str  (mul_var)   ; mul_var <- mul_var + b_var
	
	ld   (a_var)
	sub  1
	str  (a_var)     ; a_var--
	
	cmp  0
	bne  .loop       ; loop while (a_var != 0)
	
	ld  (mul_var)
	push             ; we are left with 2 cells in the stack
	push             ; then we fill the result in both of them
	
	tsa
	sub  1           ; reinitilize the stack pointer to its
	tas              ; oroginal position by adding 1
	
	rts              ; function return
