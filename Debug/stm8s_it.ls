   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.11.12 - 20 Jun 2018
   3                     ; Generator (Limited) V4.4.8 - 20 Jun 2018
  45                     ; 51 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  45                     ; 52 {
  46                     .text:	section	.text,new
  47  0000               f_NonHandledInterrupt:
  51                     ; 56 }
  54  0000 80            	iret
  76                     ; 64 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  76                     ; 65 {
  77                     .text:	section	.text,new
  78  0000               f_TRAP_IRQHandler:
  82                     ; 69 }
  85  0000 80            	iret
 107                     ; 75 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 107                     ; 76 {
 108                     .text:	section	.text,new
 109  0000               f_TLI_IRQHandler:
 113                     ; 80 }
 116  0000 80            	iret
 138                     ; 87 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 138                     ; 88 {
 139                     .text:	section	.text,new
 140  0000               f_AWU_IRQHandler:
 144                     ; 92 }
 147  0000 80            	iret
 169                     ; 99 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 169                     ; 100 {
 170                     .text:	section	.text,new
 171  0000               f_CLK_IRQHandler:
 175                     ; 104 }
 178  0000 80            	iret
 201                     ; 111 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 201                     ; 112 {
 202                     .text:	section	.text,new
 203  0000               f_EXTI_PORTA_IRQHandler:
 207                     ; 116 }
 210  0000 80            	iret
 233                     ; 123 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 233                     ; 124 {
 234                     .text:	section	.text,new
 235  0000               f_EXTI_PORTB_IRQHandler:
 239                     ; 128 }
 242  0000 80            	iret
 265                     ; 135 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 265                     ; 136 {
 266                     .text:	section	.text,new
 267  0000               f_EXTI_PORTC_IRQHandler:
 271                     ; 140 }
 274  0000 80            	iret
 297                     ; 147 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 297                     ; 148 {
 298                     .text:	section	.text,new
 299  0000               f_EXTI_PORTD_IRQHandler:
 303                     ; 152 }
 306  0000 80            	iret
 329                     ; 159 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 329                     ; 160 {
 330                     .text:	section	.text,new
 331  0000               f_EXTI_PORTE_IRQHandler:
 335                     ; 164 }
 338  0000 80            	iret
 360                     ; 210 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 360                     ; 211 {
 361                     .text:	section	.text,new
 362  0000               f_SPI_IRQHandler:
 366                     ; 215 }
 369  0000 80            	iret
 392                     ; 222 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 392                     ; 223 {
 393                     .text:	section	.text,new
 394  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 398                     ; 227 }
 401  0000 80            	iret
 424                     ; 234 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 424                     ; 235 {
 425                     .text:	section	.text,new
 426  0000               f_TIM1_CAP_COM_IRQHandler:
 430                     ; 239 }
 433  0000 80            	iret
 456                     ; 271  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 456                     ; 272 {
 457                     .text:	section	.text,new
 458  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 462                     ; 276 }
 465  0000 80            	iret
 488                     ; 283  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 488                     ; 284 {
 489                     .text:	section	.text,new
 490  0000               f_TIM2_CAP_COM_IRQHandler:
 494                     ; 288 }
 497  0000 80            	iret
 520                     ; 325  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 520                     ; 326 {
 521                     .text:	section	.text,new
 522  0000               f_UART1_TX_IRQHandler:
 526                     ; 330 }
 529  0000 80            	iret
 552                     ; 337  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 552                     ; 338 {
 553                     .text:	section	.text,new
 554  0000               f_UART1_RX_IRQHandler:
 558                     ; 342 }
 561  0000 80            	iret
 583                     ; 350 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 583                     ; 351 {
 584                     .text:	section	.text,new
 585  0000               f_I2C_IRQHandler:
 589                     ; 355 }
 592  0000 80            	iret
 614                     ; 430  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 614                     ; 431 {
 615                     .text:	section	.text,new
 616  0000               f_ADC1_IRQHandler:
 620                     ; 436     return;
 623  0000 80            	iret
 648                     ; 459 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 648                     ; 460 {
 649                     .text:	section	.text,new
 650  0000               f_TIM4_UPD_OVF_IRQHandler:
 652  0000 8a            	push	cc
 653  0001 84            	pop	a
 654  0002 a4bf          	and	a,#191
 655  0004 88            	push	a
 656  0005 86            	pop	cc
 657  0006 3b0002        	push	c_x+2
 658  0009 be00          	ldw	x,c_x
 659  000b 89            	pushw	x
 660  000c 3b0002        	push	c_y+2
 661  000f be00          	ldw	x,c_y
 662  0011 89            	pushw	x
 665                     ; 464 	Timer_OVF();
 667  0012 cd0000        	call	_Timer_OVF
 669                     ; 468   TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 671  0015 a601          	ld	a,#1
 672  0017 cd0000        	call	_TIM4_ClearITPendingBit
 674                     ; 470 }
 677  001a 85            	popw	x
 678  001b bf00          	ldw	c_y,x
 679  001d 320002        	pop	c_y+2
 680  0020 85            	popw	x
 681  0021 bf00          	ldw	c_x,x
 682  0023 320002        	pop	c_x+2
 683  0026 80            	iret
 706                     ; 478 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 706                     ; 479 {
 707                     .text:	section	.text,new
 708  0000               f_EEPROM_EEC_IRQHandler:
 712                     ; 483 }
 715  0000 80            	iret
 727                     	xref	_Timer_OVF
 728                     	xdef	f_EEPROM_EEC_IRQHandler
 729                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 730                     	xdef	f_ADC1_IRQHandler
 731                     	xdef	f_I2C_IRQHandler
 732                     	xdef	f_UART1_RX_IRQHandler
 733                     	xdef	f_UART1_TX_IRQHandler
 734                     	xdef	f_TIM2_CAP_COM_IRQHandler
 735                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 736                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 737                     	xdef	f_TIM1_CAP_COM_IRQHandler
 738                     	xdef	f_SPI_IRQHandler
 739                     	xdef	f_EXTI_PORTE_IRQHandler
 740                     	xdef	f_EXTI_PORTD_IRQHandler
 741                     	xdef	f_EXTI_PORTC_IRQHandler
 742                     	xdef	f_EXTI_PORTB_IRQHandler
 743                     	xdef	f_EXTI_PORTA_IRQHandler
 744                     	xdef	f_CLK_IRQHandler
 745                     	xdef	f_AWU_IRQHandler
 746                     	xdef	f_TLI_IRQHandler
 747                     	xdef	f_TRAP_IRQHandler
 748                     	xdef	f_NonHandledInterrupt
 749                     	xref	_TIM4_ClearITPendingBit
 750                     	xref.b	c_x
 751                     	xref.b	c_y
 770                     	end
