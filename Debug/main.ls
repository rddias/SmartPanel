   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  50                     ; 59 main()
  50                     ; 60 {
  52                     .text:	section	.text,new
  53  0000               _main:
  57                     ; 64 	CONFIG_UNUSED_PINS_STM8S001;
  59  0000 72145002      	bset	20482,#2
  62  0004 c65007        	ld	a,20487
  63  0007 aacf          	or	a,#207
  64  0009 c75007        	ld	20487,a
  67  000c c6500c        	ld	a,20492
  68  000f aa86          	or	a,#134
  69  0011 c7500c        	ld	20492,a
  72  0014 c65011        	ld	a,20497
  73  0017 aa95          	or	a,#149
  74  0019 c75011        	ld	20497,a
  77  001c 721a5016      	bset	20502,#5
  80  0020 7218501b      	bset	20507,#4
  81                     ; 66 	STARTUP_SWIM_DELAY_5S;
  85  0024 89             PUSHW X 
  86  0025 88             PUSH A 
  87  0026 aeffff         LDW X, #0xFFFF 
  88  0029 a632          loop1: LD A, #50 
  89  002b 4a            loop2: DEC A 
  90  002c 26fd           JRNE loop2 
  91  002e 5a             DECW X 
  92  002f 26f8           JRNE loop1 
  93  0031 84             POP A 
  94  0032 85             POPW X 
  96                     ; 69 	InitDevice();
  99  0033 cd0000        	call	_InitDevice
 101  0036               L12:
 102                     ; 73 		if(Delay_Timeout())
 104  0036 cd0000        	call	_Delay_Timeout
 106  0039 4d            	tnz	a
 107  003a 27fa          	jreq	L12
 108                     ; 75 			Toggle_Power_Switch();
 110  003c cd0000        	call	_Toggle_Power_Switch
 112                     ; 78 			send_Data_UART(14, pText);
 114  003f be00          	ldw	x,_pText
 115  0041 89            	pushw	x
 116  0042 a60e          	ld	a,#14
 117  0044 cd0000        	call	_send_Data_UART
 119  0047 85            	popw	x
 120  0048 20ec          	jra	L12
 155                     ; 92 void assert_failed(uint8_t* file, uint32_t line)
 155                     ; 93 { 
 156                     .text:	section	.text,new
 157  0000               _assert_failed:
 161  0000               L54:
 162  0000 20fe          	jra	L54
 175                     	xdef	_main
 176                     	xref.b	_pText
 177                     	xref	_send_Data_UART
 178                     	xref	_Toggle_Power_Switch
 179                     	xref	_Delay_Timeout
 180                     	xref	_InitDevice
 181                     	xdef	_assert_failed
 200                     	end
