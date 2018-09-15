   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  16                     	bsct
  17  0000               L31_counter_1s:
  18  0000 000003e8      	dc.l	1000
  19  0004               L51_flag_1s:
  20  0004 00            	dc.b	0
  21  0005               _pText:
  22  0005 0000          	dc.w	L71
  56                     ; 26 void InitDevice()
  56                     ; 27 {
  58                     .text:	section	.text,new
  59  0000               _InitDevice:
  63                     ; 28 	Set_Device_Clk();
  65  0000 cd0000        	call	L3_Set_Device_Clk
  67                     ; 29 	Set_Device_GPIO();
  69  0003 cd0000        	call	L5_Set_Device_GPIO
  71                     ; 30 	Set_Device_TIM4();
  73  0006 cd0000        	call	L7_Set_Device_TIM4
  75                     ; 31 	Set_Device_UART();
  77  0009 cd0000        	call	L11_Set_Device_UART
  79                     ; 32 	Enable_Carrier();
  81  000c cd0000        	call	_Enable_Carrier
  83                     ; 33 }
  86  000f 81            	ret
 110                     ; 35 static void Set_Device_Clk()
 110                     ; 36 {
 111                     .text:	section	.text,new
 112  0000               L3_Set_Device_Clk:
 116                     ; 37 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV8);
 118  0000 a618          	ld	a,#24
 119  0002 cd0000        	call	_CLK_HSIPrescalerConfig
 121                     ; 38 }
 124  0005 81            	ret
 148                     ; 40 static void Set_Device_GPIO()
 148                     ; 41 {
 149                     .text:	section	.text,new
 150  0000               L5_Set_Device_GPIO:
 154                     ; 43 	GPIO_Init(GPIOA, GPIO_PIN_1, GPIO_MODE_IN_PU_NO_IT); // pin 1
 156  0000 4b40          	push	#64
 157  0002 4b02          	push	#2
 158  0004 ae5000        	ldw	x,#20480
 159  0007 cd0000        	call	_GPIO_Init
 161  000a 85            	popw	x
 162                     ; 44 	GPIO_Init(GPIOA, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT); // pin 5
 164  000b 4b40          	push	#64
 165  000d 4b08          	push	#8
 166  000f ae5000        	ldw	x,#20480
 167  0012 cd0000        	call	_GPIO_Init
 169  0015 85            	popw	x
 170                     ; 45 	GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_PP_LOW_FAST); // pin 6 (PB4 has no pull-up - configure it as output low)
 172  0016 4be0          	push	#224
 173  0018 4b10          	push	#16
 174  001a ae5005        	ldw	x,#20485
 175  001d cd0000        	call	_GPIO_Init
 177  0020 85            	popw	x
 178                     ; 46 	GPIO_Init(GPIOC, GPIO_PIN_3, GPIO_MODE_IN_PU_NO_IT); // pin 7
 180  0021 4b40          	push	#64
 181  0023 4b08          	push	#8
 182  0025 ae500a        	ldw	x,#20490
 183  0028 cd0000        	call	_GPIO_Init
 185  002b 85            	popw	x
 186                     ; 47 	GPIO_Init(GPIOC, GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT); // pin 8
 188  002c 4b40          	push	#64
 189  002e 4b40          	push	#64
 190  0030 ae500a        	ldw	x,#20490
 191  0033 cd0000        	call	_GPIO_Init
 193  0036 85            	popw	x
 194                     ; 49 	GPIO_Init(POWER_SW_PORT, POWER_SW_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 196  0037 4be0          	push	#224
 197  0039 4b08          	push	#8
 198  003b ae5000        	ldw	x,#20480
 199  003e cd0000        	call	_GPIO_Init
 201  0041 85            	popw	x
 202                     ; 50 	GPIO_Init(CARRIER_PORT, CARRIER_PIN, GPIO_MODE_OUT_PP_LOW_FAST);
 204  0042 4be0          	push	#224
 205  0044 4b20          	push	#32
 206  0046 ae500a        	ldw	x,#20490
 207  0049 cd0000        	call	_GPIO_Init
 209  004c 85            	popw	x
 210                     ; 51 }
 213  004d 81            	ret
 241                     ; 53 static void Set_Device_TIM4()
 241                     ; 54 {
 242                     .text:	section	.text,new
 243  0000               L7_Set_Device_TIM4:
 247                     ; 65   TIM4_TimeBaseInit(TIM4_PRESCALER_16, TIM4_PERIOD); //TIM4_TimeBaseInit(TIM4_PRESCALER_128, TIM4_PERIOD);
 249  0000 ae047c        	ldw	x,#1148
 250  0003 cd0000        	call	_TIM4_TimeBaseInit
 252                     ; 67   TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 254  0006 a601          	ld	a,#1
 255  0008 cd0000        	call	_TIM4_ClearFlag
 257                     ; 69   TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 259  000b ae0101        	ldw	x,#257
 260  000e cd0000        	call	_TIM4_ITConfig
 262                     ; 72   enableInterrupts();
 265  0011 9a            rim
 267                     ; 75   TIM4_Cmd(ENABLE);
 270  0012 a601          	ld	a,#1
 271  0014 cd0000        	call	_TIM4_Cmd
 273                     ; 76 }
 276  0017 81            	ret
 303                     ; 78 static void Set_Device_UART()
 303                     ; 79 {
 304                     .text:	section	.text,new
 305  0000               L11_Set_Device_UART:
 309                     ; 81 	UART1_DeInit();
 311  0000 cd0000        	call	_UART1_DeInit
 313                     ; 92 	UART1_Init((uint32_t)9600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO,
 313                     ; 93                 UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
 315  0003 4b0c          	push	#12
 316  0005 4b80          	push	#128
 317  0007 4b00          	push	#0
 318  0009 4b00          	push	#0
 319  000b 4b00          	push	#0
 320  000d ae2580        	ldw	x,#9600
 321  0010 89            	pushw	x
 322  0011 ae0000        	ldw	x,#0
 323  0014 89            	pushw	x
 324  0015 cd0000        	call	_UART1_Init
 326  0018 5b09          	addw	sp,#9
 327                     ; 98 	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);
 329  001a 4b01          	push	#1
 330  001c ae0205        	ldw	x,#517
 331  001f cd0000        	call	_UART1_ITConfig
 333  0022 84            	pop	a
 334                     ; 101 	enableInterrupts();    
 337  0023 9a            rim
 339                     ; 107 }
 343  0024 81            	ret
 368                     ; 109 void Enable_Carrier()
 368                     ; 110 {
 369                     .text:	section	.text,new
 370  0000               _Enable_Carrier:
 374                     ; 111 	CLK_CCOCmd(ENABLE);
 376  0000 a601          	ld	a,#1
 377  0002 cd0000        	call	_CLK_CCOCmd
 379                     ; 112 	CLK_CCOConfig(CLK_OUTPUT_HSI);
 381  0005 4f            	clr	a
 382  0006 cd0000        	call	_CLK_CCOConfig
 384                     ; 113 }
 387  0009 81            	ret
 411                     ; 115 void Disable_Carrier()
 411                     ; 116 {
 412                     .text:	section	.text,new
 413  0000               _Disable_Carrier:
 417                     ; 117 	CLK_CCOCmd(DISABLE);
 419  0000 4f            	clr	a
 420  0001 cd0000        	call	_CLK_CCOCmd
 422                     ; 118 }
 425  0004 81            	ret
 450                     ; 120 void Timer_OVF()
 450                     ; 121 {
 451                     .text:	section	.text,new
 452  0000               _Timer_OVF:
 456                     ; 122 	counter_1s--;
 458  0000 ae0000        	ldw	x,#L31_counter_1s
 459  0003 a601          	ld	a,#1
 460  0005 cd0000        	call	c_lgsbc
 462                     ; 123 	if(!counter_1s)
 464  0008 ae0000        	ldw	x,#L31_counter_1s
 465  000b cd0000        	call	c_lzmp
 467  000e 260e          	jrne	L721
 468                     ; 125 		flag_1s = 1;
 470  0010 35010004      	mov	L51_flag_1s,#1
 471                     ; 126 		counter_1s = DELAY_1s;
 473  0014 ae03e8        	ldw	x,#1000
 474  0017 bf02          	ldw	L31_counter_1s+2,x
 475  0019 ae0000        	ldw	x,#0
 476  001c bf00          	ldw	L31_counter_1s,x
 477  001e               L721:
 478                     ; 128 }
 481  001e 81            	ret
 516                     ; 130 uint8_t Delay_Timeout()
 516                     ; 131 {
 517                     .text:	section	.text,new
 518  0000               _Delay_Timeout:
 520  0000 88            	push	a
 521       00000001      OFST:	set	1
 524                     ; 134 	fl = flag_1s;
 526  0001 b604          	ld	a,L51_flag_1s
 527  0003 6b01          	ld	(OFST+0,sp),a
 529                     ; 135   flag_1s = 0;
 531  0005 3f04          	clr	L51_flag_1s
 532                     ; 136 	return fl;
 534  0007 7b01          	ld	a,(OFST+0,sp)
 537  0009 5b01          	addw	sp,#1
 538  000b 81            	ret
 563                     ; 139 void Toggle_Power_Switch()
 563                     ; 140 {
 564                     .text:	section	.text,new
 565  0000               _Toggle_Power_Switch:
 569                     ; 141 	GPIO_WriteReverse(POWER_SW_PORT, POWER_SW_PIN);
 571  0000 4b08          	push	#8
 572  0002 ae5000        	ldw	x,#20480
 573  0005 cd0000        	call	_GPIO_WriteReverse
 575  0008 84            	pop	a
 576                     ; 142 }
 579  0009 81            	ret
 604                     ; 144 void Enable_Power_Switch()
 604                     ; 145 {
 605                     .text:	section	.text,new
 606  0000               _Enable_Power_Switch:
 610                     ; 146 	GPIO_WriteHigh(POWER_SW_PORT, POWER_SW_PIN);
 612  0000 4b08          	push	#8
 613  0002 ae5000        	ldw	x,#20480
 614  0005 cd0000        	call	_GPIO_WriteHigh
 616  0008 84            	pop	a
 617                     ; 147 }
 620  0009 81            	ret
 645                     ; 149 void Disable_Power_Switch()
 645                     ; 150 {
 646                     .text:	section	.text,new
 647  0000               _Disable_Power_Switch:
 651                     ; 151 	GPIO_WriteLow(POWER_SW_PORT, POWER_SW_PIN);
 653  0000 4b08          	push	#8
 654  0002 ae5000        	ldw	x,#20480
 655  0005 cd0000        	call	_GPIO_WriteLow
 657  0008 84            	pop	a
 658                     ; 152 }
 661  0009 81            	ret
 707                     ; 154 void send_Data_UART(uint8_t size, uint8_t *data)
 707                     ; 155 {
 708                     .text:	section	.text,new
 709  0000               _send_Data_UART:
 711  0000 88            	push	a
 712       00000000      OFST:	set	0
 715                     ; 156 	if(!size)
 717  0001 4d            	tnz	a
 718  0002 261b          	jrne	L522
 719                     ; 157 		return;
 722  0004 84            	pop	a
 723  0005 81            	ret
 724  0006               L332:
 725                     ; 160 		while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET){
 727  0006 ae0080        	ldw	x,#128
 728  0009 cd0000        	call	_UART1_GetFlagStatus
 730  000c 4d            	tnz	a
 731  000d 27f7          	jreq	L332
 732                     ; 162 			UART1_SendData8(*data++);
 734  000f 1e04          	ldw	x,(OFST+4,sp)
 735  0011 1c0001        	addw	x,#1
 736  0014 1f04          	ldw	(OFST+4,sp),x
 737  0016 1d0001        	subw	x,#1
 738  0019 f6            	ld	a,(x)
 739  001a cd0000        	call	_UART1_SendData8
 741                     ; 163 			size--;
 743  001d 0a01          	dec	(OFST+1,sp)
 744  001f               L522:
 745                     ; 159 	while(size){
 747  001f 0d01          	tnz	(OFST+1,sp)
 748  0021 26e3          	jrne	L332
 749                     ; 165 }
 752  0023 84            	pop	a
 753  0024 81            	ret
 796                     	xdef	_Disable_Power_Switch
 797                     	xdef	_Enable_Power_Switch
 798                     	xdef	_pText
 799                     	xdef	_send_Data_UART
 800                     	xdef	_Toggle_Power_Switch
 801                     	xdef	_Timer_OVF
 802                     	xdef	_Delay_Timeout
 803                     	xdef	_Disable_Carrier
 804                     	xdef	_Enable_Carrier
 805                     	xdef	_InitDevice
 806                     	xref	_UART1_GetFlagStatus
 807                     	xref	_UART1_SendData8
 808                     	xref	_UART1_ITConfig
 809                     	xref	_UART1_Init
 810                     	xref	_UART1_DeInit
 811                     	xref	_TIM4_ClearFlag
 812                     	xref	_TIM4_ITConfig
 813                     	xref	_TIM4_Cmd
 814                     	xref	_TIM4_TimeBaseInit
 815                     	xref	_GPIO_WriteReverse
 816                     	xref	_GPIO_WriteLow
 817                     	xref	_GPIO_WriteHigh
 818                     	xref	_GPIO_Init
 819                     	xref	_CLK_CCOConfig
 820                     	xref	_CLK_HSIPrescalerConfig
 821                     	xref	_CLK_CCOCmd
 822                     .const:	section	.text
 823  0000               L71:
 824  0000 4d2d4b4f5041  	dc.b	"M-KOPA SMART PANEL"
 825  0012 20504c432054  	dc.b	" PLC TEST",10,0
 845                     	xref	c_lzmp
 846                     	xref	c_lgsbc
 847                     	end
