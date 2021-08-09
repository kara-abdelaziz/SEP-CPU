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


; test program, it's only incremant by one the display

#addr 0x10  ; the beginning of the assembly program

incremant:
    ld   1
loop:
    out
    add  1
    jmp  loop
	nop